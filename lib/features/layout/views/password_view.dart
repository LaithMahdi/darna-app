import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/config.dart';
import '../../../core/functions/show_toast.dart';
import '../../../core/functions/valid_input.dart';
import '../../../shared/buttons/custom_back_button.dart';
import '../../../shared/buttons/primary_button.dart';
import '../../../shared/forms/input.dart';
import '../../../shared/spacer/spacer.dart';
import '../../../shared/text/label.dart';
import '../../../shared/text/sub_label.dart';

class PasswordView extends StatefulWidget {
  const PasswordView({super.key});

  @override
  State<PasswordView> createState() => _PasswordViewState();
}

class _PasswordViewState extends State<PasswordView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _updatePassword() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid || _isSaving) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null || user.email == null) {
      showToast(
        context,
        'Password change is not available for this account.',
        isError: true,
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: _currentPasswordController.text.trim(),
      );

      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(_newPasswordController.text.trim());

      if (!mounted) return;
      showToast(context, 'Password updated successfully!');
      _currentPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      showToast(context, _mapPasswordError(e), isError: true);
    } catch (_) {
      if (!mounted) return;
      showToast(context, 'Failed to update password.', isError: true);
    } finally {
      if (!mounted) return;
      setState(() {
        _isSaving = false;
      });
    }
  }

  String _mapPasswordError(FirebaseAuthException e) {
    switch (e.code) {
      case 'wrong-password':
      case 'invalid-credential':
        return 'Current password is incorrect.';
      case 'weak-password':
        return 'New password is too weak.';
      case 'requires-recent-login':
        return 'Please login again before changing password.';
      default:
        return e.message ?? 'Unable to update password.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Navigator.canPop(context) ? CustomBackButton() : null,
        title: Text('Password'),
      ),
      body: ListView(
        padding: Config.defaultPadding,
        children: [
          SubLabel(
            text:
                'Change your account password. For security, we verify your current password first.',
          ),
          VerticalSpacer(20),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Label(label: 'Current Password'),
                Input(
                  hintText: 'Enter current password',
                  controller: _currentPasswordController,
                  obscureText: true,
                  validator: (value) => validateInput(
                    value,
                    min: 6,
                    max: 50,
                    type: InputType.password,
                  ),
                ),
                VerticalSpacer(18),
                Label(label: 'New Password'),
                Input(
                  hintText: 'Enter new password',
                  controller: _newPasswordController,
                  obscureText: true,
                  validator: (value) => validateInput(
                    value,
                    min: 6,
                    max: 50,
                    type: InputType.password,
                  ),
                ),
                VerticalSpacer(18),
                Label(label: 'Confirm New Password'),
                Input(
                  hintText: 'Re-enter new password',
                  controller: _confirmPasswordController,
                  obscureText: true,
                  validator: (value) => validateConfirmPassword(
                    value,
                    _newPasswordController.text,
                  ),
                ),
                VerticalSpacer(22),
                PrimaryButton(
                  text: 'Update Password',
                  isLoading: _isSaving,
                  onPressed: _updatePassword,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
