import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../shared/buttons/custom_filled_icon_button.dart';
import '../../../shared/buttons/custom_outline_icon_button.dart';

class OnboardingButtons extends StatelessWidget {
  const OnboardingButtons({super.key});

  @override
  Widget build(BuildContext context) {
    double size = 45;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CustomOutlineIconButton(
            icon: LucideIcons.arrowLeft,
            onPressed: () {},
          ),
        ),
        SizedBox(
          height: size,
          width: size,
          child: CustomFilledIconButton(
            icon: LucideIcons.arrowRight,
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
