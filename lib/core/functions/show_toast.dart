import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../constants/app_color.dart';
import '../constants/app_style.dart';

showToast(BuildContext context, String description, {bool isError = false}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        spacing: 10,
        children: [
          Icon(
            isError ? LucideIcons.badgeX : LucideIcons.badgeCheck,
            color: AppColor.white,
            size: 26,
          ),
          Expanded(
            child: Column(
              spacing: 7,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isError ? 'Error' : 'Success',
                  style: AppStyle.styleSemiBold14.copyWith(
                    color: AppColor.white,
                  ),
                ),
                Text(
                  description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: AppStyle.styleMedium12.copyWith(color: AppColor.white),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: isError ? AppColor.error : AppColor.success,
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      hitTestBehavior: HitTestBehavior.translucent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
    ),
  );
}
