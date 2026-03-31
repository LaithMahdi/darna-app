import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/constants/app_color.dart';
import '../icones/custom_prefix_icon.dart';

class CopyButton extends StatelessWidget {
  const CopyButton({super.key, required this.code, this.onPressed});

  final String code;
  final Future<void> Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: CustomPrefixIcon(icon: LucideIcons.copy, color: AppColor.black),
      onPressed: () async {
        if (onPressed != null) {
          await onPressed!.call();
          return;
        }

        await Clipboard.setData(ClipboardData(text: code));
      },
    );
  }
}
