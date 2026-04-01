import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../view_models/notification_view_model.dart';

class NotificationBadge extends ConsumerWidget {
  final String userId;
  final VoidCallback onTap;
  final double iconSize;
  final Color iconColor;

  const NotificationBadge({
    super.key,
    required this.userId,
    required this.onTap,
    this.iconSize = 24,
    this.iconColor = AppColor.black,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unreadCountAsync = ref.watch(unreadCountProvider(userId));

    return unreadCountAsync.when(
      loading: () => GestureDetector(
        onTap: onTap,
        child: Icon(Icons.notifications_none, size: iconSize),
      ),
      error: (error, stack) => GestureDetector(
        onTap: onTap,
        child: Icon(Icons.notifications_none, size: iconSize),
      ),
      data: (unreadCount) {
        return GestureDetector(
          onTap: onTap,
          child: Stack(
            children: [
              Icon(
                unreadCount > 0
                    ? Icons.notifications
                    : Icons.notifications_none,
                size: iconSize,
                color: iconColor,
              ),
              if (unreadCount > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: AppColor.error,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        unreadCount > 9 ? '9+' : '$unreadCount',
                        style: AppStyle.styleBold12.copyWith(
                          color: AppColor.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
