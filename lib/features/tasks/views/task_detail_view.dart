import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/config.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../core/functions/show_toast.dart';
import '../../../shared/buttons/custom_back_button.dart';
import '../../../shared/buttons/ghost_button.dart';
import '../../../shared/buttons/primary_button.dart';
import '../../../shared/dialogs/confirmation_dialog.dart';
import '../../../shared/icones/custom_prefix_icon.dart';
import '../../../shared/spacer/spacer.dart';
import '../enums/status_enum.dart';
import '../models/task_model.dart';
import '../view_models/task_view_model.dart';
import '../widgets/task_change_status_modal_bottom_sheet.dart';

class TaskDetailView extends ConsumerWidget {
  const TaskDetailView({super.key, this.task});

  final TaskModel? task;

  String _statusLabel(StatusEnum status) {
    switch (status) {
      case StatusEnum.Completed:
        return 'Completed';
      case StatusEnum.InProgress:
        return 'In Progress';
      case StatusEnum.ToDo:
        return 'Pending';
    }
  }

  Color _statusColor(StatusEnum status) {
    switch (status) {
      case StatusEnum.Completed:
        return AppColor.success;
      case StatusEnum.InProgress:
        return AppColor.gold;
      case StatusEnum.ToDo:
        return AppColor.blueSky02;
    }
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'Not available';
    return DateFormat('EEE, d MMM yyyy • HH:mm').format(dateTime);
  }

  bool _canDelete(TaskModel currentTask) {
    final currentUser = FirebaseAuth.instance.currentUser;
    return currentUser != null &&
        currentTask.createdBy == currentUser.uid &&
        currentTask.status == StatusEnum.ToDo;
  }

  Future<void> _deleteTask(
    BuildContext context,
    WidgetRef ref,
    TaskModel currentTask,
  ) async {
    final confirm = await ConfirmationDialog.show(
      context: context,
      title: 'Delete Task',
      description: 'This task is pending. Delete it permanently?',
      icon: LucideIcons.trash,
      confirmText: 'Delete',
      cancelText: 'Cancel',
    );

    if (confirm != true) return;

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      showToast(context, 'You must login first.', isError: true);
      return;
    }

    final service = ref.read(taskServiceProvider);
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(taskServiceProvider);

