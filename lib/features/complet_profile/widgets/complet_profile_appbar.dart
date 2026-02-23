import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';

class CompletProfileAppbar extends StatelessWidget {
  const CompletProfileAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Text(
            'Complete Your Profile',
            style: AppStyle.styleSemiBold18.copyWith(color: AppColor.white),
          ),
          Text(
            'Help us personalize your experience.',
            style: AppStyle.styleMedium13.copyWith(color: AppColor.greyF0),
          ),
        ],
      ),
    );
  }
}
