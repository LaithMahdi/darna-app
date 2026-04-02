import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/config.dart';
import '../../../core/functions/show_toast.dart';
import '../../notifications/models/notification_model.dart';
import '../../notifications/service/notification_service.dart';
import '../../../shared/buttons/ghost_button.dart';
import '../../../shared/buttons/primary_button.dart';
import '../../../shared/spacer/spacer.dart';
import '../data/statuses_data.dart';
import '../enums/status_enum.dart';
import '../models/task_model.dart';
import '../view_models/task_view_model.dart';
import 'task_status_button_modal_bottom_sheet.dart';
import 'task_title_modal_bottom_sheet.dart';

final _taskStatusSavingProvider = StateProvider.autoDispose
    .family<bool, String>((ref, taskId) => false);
final _taskStatusSelectionProvider = StateProvider.autoDispose
    .family<StatusEnum, String>((ref, taskId) => StatusEnum.ToDo);

class TaskChangeStatusModalBottomSheet extends ConsumerStatefulWidget {
  const TaskChangeStatusModalBottomSheet({super.key, required this.task});

  final TaskModel task;

  @override
  ConsumerState<TaskChangeStatusModalBottomSheet> createState() =>
      _TaskChangeStatusModalBottomSheetState();
}

class _TaskChangeStatusModalBottomSheetState
    extends ConsumerState<TaskChangeStatusModalBottomSheet> {
  @override
  void initState() {
    super.initState();
    ref.read(_taskStatusSelectionProvider(widget.task.id).notifier).state =
        widget.task.status;
  }

  Future<void> _saveStatus() async {
    final isSaving = ref.read(_taskStatusSavingProvider(widget.task.id));
    final selectedStatus = ref.read(
      _taskStatusSelectionProvider(widget.task.id),
    );

    if (isSaving) return;
    if (selectedStatus == widget.task.status) {
      Navigator.of(context).pop();
      return;
    }

    ref.read(_taskStatusSavingProvider(widget.task.id).notifier).state = true;

    final service = ref.read(taskServiceProvider);
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      if (!mounted) return;
      ref.read(_taskStatusSavingProvider(widget.task.id).notifier).state =
          false;
      showToast(context, 'You must login first.', isError: true);
      return;
    }

    final result = await service.updateTaskStatus(
      taskId: widget.task.id,
      fromStatus: widget.task.status,
      status: selectedStatus,
      changedBy: currentUser.uid,
    );

    if (!mounted) return;

    ref.read(_taskStatusSavingProvider(widget.task.id).notifier).state = false;

    result.fold((error) => showToast(context, error, isError: true), (_) async {
      final recipients = <String>{
        ...widget.task.assignedUserIds,
        if ((widget.task.createdBy ?? '').isNotEmpty) widget.task.createdBy!,
      };

      final statusLabel = _statusLabel(selectedStatus);

      try {
        await Future.wait(
          recipients.map(
            (userId) => NotificationService().createNotification(
              userId: userId,
              title: 'Task Status Updated',
              message: '"${widget.task.title}" is now $statusLabel.',
              type: NotificationType.taskReminder,
              metadata: {
                'taskId': widget.task.id,
                'taskTitle': widget.task.title,
                'fromStatus': _statusLabel(widget.task.status),
                'toStatus': statusLabel,
                'changedBy': currentUser.uid,
              },
            ),
          ),
        );
      } catch (_) {
        // Task update succeeded even if notification write fails.
      }

      if (!mounted) return;
      showToast(context, 'Task status updated successfully!');
      Navigator.of(context).pop();
    });
  }

  String _statusLabel(StatusEnum status) {
    switch (status) {
      case StatusEnum.ToDo:
        return 'To Do';
      case StatusEnum.InProgress:
        return 'In Progress';
      case StatusEnum.Completed:
        return 'Completed';
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedStatus = ref.watch(
      _taskStatusSelectionProvider(widget.task.id),
    );
    final isSaving = ref.watch(_taskStatusSavingProvider(widget.task.id));

    return Container(
      padding: Config.defaultPadding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 52,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          VerticalSpacer(14),
          TaskTitleModalBottomSheet(title: widget.task.title),
          VerticalSpacer(10),
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: statusesData.length,
              separatorBuilder: (_, __) => VerticalSpacer(10),
              itemBuilder: (context, index) {
                final status = statusesData[index];
                return TaskStatusButtonModalBottomSheet(
                  status: status,
                  isSelected: selectedStatus == status.status,
                  onTap: () {
                    ref
                        .read(
                          _taskStatusSelectionProvider(widget.task.id).notifier,
                        )
                        .state = status
                        .status;
                  },
                );
              },
            ),
          ),
          VerticalSpacer(20),
          Row(
            spacing: 15,
            children: [
              Expanded(
                child: GhostButton(
                  text: 'Cancel',
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Expanded(
                child: PrimaryButton(
                  text: 'Save',
                  isLoading: isSaving,
                  onPressed: _saveStatus,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
