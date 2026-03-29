import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/constants/app_style.dart';
import '../icones/custom_prefix_icon.dart';

class BottomSheetTitle extends StatelessWidget {
  const BottomSheetTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppStyle.styleBold18),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomPrefixIcon(icon: LucideIcons.x),
        ),
      ],
    );
  }
}
