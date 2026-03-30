import 'package:flutter/material.dart';
import '../../../core/config.dart';
import '../../../shared/buttons/ghost_button.dart';
import '../../../shared/buttons/primary_button.dart';
import '../../../shared/spacer/spacer.dart';
import '../data/statuses_data.dart';
import '../models/task_model.dart';
import 'task_status_button_modal_bottom_sheet.dart';
import 'task_title_modal_bottom_sheet.dart';

class TaskChangeStatusModalBottomSheet extends StatelessWidget {
  const TaskChangeStatusModalBottomSheet({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Config.defaultPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TaskTitleModalBottomSheet(title: task.title),
          VerticalSpacer(24),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 15,
              children: List.generate(statusesData.length, (index) {
                final status = statusesData[index];
                return TaskStatusButtonModalBottomSheet(
                  status: status,
                  isSelected: task.status == status.status,
                  onTap: () {},
                );
              }),
            ),
          ),
          VerticalSpacer(30),
          Row(
            spacing: 15,
            children: [
              Expanded(
                child: GhostButton(text: "Cancel", onPressed: () {}),
              ),
              Expanded(
                child: PrimaryButton(text: "Save", onPressed: () {}),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
