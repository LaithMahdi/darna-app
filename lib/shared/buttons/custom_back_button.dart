import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/constants/app_color.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key, this.icon = LucideIcons.chevronLeft});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, size: 24, color: AppColor.black),
      onPressed: () => GoRouter.of(context).pop(),
      style: IconButton.styleFrom(
        padding: EdgeInsets.zero,
        fixedSize: const Size(40, 40),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
