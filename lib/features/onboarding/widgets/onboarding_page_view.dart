import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_models/onboarding_view_model.dart';
import 'onboarding_item_view.dart';

class OnboardingPageView extends ConsumerStatefulWidget {
  const OnboardingPageView({super.key});

  @override
  ConsumerState<OnboardingPageView> createState() => _OnboardingPageViewState();
}

class _OnboardingPageViewState extends ConsumerState<OnboardingPageView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingViewModelProvider);
    final viewModel = ref.read(onboardingViewModelProvider.notifier);

    ref.listen<OnboardingState>(onboardingViewModelProvider, (previous, next) {
      if (previous?.currentPage != next.currentPage) {
        _pageController.animateToPage(
          next.currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });

    return PageView.builder(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: (value) => viewModel.onPageChanged(value),
      itemCount: state.pages.length,
      itemBuilder: (context, index) {
        final data = state.pages[index];
        return OnboardingItemView(data: data);
      },
    );
  }
}
