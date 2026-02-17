import 'package:flutter/material.dart';
import '../../core/constants/app_color.dart';

class CustomFilledIconButton extends StatelessWidget {
  const CustomFilledIconButton({
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
    return IconButton.filled(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: size ?? 20,
        color: foregroundColor ?? AppColor.white,
      ),
      style: IconButton.styleFrom(
        backgroundColor: color ?? AppColor.primary,
        foregroundColor: foregroundColor ?? AppColor.white,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
    );
  }
}
