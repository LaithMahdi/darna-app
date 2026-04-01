import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../models/notification_model.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback? onTap;
  final VoidCallback? onDismiss;

  const NotificationCard({
    super.key,
    required this.notification,
    this.onTap,
    this.onDismiss,
  });

  IconData _getIconForType() {
    switch (notification.type) {
      case NotificationType.taskAssigned:
        return LucideIcons.clipboard;
      case NotificationType.taskCompleted:
        return LucideIcons.check;
      case NotificationType.taskReminder:
        return LucideIcons.bell;
      case NotificationType.houseExpense:
        return LucideIcons.circleDollarSign;
      case NotificationType.memberJoined:
        return LucideIcons.userPlus;
      default:
        return LucideIcons.info;
    }
  }

  Color _getColorForType() {
    switch (notification.type) {
      case NotificationType.taskAssigned:
        return AppColor.primary;
      case NotificationType.taskCompleted:
        return AppColor.success;
      case NotificationType.taskReminder:
        return AppColor.gold;
      case NotificationType.houseExpense:
        return AppColor.blue02;
      case NotificationType.memberJoined:
        return AppColor.primary;
      default:
        return AppColor.grey9A;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColorForType();
    final icon = _getIconForType();

    return Material(
      color: AppColor.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: notification.isRead
                ? AppColor.white
                : AppColor.primary.withValues(alpha: .05),
            border: Border.all(
              color: notification.isRead
                  ? AppColor.greyF9
                  : color.withValues(alpha: .2),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: .15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Expanded(
                child: Column(
                  spacing: 6,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: AppStyle.styleSemiBold13.copyWith(
                              color: AppColor.black21,
                              fontWeight: notification.isRead
                                  ? FontWeight.w500
                                  : FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (!notification.isRead)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    Text(
                      notification.message,
                      style: AppStyle.styleMedium12.copyWith(
                        color: AppColor.grey9A,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      notification.timeAgo,
                      style: AppStyle.styleMedium12.copyWith(
                        color: AppColor.grey9A,
                      ),
                    ),
                  ],
                ),
              ),
              if (onDismiss != null)
                GestureDetector(
                  onTap: onDismiss,
                  child: Icon(LucideIcons.x, size: 18, color: AppColor.grey9A),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
