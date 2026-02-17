import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';
import '../../../shared/dots/dot_indicator.dart';
import '../data/onboarding_data.dart';

class OnboardingDotIndicator extends StatelessWidget {
  const OnboardingDotIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(onboardingData.length, (index) {
        return DotIndicator(
          activeColor: AppColor.primary,
          inactiveColor: AppColor.greyF0,
          isActive: false,
        );
      }),
    );
  }
}
