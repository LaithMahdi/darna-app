import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../notifications/models/notification_model.dart';
import '../../notifications/service/notification_service.dart';
import '../../../core/config.dart';
import '../../../core/functions/format_date.dart';
import '../models/colocation_model.dart';
import '../models/colocator_model.dart';

class ColocationService {
  final FirebaseFirestore _firestore;

  ColocationService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<List<ColocationModel>> watchUserColocations({required String userId}) {
    return _firestore
        .collection(Config.colocationsCollection)
        .where('memberIds', arrayContains: userId)
        .snapshots()
        .map((snapshot) {
          final list = snapshot.docs
              .map(ColocationModel.fromFirestore)
              .toList(growable: false);
          list.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
          return list;
        });
  }

  Stream<ColocationModel?> watchColocationById({required String colocationId}) {
    return _firestore
        .collection(Config.colocationsCollection)
        .doc(colocationId)
        .snapshots()
        .map((doc) {
          if (!doc.exists) return null;
          return ColocationModel.fromFirestore(doc);
        });
  }

  Stream<List<ColocatorModel>> watchColocationMembers({
    required String colocationId,
  }) {
    return watchColocationById(colocationId: colocationId).asyncMap((
      col,
    ) async {
      if (col == null || col.memberIds.isEmpty) {
        return <ColocatorModel>[];
      }

      final futures = col.memberIds
          .map(
            (memberId) => _firestore
                .collection(Config.userCollection)
                .doc(memberId)
                .get(),
          )
          .toList(growable: false);

      final docs = await Future.wait(futures);
      final members = docs
          .where((doc) => doc.exists)
          .map((doc) {
            final data = doc.data() ?? <String, dynamic>{};
            final createdAtRaw = data['createdAt'];
            final fullName = ((data['fullName'] ?? '') as String).trim();
            final email = ((data['email'] ?? '') as String).trim();
            final joinedAt = createdAtRaw is Timestamp
                ? createdAtRaw.toDate()
                : DateTime.now();

            return ColocatorModel(
              userId: doc.id,
              fullName: fullName.isNotEmpty ? fullName : email,
              email: email,
              isAdmin: col.createdBy == doc.id,
              joinAt: FormatDate.formatToDayMonthYear(joinedAt),
            );
          })
          .toList(growable: false);

      return members;
    });
  }

  Future<Either<String, ColocationModel>> createColocation({
    required String name,
    required int maxMembers,
    required String createdBy,
  }) async {
    try {
      final colocationRef = _firestore
          .collection(Config.colocationsCollection)
          .doc();
      final now = DateTime.now();

      final colocation = ColocationModel(
        id: colocationRef.id,
        name: name.trim(),
        inviteCode: _generateInviteCode(),
        createdBy: createdBy,
        membersCount: 1,
        maxMembers: maxMembers,
        memberIds: <String>[createdBy],
        createdAt: now,
        updatedAt: now,
      );

      await colocationRef.set(colocation.toJson());
      return Right(colocation);
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Database error while creating colocation.');
    } catch (_) {
      return const Left('Unknown error while creating colocation.');
    }
  }

  Future<Either<String, ColocationModel>> joinColocationByInviteCode({
    required String inviteCode,
    required String userId,
  }) async {
    try {
      final code = inviteCode.trim();
      if (code.isEmpty) {
        return const Left('Invite code is required.');
      }

      final query = await _firestore
          .collection(Config.colocationsCollection)
          .where('inviteCode', isEqualTo: code)
          .limit(1)
          .get();

      if (query.docs.isEmpty) {
        return const Left('Invalid invitation code.');
      }

      final colocationRef = query.docs.first.reference;

      await _firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(colocationRef);
        if (!snapshot.exists) {
          throw StateError('Colocation not found.');
        }

        final data = snapshot.data() ?? <String, dynamic>{};
        final memberIds = List<String>.from(
          data['memberIds'] ?? const <String>[],
        );
        final maxMembers = (data['maxMembers'] ?? 0) as int;

        if (memberIds.contains(userId)) {
          throw StateError('You are already a member of this colocation.');
        }

        if (maxMembers > 0 && memberIds.length >= maxMembers) {
          throw StateError(
            'This colocation reached the maximum members limit.',
          );
        }

        memberIds.add(userId);
        transaction.update(colocationRef, {
          'memberIds': memberIds,
          'membersCount': memberIds.length,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      });

      final updatedDoc = await colocationRef.get();
      return Right(ColocationModel.fromFirestore(updatedDoc));
    } on StateError catch (e) {
      return Left(e.message);
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Database error while joining colocation.');
    } catch (_) {
      return const Left('Unknown error while joining colocation.');
    }
  }

