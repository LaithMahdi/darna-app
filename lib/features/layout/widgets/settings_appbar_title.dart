import 'package:flutter/material.dart';
import '../../../core/constants/app_style.dart';
import '../../../core/functions/get_greeting_message.dart';

class SettingsAppbarTitle extends StatelessWidget {
  const SettingsAppbarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: "${getGreetingMessage()},",
            style: AppStyle.styleBold22.copyWith(height: 1.7),
            children: [
              TextSpan(
                text: "\nMahdi Laith! 👋",
                style: AppStyle.styleMedium16,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
