import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../shared/icones/dialog_avatar.dart';
import '../models/task_model.dart';
import 'task_status_button.dart';

class TaskItemCard extends StatelessWidget {
  const TaskItemCard({super.key, required this.task, required this.onTap});

  final TaskModel task;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.greyF0),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        spacing: 10,
        children: [
          Row(
            spacing: 10,
            children: [
              DialogAvatar(
                icon: LucideIcons.briefcase,
                iconSize: 20,
                borderRadius: BorderRadius.circular(4),
                radius: 22,
                backgroundColor: AppColor.primary.withValues(alpha: .25),
                color: AppColor.primary,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: [
                    Text(
                      task.affectedBy,
                      style: AppStyle.styleMedium12.copyWith(
                        color: AppColor.grey9A,
                      ),
                    ),
                    Text(
                      task.title,
                      style: AppStyle.styleMedium13.copyWith(
                        color: AppColor.black21,
                      ),
                    ),
                  ],
                ),
              ),
              TaskStatusButton(status: task.status, onTap: onTap),
            ],
          ),
          Row(
            spacing: 7,
            children: [
              Icon(LucideIcons.clock, size: 13, color: AppColor.grey9A),
              Text(
                task.date,
                style: AppStyle.styleMedium12.copyWith(color: AppColor.grey9A),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
