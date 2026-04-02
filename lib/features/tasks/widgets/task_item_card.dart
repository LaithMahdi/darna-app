import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../shared/icones/dialog_avatar.dart';
import '../../../shared/spacer/spacer.dart';
import '../models/task_model.dart';
import 'task_status_button.dart';

class TaskItemCard extends StatelessWidget {
  const TaskItemCard({
    super.key,
    required this.task,
    required this.onCardTap,
    required this.onChangeStatusTap,
  });

  final TaskModel task;
  final VoidCallback onCardTap;
  final VoidCallback onChangeStatusTap;

  Color get _statusColor {
    switch (task.status.name) {
      case 'Completed':
        return AppColor.success;
      case 'InProgress':
        return AppColor.gold;
      default:
        return AppColor.blueSky02;
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasDescription = task.description.trim().isNotEmpty;
    final statusColor = _statusColor;

    return Material(
      color: AppColor.transparent,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColor.greyF0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .04),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 5,
              height: 132,
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
                child: Column(
                  spacing: 12,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10,
                      children: [
                        DialogAvatar(
                          icon: LucideIcons.briefcase,
                          iconSize: 18,
                          borderRadius: BorderRadius.circular(10),
                          radius: 20,
                          backgroundColor: statusColor.withValues(alpha: .14),
                          color: statusColor,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: onCardTap,
                            borderRadius: BorderRadius.circular(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 4,
                              children: [
                                Text(
                                  task.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyle.styleSemiBold14.copyWith(
                                    color: AppColor.black21,
                                  ),
                                ),
                                Text(
                                  'Assigned to ${task.affectedBy}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyle.styleMedium12.copyWith(
                                    color: AppColor.grey9A,
                                  ),
                                ),
                                if (hasDescription)
                                  Text(
                                    task.description,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppStyle.styleMedium12.copyWith(
                                      color: AppColor.grey9A,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        TaskStatusButton(
                          status: task.status,
                          onTap: onChangeStatusTap,
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.greyF9,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            LucideIcons.calendarClock,
                            size: 14,
                            color: AppColor.grey9A,
                          ),
                          HorizontalSpacer(7),
                          Expanded(
                            child: Text(
                              task.date.isEmpty ? 'No due date' : task.date,
                              style: AppStyle.styleMedium12.copyWith(
                                color: AppColor.grey9A,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: onCardTap,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppColor.primary.withValues(alpha: .2),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'Open',
                                    style: AppStyle.styleSemiBold11.copyWith(
                                      color: AppColor.primary,
                                    ),
                                  ),
                                  HorizontalSpacer(4),
                                  Icon(
                                    LucideIcons.chevronRight,
                                    size: 13,
                                    color: AppColor.primary,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
