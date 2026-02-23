import 'package:flutter/material.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/app_style.dart';

class GhostButton extends StatelessWidget {
  const GhostButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.textStyle,
  });

  final String text;
  final VoidCallback onPressed;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.greyF0,
        foregroundColor: AppColor.black,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      child: Text(text, style: textStyle ?? AppStyle.styleSemiBold16),
    );
  }
}
