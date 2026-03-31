import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/constants/app_style.dart';
import '../../../core/functions/get_greeting_message.dart';
import '../service/settings_service.dart';

class SettingsAppbarTitle extends StatelessWidget {
  const SettingsAppbarTitle({super.key});

  static final SettingsService _settingsService = SettingsService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, authSnapshot) {
        final user = authSnapshot.data;

        if (user == null) {
          return Text.rich(
            TextSpan(
              text: '${getGreetingMessage()},',
              style: AppStyle.styleBold22.copyWith(height: 1.7),
              children: [
                TextSpan(text: '\nUser! 👋', style: AppStyle.styleMedium16),
              ],
            ),
          );
        }

        return FutureBuilder<String>(
          future: _settingsService.getUserName(user),
          builder: (context, nameSnapshot) {
            final userName = (nameSnapshot.data ?? '').trim();
            final safeName = userName.isEmpty ? 'User' : userName;

            return Text.rich(
              TextSpan(
                text: '${getGreetingMessage()},',
                style: AppStyle.styleBold22.copyWith(height: 1.7),
                children: [
                  TextSpan(
                    text: '\n$safeName! 👋',
                    style: AppStyle.styleMedium16,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
