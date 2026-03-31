import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';

import '../../../core/config.dart';
import '../enums/status_enum.dart';
import '../models/task_model.dart';
import '../models/task_user.dart';

class TaskService {
  final FirebaseFirestore _firestore;

  TaskService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<List<TaskModel>> watchTasksForUser({required String userId}) {
    return _firestore.collection(Config.tasksCollection).snapshots().map((
      snapshot,
    ) {
      final tasks = snapshot.docs
          .map(TaskModel.fromFirestore)
          .where(
            (task) =>
                task.createdBy == userId ||
                task.assignedUserIds.contains(userId),
          )
          .toList(growable: false);
      tasks.sort((a, b) {
        final aDate = a.dueDate ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bDate = b.dueDate ?? DateTime.fromMillisecondsSinceEpoch(0);
        return aDate.compareTo(bDate);
      });
      return tasks;
    });
  }

  Stream<TaskModel?> watchTaskById({required String taskId}) {
    return _firestore
        .collection(Config.tasksCollection)
        .doc(taskId)
        .snapshots()
        .map((doc) {
          if (!doc.exists) return null;
          return TaskModel.fromFirestore(doc);
        });
  }

  Future<Either<String, List<TaskUser>>> fetchTaskUsers({
    required String currentUserId,
  }) async {
    try {
      final snapshot = await _firestore.collection(Config.userCollection).get();
      final users = snapshot.docs
          .where((doc) => doc.id != currentUserId)
          .map((doc) {
            final data = doc.data();
            final email = (data['email'] ?? '') as String;
            final fullName = (data['fullName'] ?? '') as String;
            final name = fullName.trim().isEmpty ? email : fullName;
            return TaskUser(id: doc.id, name: name, email: email);
          })
          .toList(growable: false);

      return Right(users);
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Failed to load users.');
    } catch (_) {
      return const Left('Unknown error while loading users.');
    }
  }

  Future<Map<String, String>> resolveUserNames({
    required Set<String> userIds,
  }) async {
    if (userIds.isEmpty) return <String, String>{};

    final entries = await Future.wait(
      userIds.map((id) async {
        try {
          final doc = await _firestore
              .collection(Config.userCollection)
              .doc(id)
              .get();
          final data = doc.data() ?? <String, dynamic>{};
          final fullName = (data['fullName'] ?? '') as String;
          final email = (data['email'] ?? '') as String;
          final displayName = fullName.trim().isNotEmpty
              ? fullName.trim()
              : (email.trim().isNotEmpty ? email.trim() : id);
          return MapEntry(id, displayName);
        } catch (_) {
          return MapEntry(id, id);
        }
      }),
    );

    return Map<String, String>.fromEntries(entries);
  }

  Future<Either<String, TaskModel>> createTask({
    required String title,
    required String description,
    required String dueDateText,
    required List<TaskUser> selectedUsers,
    required String createdBy,
  }) async {
    try {
      final now = DateTime.now();
      final dueDate = DateFormat('d MMMM yyyy').parse(dueDateText);
      final affectedBy = selectedUsers.isEmpty
          ? 'Unassigned'
          : selectedUsers.first.name;
      final assignedUserIds = selectedUsers
          .map((user) => user.id)
          .toList(growable: false);

      final ref = _firestore.collection(Config.tasksCollection).doc();
      final task = TaskModel(
        id: ref.id,
        title: title.trim(),
        description: description.trim(),
        affectedBy: affectedBy,
        assignedUserIds: assignedUserIds,
        status: StatusEnum.ToDo,
        date: DateFormat('MMM d, HH:mm').format(dueDate),
        dueDate: dueDate,
        createdBy: createdBy,
        createdAt: now,
        updatedAt: now,
        statusHistory: <TaskStatusHistoryEntry>[
          TaskStatusHistoryEntry(
            from: StatusEnum.ToDo,
            to: StatusEnum.ToDo,
            changedBy: createdBy,
            changedAt: now,
          ),
        ],
      );

      await ref.set(task.toJson());
      return Right(task);
    } on FormatException {
      return const Left('Invalid due date format.');
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Failed to create task.');
    } catch (_) {
      return const Left('Unknown error while creating task.');
    }
  }

  Future<Either<String, void>> updateTaskStatus({
    required String taskId,
    required StatusEnum fromStatus,
    required StatusEnum status,
    required String changedBy,
  }) async {
    try {
      final now = DateTime.now();
      await _firestore.collection(Config.tasksCollection).doc(taskId).update({
        'status': _statusToString(status),
        'updatedAt': Timestamp.fromDate(now),
        'statusHistory': FieldValue.arrayUnion([
          {
            'from': _statusToString(fromStatus),
            'to': _statusToString(status),
            'changedBy': changedBy,
            'changedAt': Timestamp.fromDate(now),
          },
        ]),
      });
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Failed to update task status.');
    } catch (_) {
      return const Left('Unknown error while updating task status.');
    }
  }

  Future<Either<String, void>> deleteTaskIfPending({
    required String taskId,
    required String ownerId,
  }) async {
    try {
      final docRef = _firestore.collection(Config.tasksCollection).doc(taskId);
      await _firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(docRef);
        if (!snapshot.exists) {
          throw StateError('Task not found.');
        }

        final data = snapshot.data() ?? <String, dynamic>{};
        final createdBy = (data['createdBy'] ?? '') as String;
        final status = (data['status'] ?? 'ToDo') as String;

        if (createdBy != ownerId) {
          throw StateError('Only the task owner can delete this task.');
        }

        if (status != 'ToDo') {
          throw StateError('Only pending tasks can be deleted.');
        }

        transaction.delete(docRef);
      });

      return const Right(null);
    } on StateError catch (e) {
      return Left(e.message);
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Failed to delete task.');
    } catch (_) {
      return const Left('Unknown error while deleting task.');
    }
  }

  String _statusToString(StatusEnum status) {
    switch (status) {
      case StatusEnum.Completed:
        return 'Completed';
      case StatusEnum.InProgress:
        return 'InProgress';
      case StatusEnum.ToDo:
        return 'ToDo';
    }
  }
}
