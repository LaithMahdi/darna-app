import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/config.dart';
import '../../../routes/routes.dart';
import '../../../shared/buttons/custom_back_button.dart';
import '../../../shared/logo.dart';
import '../../../shared/spacer/spacer.dart';
import '../widgets/auth_text_button.dart';
import '../widgets/register_form.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: CustomBackButton(), title: Text("Register")),
      body: ListView(
        padding: Config.defaultPadding,
        children: [
          Logo(),
          VerticalSpacer(41),
          RegisterForm(),
          VerticalSpacer(23),
          AuthTextButton(
            label: "Already have an account? ",
            subLabel: "Sign In",
            onPressed: () => GoRouter.of(context).push(Routes.login),
          ),
        ],
      ),
    );
  }
}
