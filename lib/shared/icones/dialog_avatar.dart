import 'package:flutter/material.dart';
import '../../core/constants/app_color.dart';

class DialogAvatar extends StatelessWidget {
  const DialogAvatar({
    super.key,
    required this.icon,
    this.text,
    this.textStyle,
    this.color,
    this.backgroundColor,
    this.radius,
    this.iconSize,
  });

  final IconData icon;
  final String? text;
  final TextStyle? textStyle;
  final Color? color;
  final Color? backgroundColor;
  final double? radius;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor:
          backgroundColor ?? AppColor.success.withValues(alpha: .2),
      radius: radius ?? 35,
      child: text != null
          ? Text("$text", style: textStyle)
          : Icon(icon, size: iconSize ?? 35, color: color ?? AppColor.success),
    );
  }
}
