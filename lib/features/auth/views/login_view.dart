import 'package:darna/core/constants/app_color.dart';
import 'package:darna/core/constants/app_image.dart';
import 'package:darna/core/constants/app_style.dart';
import 'package:darna/core/functions/valid_input.dart';
import 'package:darna/shared/forms/input.dart';
import 'package:darna/shared/spacer/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/config.dart';
import '../../../shared/icones/custom_prefix_icon.dart';
import '../../../shared/logo.dart';
import '../../../shared/text/label.dart';
import '../widgets/auth_obscure_button.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: Config.defaultPadding,
        children: [
          VerticalSpacer(44),
          Logo(),
          VerticalSpacer(41),
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
            hintText: "E.g: example@gmail.com",
            controller: TextEditingController(),
            prefixIcon: CustomPrefixIcon(icon: LucideIcons.lock),
            obscureText: true,
            suffixIcon: AuthObscureButton(isObscure: true, onPressed: () {}),
            keyboardType: TextInputType.visiblePassword,
            validator: (value) =>
                validateInput(value, type: InputType.password, min: 8, max: 25),
          ),
          VerticalSpacer(20),
          TextButton(onPressed: () {}, child: const Text("Forgot Password ?")),
        ],
      ),
    );
  }
}
