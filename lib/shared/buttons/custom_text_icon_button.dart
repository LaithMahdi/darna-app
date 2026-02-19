import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/app_style.dart';

class CustomTextIconButton extends StatelessWidget {
  const CustomTextIconButton({
    super.key,
    required this.text,
    required this.iconPath,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.isLoading = false,
  });

  final String text;
  final String iconPath;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColor.white,
        foregroundColor: foregroundColor ?? AppColor.black,
        padding: EdgeInsets.all(15),
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: AppColor.whiteDA),
        ),
      ),
      child: isLoading
          ? SpinKitCircle(color: foregroundColor ?? AppColor.black, size: 22)
          : Row(
              spacing: 10,
              children: [
                Image.asset(iconPath, width: 22, height: 22),
                Text(
                  text,
                  style: AppStyle.styleMedium13.copyWith(
                    color: foregroundColor ?? AppColor.black,
                  ),
                ),
              ],
            ),
    );
  }
}
