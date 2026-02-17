import 'package:flutter/material.dart';
import '../../core/constants/app_color.dart';

class CustomOutlineIconButton extends StatelessWidget {
  const CustomOutlineIconButton({
    super.key,
    required this.icon,
    this.color,
    this.size,
    this.foregroundColor,
    required this.onPressed,
  });

  final IconData icon;
  final Color? color;
  final double? size;
  final Color? foregroundColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton.outlined(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: size ?? 20,
        color: foregroundColor ?? AppColor.primary,
      ),
      style: IconButton.styleFrom(
        side: BorderSide(color: color ?? AppColor.primary),
        foregroundColor: foregroundColor ?? AppColor.primary,
      ),
    );
  }
}
