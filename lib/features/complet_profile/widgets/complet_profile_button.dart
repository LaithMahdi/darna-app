import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';

class CompleteProfileButton extends StatelessWidget {
  const CompleteProfileButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.greyF0,
        foregroundColor: AppColor.black,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Icon(LucideIcons.camera, color: AppColor.black, size: 20),
          Text(
            "Upload Photo",
            style: AppStyle.styleSemiBold14.copyWith(color: AppColor.black),
          ),
        ],
      ),
    );
  }
}