    if (task == null || task!.id.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          leading: CustomBackButton(),
          title: Text('Task Details'),
        ),
        body: Center(child: Text('Task not found.')),
      );
    }

    return StreamBuilder<TaskModel?>(
      stream: service.watchTaskById(taskId: task!.id),
      builder: (context, snapshot) {
        final currentTask = snapshot.data ?? task!;

        return Scaffold(
          appBar: AppBar(
            leading: CustomBackButton(),
            title: Text('Task Details'),
          ),
          body: Builder(
            builder: (context) {
              final history = [...currentTask.statusHistory]
                ..sort((a, b) => a.changedAt.compareTo(b.changedAt));
              final changerIds = history
                  .map((entry) => entry.changedBy)
                  .where((id) => id.trim().isNotEmpty)
                  .toSet();

              return FutureBuilder<Map<String, String>>(
                future: service.resolveUserNames(userIds: changerIds),
                builder: (context, userSnapshot) {
                  final userNames =
                      userSnapshot.data ?? const <String, String>{};

                  return ListView(
                    padding: Config.defaultPadding,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColor.whiteFB,
                          border: Border.all(color: AppColor.greyF0),
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: .03),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        currentTask.title,
                                        style: AppStyle.styleSemiBold16,
                                      ),
                                      VerticalSpacer(6),
                                      Text(
                                        currentTask.description.trim().isEmpty
                                            ? 'No description provided.'
                                            : currentTask.description,
                                        style: AppStyle.styleMedium13.copyWith(
                                          color: AppColor.grey9A,
                                          height: 1.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                HorizontalSpacer(10),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _statusColor(
                                      currentTask.status,
                                    ).withValues(alpha: .15),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    _statusLabel(currentTask.status),
                                    style: AppStyle.styleSemiBold12.copyWith(
                                      color: _statusColor(currentTask.status),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            VerticalSpacer(14),
                            Row(
                              children: [
                                Expanded(
                                  child: _TaskInfoChip(
                                    icon: LucideIcons.user,
                                    label: 'Assigned To',
                                    value: currentTask.affectedBy,
                                  ),
                                ),
                                HorizontalSpacer(8),
                                Expanded(
                                  child: _TaskInfoChip(
                                    icon: LucideIcons.calendarDays,
                                    label: 'Due Date',
                                    value: currentTask.dueDate != null
                                        ? DateFormat(
                                            'd MMM yyyy',
                                          ).format(currentTask.dueDate!)
                                        : 'No due date',
                                  ),
                                ),
                              ],
                            ),
                            VerticalSpacer(8),
                            _TaskInfoChip(
                              icon: LucideIcons.clock3,
                              label: 'Last Update',
                              value: _formatDateTime(currentTask.updatedAt),
                            ),
                          ],
                        ),
                      ),
                      VerticalSpacer(18),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColor.whiteFB,
                          border: Border.all(color: AppColor.greyF0),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  LucideIcons.history,
                                  size: 16,
                                  color: AppColor.primary,
                                ),
                                HorizontalSpacer(8),
                                Text(
                                  'Status Timeline',
                                  style: AppStyle.styleSemiBold14,
                                ),
                              ],
                            ),
                            VerticalSpacer(4),
                            Text(
                              'Track each status update in chronological order.',
                              style: AppStyle.styleMedium12.copyWith(
                                color: AppColor.grey9A,
                              ),
                            ),
                            VerticalSpacer(14),
                            _TaskTimelineTile(
                              title: 'Task created',
                              subtitle: currentTask.createdAt != null
                                  ? DateFormat(
                                      'EEE, d MMM yyyy • HH:mm',
                                    ).format(currentTask.createdAt!)
                                  : 'Creation time unavailable',
                              color: AppColor.primary,
                              isFirst: true,
                              isLast: history.isEmpty,
                            ),
                            if (history.isEmpty)
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 36,
                                  top: 6,
                                ),
                                child: Text(
                                  'No status changes yet.',
                                  style: AppStyle.styleMedium12.copyWith(
                                    color: AppColor.grey9A,
                                  ),
                                ),
                              )
                            else
                              ...List.generate(history.length, (index) {
                                final entry = history[index];
                                final isLast = index == history.length - 1;
                                final updatedBy = entry.changedBy.trim().isEmpty
                                    ? 'Unknown'
                                    : (userNames[entry.changedBy] ??
                                          entry.changedBy);

                                return _TaskTimelineTile(
                                  title:
                                      '${_statusLabel(entry.from)} -> ${_statusLabel(entry.to)}',
                                  subtitle:
                                      '${DateFormat('EEE, d MMM yyyy • HH:mm').format(entry.changedAt)}\nUpdated by: $updatedBy',
                                  color: _statusColor(entry.to),
                                  isFirst: false,
                                  isLast: isLast,
                                );
                              }),
                          ],
                        ),
                      ),
                      VerticalSpacer(20),
                      Row(
                        spacing: 10,
                        children: [
                          Expanded(
                            child: GhostButton(
                              text: 'Change Status',
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  constraints: BoxConstraints(
                                    maxHeight:
                                        MediaQuery.of(context).size.height *
                                        0.7,
                                  ),
                                  builder: (_) =>
                                      TaskChangeStatusModalBottomSheet(
                                        task: currentTask,
                                      ),
                                );
                              },
                            ),
                          ),
                          if (_canDelete(currentTask))
                            Expanded(
                              child: PrimaryButton(
                                text: 'Delete',
                                backgroundColor: AppColor.error,
                                onPressed: () =>
                                    _deleteTask(context, ref, currentTask),
                              ),
                            ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

class _TaskInfoChip extends StatelessWidget {
  const _TaskInfoChip({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.greyF9,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CustomPrefixIcon(icon: icon, color: AppColor.grey9A, size: 15),
          HorizontalSpacer(8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppStyle.styleMedium12.copyWith(
                    color: AppColor.grey9A,
                  ),
                ),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.styleSemiBold12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskTimelineTile extends StatelessWidget {
  const _TaskTimelineTile({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.isFirst,
    required this.isLast,
  });

  final String title;
  final String subtitle;
  final Color color;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 22,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: 2,
                    color: isFirst ? AppColor.transparent : AppColor.greyF0,
                  ),
                ),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                    border: Border.all(color: AppColor.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: .28),
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 2,
                    color: isLast ? AppColor.transparent : AppColor.greyF0,
                  ),
                ),
              ],
            ),
          ),
          HorizontalSpacer(10),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColor.greyF9,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppStyle.styleSemiBold13),
                  VerticalSpacer(2),
                  Text(
                    subtitle,
                    style: AppStyle.styleMedium12.copyWith(
                      color: AppColor.grey9A,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
