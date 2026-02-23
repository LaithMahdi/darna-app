import 'package:flutter/material.dart';
import '../config.dart';
import 'app_color.dart';
import 'app_style.dart';

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
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColor.white,
      showDragHandle: true,
      dragHandleSize: Size(100, 7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      constraints: BoxConstraints(maxHeight: 500),
      dragHandleColor: AppColor.whiteDA,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColor.primary,
      foregroundColor: AppColor.white,
      shape: CircleBorder(),
      highlightElevation: 0,
      elevation: 0,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: AppColor.white,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
