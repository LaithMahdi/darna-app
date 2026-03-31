import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
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

  String _generateInviteCode() {
    final random = Random();
    return (1000000 + random.nextInt(9000000)).toString();
  }
}
