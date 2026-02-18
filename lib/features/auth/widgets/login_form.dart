import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../core/functions/valid_input.dart';
import '../../../routes/routes.dart';
import '../../../shared/buttons/primary_button.dart';
import '../../../shared/forms/input.dart';
import '../../../shared/icones/custom_prefix_icon.dart';
import '../../../shared/spacer/spacer.dart';
import '../../../shared/text/label.dart';
import 'auth_obscure_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formLoginKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formLoginKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Label(label: "Email Address"),
          Input(
            hintText: "E.g: example@gmail.com",
            controller: _emailController,
            prefixIcon: CustomPrefixIcon(icon: LucideIcons.mail),
            keyboardType: TextInputType.emailAddress,
            validator: (value) =>
                validateInput(value, type: InputType.email, min: 8, max: 150),
          ),
          VerticalSpacer(20),
          Label(label: "Password"),
          Input(
            hintText: "E.g: ********",
            controller: _passwordController,
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
              onPressed: () => GoRouter.of(context).push(Routes.forgotPassword),
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
      ),
    );
  }
}
