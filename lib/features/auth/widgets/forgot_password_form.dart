import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/functions/show_toast.dart';
import '../../../core/functions/valid_input.dart';
import '../../../shared/buttons/primary_button.dart';
import '../../../shared/forms/input.dart';
import '../../../shared/icones/custom_prefix_icon.dart';
import '../../../shared/spacer/spacer.dart';
import '../../../shared/text/label.dart';
import '../view_models/auth_view_model.dart';

class ForgotPasswordForm extends ConsumerStatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  ConsumerState<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends ConsumerState<ForgotPasswordForm> {
  final GlobalKey<FormState> _formForgotPasswordKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> onSendResetLink() async {
    final authViewModel = ref.read(authViewModelProvider.notifier);
    final success = await authViewModel.sendPasswordResetEmail(
      email: _emailController.text.trim(),
    );
    if (success && mounted) {
      showToast(
        context,
        'Password reset link has been sent to your email',
        isError: false,
      );
      GoRouter.of(context).pop();
    } else if (mounted) {
      final errorMessage = ref.read(authViewModelProvider).errorMessage;
      showToast(
        context,
        errorMessage ?? 'Failed to send reset link',
        isError: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);

    return Form(
      key: _formForgotPasswordKey,
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
          PrimaryButton(
            text: "Send Reset Link",
            isLoading: authState.isLoading,
            onPressed: () {
              if (_formForgotPasswordKey.currentState!.validate()) {
                onSendResetLink();
              }
            },
          ),
        ],
      ),
    );
  }
}
