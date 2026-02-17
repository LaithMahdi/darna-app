import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../shared/buttons/custom_filled_icon_button.dart';
import '../../../shared/buttons/custom_outline_icon_button.dart';
import '../view_models/onboarding_view_model.dart';

class OnboardingButtons extends ConsumerWidget {
  const OnboardingButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingViewModelProvider);
    final viewModel = ref.read(onboardingViewModelProvider.notifier);
    double size = 45;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        state.isFirstPage
            ? SizedBox()
            : SizedBox(
                width: size,
                height: size,
                child: CustomOutlineIconButton(
                  icon: LucideIcons.arrowLeft,
                  onPressed: () => viewModel.previousPage(),
                ),
              ),
        SizedBox(
          height: size,
          width: size,
          child: CustomFilledIconButton(
            icon: LucideIcons.arrowRight,
            onPressed: () {
              if (state.isLastPage) {
                viewModel.completeOnboarding();
              } else {
                viewModel.nextPage();
              }
            },
          ),
        ),
      ],
    );
  }
}
