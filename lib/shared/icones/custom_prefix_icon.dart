import 'package:flutter/material.dart';
import '../../core/constants/app_color.dart';

class CustomPrefixIcon extends StatelessWidget {
  const CustomPrefixIcon({
    super.key,
    required this.icon,
    this.size,
    this.color,
  });

  final IconData icon;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Icon(icon, size: size ?? 20, color: color ?? AppColor.grey9A);
  }
}
