import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../shared/icones/custom_prefix_icon.dart';

class NotificationEmptyData extends StatelessWidget {
  const NotificationEmptyData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 12,
        children: [
          CustomPrefixIcon(
            icon: LucideIcons.bell,
            size: 48,
            color: AppColor.grey9A,
          ),
          Text(
            'No notifications',
            style: AppStyle.styleSemiBold16.copyWith(color: AppColor.grey9A),
          ),
          Text(
            'You\'re all caught up!',
            style: AppStyle.styleMedium13.copyWith(color: AppColor.grey9A),
          ),
        ],
      ),
    );
  }
}
