import 'package:darna/core/functions/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
import '../view_models/auth_view_model.dart';
import 'auth_obscure_button.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final GlobalKey<FormState> _formLoginKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController(
    text: "mahdi@gmail.com",
  );
  final TextEditingController _passwordController = TextEditingController(
    text: "123456789",
  );
  final ValueNotifier<bool> _isPasswordObscure = ValueNotifier<bool>(true);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void onLoggin() async {
    final authViewModel = ref.read(authViewModelProvider.notifier);
    final success = await authViewModel.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (success && mounted) {
      // Navigate to home or main screen after successful login
      // GoRouter.of(context).go(Routes.home);
    } else if (mounted) {
      final errorMessage = ref.read(authViewModelProvider).errorMessage;
      showToast(context, errorMessage ?? "Login failed", isError: true);
      debugPrint('Login failed: $errorMessage');
    }
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
          ValueListenableBuilder<bool>(
            valueListenable: _isPasswordObscure,
            builder: (context, value, child) => Input(
              hintText: "E.g: ********",
              controller: _passwordController,
              prefixIcon: CustomPrefixIcon(icon: LucideIcons.lock),
              obscureText: value,
              suffixIcon: AuthObscureButton(
                isObscure: value,
                onPressed: () {
                  _isPasswordObscure.value = !_isPasswordObscure.value;
                },
              ),
              keyboardType: TextInputType.visiblePassword,
              validator: (value) => validateInput(
                value,
                type: InputType.password,
                min: 8,
                max: 25,
              ),
            ),
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
          PrimaryButton(
            text: "Sign In",
            isLoading: ref.watch(authViewModelProvider).isLoading,
            onPressed: () {
              if (_formLoginKey.currentState!.validate()) {
                onLoggin();
              }
            },
          ),
        ],
      ),
    );
  }
}
