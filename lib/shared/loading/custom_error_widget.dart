import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../core/constants/app_color.dart';
import '../../core/constants/app_style.dart';
import '../spacer/spacer.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    this.title = 'Something went wrong',
    this.message = 'Please try again in a moment.',
    this.onRetry,
    this.retryText = 'Retry',
  });

  final String title;
  final String message;
  final VoidCallback? onRetry;
  final String retryText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColor.error.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                LucideIcons.circleAlert,
                color: AppColor.error,
                size: 24,
              ),
            ),
            VerticalSpacer(14),
            Text(
              title,
              style: AppStyle.styleSemiBold16.copyWith(color: AppColor.black21),
              textAlign: TextAlign.center,
            ),
            VerticalSpacer(6),
            Text(
              message,
              style: AppStyle.styleMedium13.copyWith(color: AppColor.grey9A),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              VerticalSpacer(16),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: onRetry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    foregroundColor: AppColor.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(retryText, style: AppStyle.styleSemiBold13),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
