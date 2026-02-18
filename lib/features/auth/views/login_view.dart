import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/config.dart';
import '../../../core/constants/app_image.dart';
import '../../../routes/routes.dart';
import '../../../shared/buttons/custom_text_icon_button.dart';
import '../../../shared/logo.dart';
import '../../../shared/spacer/spacer.dart';
import '../widgets/auth_text_button.dart';
import '../widgets/login_form.dart';
import '../widgets/login_or_text_lines.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: Config.defaultPadding,
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  VerticalSpacer(44),
                  Logo(),
                  VerticalSpacer(41),
                  LoginForm(),
                  VerticalSpacer(23),
                  LoginOrTextLines(),
                  VerticalSpacer(30),
                  CustomTextIconButton(
                    text: "Continue with Google",
                    iconPath: AppImage.imagesGoogle,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: AuthTextButton(
              label: "Don't have an account? ",
              subLabel: "Sign Up",
              onPressed: () => GoRouter.of(context).push(Routes.register),
            ),
          ),
        ],
      ),
    );
  }
}
