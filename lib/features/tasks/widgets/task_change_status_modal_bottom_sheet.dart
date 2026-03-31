import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/config.dart';
import '../../../core/functions/show_toast.dart';
import '../../../shared/buttons/ghost_button.dart';
import '../../../shared/buttons/primary_button.dart';
import '../../../shared/spacer/spacer.dart';
import '../data/statuses_data.dart';
import '../enums/status_enum.dart';
import '../models/task_model.dart';
import '../view_models/task_view_model.dart';
import 'task_status_button_modal_bottom_sheet.dart';
import 'task_title_modal_bottom_sheet.dart';

class TaskChangeStatusModalBottomSheet extends ConsumerStatefulWidget {
  const TaskChangeStatusModalBottomSheet({super.key, required this.task});

  final TaskModel task;

  @override
  ConsumerState<TaskChangeStatusModalBottomSheet> createState() =>
      _TaskChangeStatusModalBottomSheetState();
}

class _TaskChangeStatusModalBottomSheetState
    extends ConsumerState<TaskChangeStatusModalBottomSheet> {
  late StatusEnum _selectedStatus;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.task.status;
  }

  Future<void> _saveStatus() async {
    if (_isSaving) return;
    if (_selectedStatus == widget.task.status) {
      Navigator.of(context).pop();
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final service = ref.read(taskServiceProvider);
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      if (!mounted) return;
      setState(() {
        _isSaving = false;
      });
      showToast(context, 'You must login first.', isError: true);
      return;
    }

    final result = await service.updateTaskStatus(
      taskId: widget.task.id,
      fromStatus: widget.task.status,
      status: _selectedStatus,
      changedBy: currentUser.uid,
    );

    if (!mounted) return;

    setState(() {
      _isSaving = false;
    });

    result.fold((error) => showToast(context, error, isError: true), (_) {
      showToast(context, 'Task status updated successfully!');
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  isSelected: _selectedStatus == status.status,
                  onTap: () {
                    setState(() {
                      _selectedStatus = status.status;
                    });
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
                  isLoading: _isSaving,
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
