import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/functions/format_date.dart';
import '../../../core/functions/show_toast.dart';
import '../../../shared/dialogs/confirmation_dialog.dart';
import '../enums/status_enum.dart';
import '../models/task_model.dart';
import '../service/task_service.dart';
import 'task_view_model.dart';

final taskDetailViewModelProvider = Provider<TaskDetailViewModel>((ref) {
  final service = ref.watch(taskServiceProvider);
  return TaskDetailViewModel(service: service, auth: FirebaseAuth.instance);
});

final taskDetailTaskProvider = StreamProvider.autoDispose
    .family<TaskModel?, String>((ref, taskId) {
      final service = ref.watch(taskServiceProvider);
      return service.watchTaskById(taskId: taskId);
    });

final taskDetailUserNamesProvider = FutureProvider.autoDispose
    .family<Map<String, String>, String>((ref, userIdsKey) async {
      if (userIdsKey.trim().isEmpty) {
        return <String, String>{};
      }

      final service = ref.watch(taskServiceProvider);
      final userIds = userIdsKey
          .split('|')
          .map((id) => id.trim())
          .where((id) => id.isNotEmpty)
          .toSet();

      return service.resolveUserNames(userIds: userIds);
    });

class TaskDetailViewModel {
  final TaskService service;
  final FirebaseAuth auth;

  TaskDetailViewModel({required this.service, required this.auth});

  String statusLabel(StatusEnum status) {
    switch (status) {
      case StatusEnum.Completed:
        return 'Completed';
      case StatusEnum.InProgress:
        return 'In Progress';
      case StatusEnum.ToDo:
        return 'Pending';
    }
  }

  Color statusColor(StatusEnum status) {
    switch (status) {
      case StatusEnum.Completed:
        return AppColor.success;
      case StatusEnum.InProgress:
        return AppColor.gold;
      case StatusEnum.ToDo:
        return AppColor.blueSky02;
    }
  }

  String formatDueDate(DateTime? dueDate) {
    if (dueDate == null) return 'No due date';
    return FormatDate.formatToDayMonthYear(dueDate);
  }

  String formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'Not available';
    return DateFormat('EEE, d MMM yyyy • HH:mm').format(dateTime);
  }

  List<TaskStatusHistoryEntry> sortHistory(TaskModel task) {
    final history = [...task.statusHistory]
      ..sort((a, b) => a.changedAt.compareTo(b.changedAt));
    return history;
  }

  String buildUserIdsKey(Iterable<String> userIds) {
    final normalized =
        userIds
            .map((id) => id.trim())
            .where((id) => id.isNotEmpty)
            .toList(growable: false)
          ..sort();

    return normalized.join('|');
  }

  bool canDelete(TaskModel currentTask) {
    final currentUser = auth.currentUser;
    return currentUser != null &&
        currentTask.createdBy == currentUser.uid &&
        currentTask.status == StatusEnum.ToDo;
  }

  Future<void> deleteTask({
    required BuildContext context,
    required TaskModel currentTask,
    required IconData icon,
  }) async {
    final confirm = await ConfirmationDialog.show(
      context: context,
      title: 'Delete Task',
      description: 'This task is pending. Delete it permanently?',
      icon: icon,
      confirmText: 'Delete',
      cancelText: 'Cancel',
    );

    if (confirm != true) return;
    if (!context.mounted) return;

    final currentUser = auth.currentUser;
    if (currentUser == null) {
      showToast(context, 'You must login first.', isError: true);
      return;
    }

    final result = await service.deleteTaskIfPending(
      taskId: currentTask.id,
      ownerId: currentUser.uid,
    );

    if (!context.mounted) return;

    result.fold((error) => showToast(context, error, isError: true), (_) {
      showToast(context, 'Task deleted successfully.');
      Navigator.of(context).pop();
    });
  }
}
