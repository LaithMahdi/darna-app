import 'package:flutter/material.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/app_style.dart';
import '../loading/loading_indicator.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.radius,
    this.width,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? radius;
  final double? width;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: IgnorePointer(
        ignoring: isLoading,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: isLoading
                ? AppColor.primary.withValues(alpha: .6)
                : backgroundColor ?? AppColor.primary,
            foregroundColor: foregroundColor ?? AppColor.white,
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 10),
            ),
            shadowColor: AppColor.primary,
            elevation: isLoading ? 0 : 3,
          ),
          child: isLoading
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 4,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: LoadingIndicator(color: AppColor.white, size: 20),
                    ),

                    Text(
                      "Loading...",
                      style: AppStyle.styleSemiBold16.copyWith(
                        color: foregroundColor ?? AppColor.white,
                      ),
                    ),
                  ],
                )
              : Text(
                  text,
                  style: AppStyle.styleSemiBold16.copyWith(
                    color: foregroundColor ?? AppColor.white,
                  ),
                ),
        ),
      ),
    );
  }
}
