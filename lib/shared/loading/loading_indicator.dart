import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../core/constants/app_color.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.color, this.size = 40});

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      color: color ?? AppColor.primary,
      size: size,
      duration: Duration(milliseconds: 800),
    );
  }
}
