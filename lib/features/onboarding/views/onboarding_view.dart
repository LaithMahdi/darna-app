import 'package:flutter/material.dart';
import '../widgets/onboarding_buttons.dart';
import '../widgets/onboarding_dot_indicator.dart';
import '../widgets/onboarding_page_view.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 25,
            right: 25,
            top: 0,
            bottom: 0,
            child: OnboardingPageView(),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: MediaQuery.sizeOf(context).height * 0.1,
            child: OnboardingDotIndicator(),
          ),
          Positioned(
            left: 25,
            right: 25,
            bottom: MediaQuery.sizeOf(context).height * 0.05,
            child: OnboardingButtons(),
          ),
        ],
      ),
    );
  }
}