  Future<Either<String, void>> addMemberByEmail({
    required String colocationId,
    required String email,
  }) async {
    try {
      final normalizedEmail = email.trim().toLowerCase();
      final usersCollection = _firestore.collection(Config.userCollection);
      QuerySnapshot<Map<String, dynamic>> userQuery = await usersCollection
          .where('email', isEqualTo: normalizedEmail)
          .limit(1)
          .get();

      if (userQuery.docs.isEmpty && normalizedEmail != email.trim()) {
        userQuery = await usersCollection
            .where('email', isEqualTo: email.trim())
            .limit(1)
            .get();
      }

      if (userQuery.docs.isEmpty) {
        return const Left('No user found with this email.');
      }

      final userId = userQuery.docs.first.id;
      final colocationRef = _firestore
          .collection(Config.colocationsCollection)
          .doc(colocationId);

      await _firestore.runTransaction((transaction) async {
        final colocationSnapshot = await transaction.get(colocationRef);
        if (!colocationSnapshot.exists) {
          throw StateError('Colocation not found.');
        }

        final data = colocationSnapshot.data() ?? <String, dynamic>{};
        final memberIds = List<String>.from(
          data['memberIds'] ?? const <String>[],
        );
        final maxMembers = (data['maxMembers'] ?? 0) as int;

        if (memberIds.contains(userId)) {
          throw StateError('This user is already a member of this colocation.');
        }

        if (maxMembers > 0 && memberIds.length >= maxMembers) {
          throw StateError(
            'This colocation reached the maximum members limit.',
          );
        }

        memberIds.add(userId);
        transaction.update(colocationRef, {
          'memberIds': memberIds,
          'membersCount': memberIds.length,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      });

      return const Right(null);
    } on StateError catch (e) {
      return Left(e.message);
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Database error while adding member.');
    } catch (_) {
      return const Left('Unknown error while adding member.');
    }
  }

  Future<Either<String, void>> removeMember({
    required String colocationId,
    required String adminUserId,
    required String memberUserId,
  }) async {
    try {
      final colocationRef = _firestore
          .collection(Config.colocationsCollection)
          .doc(colocationId);

      late String colocationName;

      await _firestore.runTransaction((transaction) async {
        final colocationSnapshot = await transaction.get(colocationRef);
        if (!colocationSnapshot.exists) {
          throw StateError('Colocation not found.');
        }

        final data = colocationSnapshot.data() ?? <String, dynamic>{};
        final createdBy = (data['createdBy'] ?? '') as String;
        final memberIds = List<String>.from(
          data['memberIds'] ?? const <String>[],
        );
        colocationName = (data['name'] ?? 'your colocation') as String;

        if (createdBy != adminUserId) {
          throw StateError('Only admin can remove members.');
        }

        if (memberUserId == createdBy) {
          throw StateError('Admin cannot remove themselves.');
        }

        if (!memberIds.contains(memberUserId)) {
          throw StateError('Member is not part of this colocation.');
        }

        memberIds.remove(memberUserId);
        transaction.update(colocationRef, {
          'memberIds': memberIds,
          'membersCount': memberIds.length,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      });

      await NotificationService().createNotification(
        userId: memberUserId,
        title: 'Removed from colocation',
        message: 'You were removed from $colocationName.',
        type: NotificationType.system,
        metadata: {'colocationId': colocationId, 'removedBy': adminUserId},
      );

      return const Right(null);
    } on StateError catch (e) {
      return Left(e.message);
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Database error while removing member.');
    } catch (_) {
      return const Left('Unknown error while removing member.');
    }
  }

  String _generateInviteCode() {
    final random = Random();
    return (1000000 + random.nextInt(9000000)).toString();
  }
}
