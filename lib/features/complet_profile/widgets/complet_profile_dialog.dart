import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../shared/buttons/primary_button.dart';

class CompletProfileDialog extends StatelessWidget {
  const CompletProfileDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        spacing: 15,
        children: [
          Icon(LucideIcons.badgeCheck, size: 70, color: AppColor.primary),
          Text(
            'Are you sure?',
            textAlign: TextAlign.center,
            style: AppStyle.styleBold18,
          ),
        ],
      ),
      content: Text(
        'Your profile is now complete. You can start using the app and explore its features. Thank you for completing your profile!',
        style: AppStyle.styleMedium14.copyWith(color: AppColor.grey),
      ),
      actions: [PrimaryButton(text: "Continue", onPressed: () {})],
    );
  }
}
