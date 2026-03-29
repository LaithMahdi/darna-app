import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../models/privacy_model.dart';

class PrivacyItemCard extends StatelessWidget {
  const PrivacyItemCard({super.key, required this.privacy});

  final PrivacyModel privacy;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          privacy.title,
          style: AppStyle.styleSemiBold13.copyWith(
            color: AppColor.black,
            height: 2.3,
          ),
        ),
        Text(
          privacy.description,
          style: AppStyle.styleRegular12.copyWith(
            color: AppColor.black21,
            height: 2.3,
          ),
        ),
      ],
    );
  }
}
