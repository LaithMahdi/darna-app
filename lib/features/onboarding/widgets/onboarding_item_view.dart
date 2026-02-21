import 'package:flutter/material.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../shared/spacer/spacer.dart';
import '../models/onboarding_model.dart';

class OnboardingItemView extends StatelessWidget {
  const OnboardingItemView({super.key, required this.data});

  final OnboardingModel data;

  @override
  Widget build(BuildContext context) {
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
            style: AppStyle.styleBold18.copyWith(height: 1.7),
          ),
        ),
        VerticalSpacer(18),
        Text(
          data.description,
          textAlign: TextAlign.center,
          style: AppStyle.styleMedium13.copyWith(
            color: AppColor.grey9A,
            height: 2.5,
          ),
        ),
      ],
    );
  }
}
