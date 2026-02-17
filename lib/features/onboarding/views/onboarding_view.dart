import 'package:flutter/material.dart';

import '../widgets/onboarding_dot_indicator.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Positioned(
          //   left: 25,
          //   right: 25,
          //   top: 0,
          //   bottom: 0,
          //   child: OnboardingPageView(),
          // ),
          Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery.sizeOf(context).height * 0.2,
            child: OnboardingDotIndicator(),
          ),

          // Positioned(
          //   left: 25,
          //   right: 25,
          //   bottom: MediaQuery.sizeOf(context).height * 0.05,
          //   child: OnboardingButtons(),
          // ),
        ],
      ),
    );
  }
}
