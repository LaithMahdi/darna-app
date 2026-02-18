import 'package:darna/core/constants/app_style.dart';
import 'package:flutter/material.dart';
import '../config.dart';
import 'app_color.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    fontFamily: Config.fontFamily,
    primaryColor: AppColor.primary,
    scaffoldBackgroundColor: AppColor.white,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.white,
      titleTextStyle: AppStyle.styleSemiBold16.copyWith(
        color: AppColor.black,
        fontFamily: Config.fontFamily,
      ),
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary),
  );
}
