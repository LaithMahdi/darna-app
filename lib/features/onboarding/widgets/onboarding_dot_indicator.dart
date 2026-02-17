import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_color.dart';
import '../../../shared/dots/dot_indicator.dart';
import '../view_models/onboarding_view_model.dart';

class OnboardingDotIndicator extends ConsumerWidget {
  const OnboardingDotIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingViewModelProvider);

    return Row(
      spacing: 10,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(state.pages.length, (index) {
        return DotIndicator(
          activeColor: AppColor.primary,
          inactiveColor: AppColor.greyF0,
          isActive: state.currentPage == index,
        );
      }),
    );
  }
}
