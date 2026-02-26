import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/app_style.dart';
import '../icones/custom_prefix_icon.dart';

class UserBadge extends StatelessWidget {
  const UserBadge({super.key, this.isAdmin = false});

  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isAdmin
            ? AppColor.gold.withValues(alpha: .2)
            : AppColor.grey9A.withValues(alpha: .2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        spacing: 5,
        children: [
          CustomPrefixIcon(
            icon: isAdmin ? LucideIcons.crown : LucideIcons.user,
            color: isAdmin ? AppColor.gold : AppColor.grey9A,
            size: 16,
          ),
          Text(
            isAdmin ? "Admin" : "Member",
            style: AppStyle.styleSemiBold10.copyWith(
              color: isAdmin ? AppColor.gold : AppColor.grey9A,
            ),
          ),
        ],
      ),
    );
  }
}
