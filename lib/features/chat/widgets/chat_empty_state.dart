import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../shared/icones/custom_prefix_icon.dart';
import '../../../shared/spacer/spacer.dart';

class ChatEmptyState extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData? icon;

  const ChatEmptyState({
    super.key,
    this.title = 'No messages yet',
    this.subtitle = 'Start a conversation',
    this.icon = LucideIcons.messageCircle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomPrefixIcon(
            icon: icon ?? LucideIcons.messageCircle,
            size: 48,
            color: AppColor.grey9A,
          ),
          VerticalSpacer(16),
          Text(
            title,
            style: AppStyle.styleSemiBold16.copyWith(color: AppColor.grey9A),
          ),
          VerticalSpacer(8),
          Text(
            subtitle,
            style: AppStyle.styleMedium13.copyWith(color: AppColor.grey9A),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
