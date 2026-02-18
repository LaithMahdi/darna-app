import 'package:flutter/material.dart';
import '../../../core/config.dart';
import '../../../shared/buttons/custom_back_button.dart';
import '../../../shared/text/sub_label.dart';
import '../widgets/forgot_password_form.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        title: Text("Forgot Password"),
      ),
      body: ListView(
        padding: Config.defaultPadding,
        children: [
          SubLabel(
            text:
                "Enter the email associated with your account and we’ll send an email with code to reset your password",
          ),
          ForgotPasswordForm(),
        ],
      ),
    );
  }
}
