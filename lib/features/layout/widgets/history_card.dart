import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../core/functions/format_date.dart';
import '../../../shared/icones/dialog_avatar.dart';
import '../../tasks/models/task_model.dart';

class HistoryCard extends StatelessWidget {
  final TaskModel task;
  final String userName;
  final VoidCallback? onTap;

  const HistoryCard({
    super.key,
    required this.task,
    required this.userName,
    this.onTap,
  });

  String _getActionText() {
    if (task.statusHistory.isEmpty) {
      return 'created a task';
    }
    final lastHistory = task.statusHistory.last;
    return 'changed status to ${lastHistory.to.name}';
  }

  String _getTimeAgo() {
    final targetDate = task.updatedAt ?? task.createdAt ?? DateTime.now();
    final now = DateTime.now();
    final difference = now.difference(targetDate);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return FormatDate.formatToDayMonthYear(targetDate);
    }
  }

  String _getUserInitials() {
    final parts = userName.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return userName[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          decoration: BoxDecoration(
            color: AppColor.white,
            border: Border.all(color: AppColor.greyF9),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            spacing: 12,
            children: [
              DialogAvatar(
                text: _getUserInitials(),
                icon: Icons.person,
                radius: 24,
                backgroundColor: AppColor.primary.withValues(alpha: .15),
                textStyle: AppStyle.styleBold13.copyWith(
                  color: AppColor.primary,
                ),
              ),
              Expanded(
                child: Column(
                  spacing: 6,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: userName,
                        style: AppStyle.styleBold12.copyWith(
                          color: AppColor.black21,
                        ),
                        children: [
                          TextSpan(
                            text: ' ${_getActionText()}',
                            style: AppStyle.styleMedium12.copyWith(
                              color: AppColor.black21,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        text: task.title,
                        style: AppStyle.styleRegular12.copyWith(
                          color: AppColor.black21,
                        ),
                        children: [
                          TextSpan(
                            text: ' • ${_getTimeAgo()}',
                            style: AppStyle.styleMedium12.copyWith(
                              color: AppColor.grey9A,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
