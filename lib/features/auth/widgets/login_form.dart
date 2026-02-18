import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../core/functions/valid_input.dart';
import '../../../shared/buttons/primary_button.dart';
import '../../../shared/forms/input.dart';
import '../../../shared/icones/custom_prefix_icon.dart';
import '../../../shared/spacer/spacer.dart';
import '../../../shared/text/label.dart';
import 'auth_obscure_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Label(label: "Email Address"),
        Input(
          hintText: "E.g: example@gmail.com",
          controller: TextEditingController(),
          prefixIcon: CustomPrefixIcon(icon: LucideIcons.mail),
          keyboardType: TextInputType.emailAddress,
          validator: (value) =>
              validateInput(value, type: InputType.email, min: 8, max: 150),
        ),
        VerticalSpacer(20),
        Label(label: "Password"),
        Input(
          hintText: "E.g: ********",
          controller: TextEditingController(),
          prefixIcon: CustomPrefixIcon(icon: LucideIcons.lock),
          obscureText: true,
          suffixIcon: AuthObscureButton(isObscure: true, onPressed: () {}),
          keyboardType: TextInputType.visiblePassword,
          validator: (value) =>
              validateInput(value, type: InputType.password, min: 8, max: 25),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: Text(
              "Forgot Password ?",
              style: AppStyle.styleBold12.copyWith(
                color: AppColor.grey9A,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        VerticalSpacer(20),
        PrimaryButton(text: "Sign In", onPressed: () {}),
      ],
    );
  }
}
