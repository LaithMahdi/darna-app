import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';

class LoginOrTextLines extends StatelessWidget {
  const LoginOrTextLines({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 15,
      children: [
        Expanded(child: Divider(color: AppColor.grey9A)),
        Text(
          "OR",
          style: AppStyle.styleMedium13.copyWith(color: AppColor.grey9A),
        ),
        Expanded(child: Divider(color: AppColor.grey9A)),
      ],
    );
  }
}
