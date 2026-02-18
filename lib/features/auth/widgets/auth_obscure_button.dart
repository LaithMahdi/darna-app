import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../shared/icones/custom_prefix_icon.dart';

class AuthObscureButton extends StatelessWidget {
  const AuthObscureButton({
    super.key,
    required this.isObscure,
    required this.onPressed,
  });

  final bool isObscure;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: CustomPrefixIcon(
        icon: isObscure ? LucideIcons.eyeOff : LucideIcons.eye,
      ),
    );
  }
}
