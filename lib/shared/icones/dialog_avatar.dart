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
    this.borderRadius,
    this.isCircle = true,
  });

  final IconData icon;
  final String? text;
  final TextStyle? textStyle;
  final Color? color;
  final Color? backgroundColor;
  final double? radius;
  final double? iconSize;
  final BorderRadius? borderRadius;
  final bool isCircle;

  @override
  Widget build(BuildContext context) {
    final size = (radius ?? 35) * 2;
    final child = text != null
        ? Text("$text", style: textStyle)
        : Icon(icon, size: iconSize ?? 35, color: color ?? AppColor.success);

    if (isCircle && borderRadius == null) {
      return CircleAvatar(
        backgroundColor:
            backgroundColor ?? AppColor.success.withValues(alpha: .2),
        radius: radius ?? 35,
        child: child,
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColor.success.withValues(alpha: .2),
        borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 35),
      ),
      child: Center(child: child),
    );
  }
}
