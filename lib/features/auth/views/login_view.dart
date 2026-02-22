import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/config.dart';
import '../../../core/constants/app_image.dart';
import '../../../core/functions/show_toast.dart';
import '../../../core/helper/cacher_helper.dart';
import '../../../routes/routes.dart';
import '../../../shared/buttons/custom_text_icon_button.dart';
import '../../../shared/logo.dart';
import '../../../shared/spacer/spacer.dart';
import '../view_models/auth_view_model.dart';
import '../widgets/auth_text_button.dart';
import '../widgets/login_form.dart';
import '../widgets/login_or_text_lines.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  void onGoogleSignIn(BuildContext context, WidgetRef ref) async {
    final authViewModel = ref.read(authViewModelProvider.notifier);
    final success = await authViewModel.signInWithGoogle();
    if (success && context.mounted) {
      CacherHelper().setCompletProfile(true);
      GoRouter.of(context).go(Routes.completProfile);
    } else if (context.mounted) {
      final errorMessage = ref.read(authViewModelProvider).errorMessage;
      showToast(
        context,
        errorMessage ?? "Google sign-in failed",
        isError: true,
      );
      debugPrint('Google sign-in failed: $errorMessage');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    onPressed: () async => onGoogleSignIn(context, ref),
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
