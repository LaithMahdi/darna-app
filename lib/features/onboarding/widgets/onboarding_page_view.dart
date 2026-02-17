import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../shared/spacer/spacer.dart';
import '../data/onboarding_data.dart';

class OnboardingPageView extends StatelessWidget {
  const OnboardingPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      onPageChanged: (value) {},
      // physics: const NeverScrollableScrollPhysics(),
      itemCount: onboardingData.length,
      itemBuilder: (context, index) {
        final data = onboardingData[index];
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(data.image, width: 301, height: 301),
            VerticalSpacer(25),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.6,
              child: Text(
                data.title,
                textAlign: TextAlign.center,
                style: AppStyle.styleBold18,
              ),
            ),
            VerticalSpacer(18),
            Text(
              data.description,
              textAlign: TextAlign.center,
              style: AppStyle.styleMedium13.copyWith(color: AppColor.grey9A),
            ),
          ],
        );
      },
    );
  }
}
