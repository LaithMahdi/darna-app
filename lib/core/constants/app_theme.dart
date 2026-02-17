import 'package:flutter/material.dart';
import '../config.dart';
import 'app_color.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    fontFamily: Config.fontFamily,
    primaryColor: AppColor.primary,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary),
  );
}
