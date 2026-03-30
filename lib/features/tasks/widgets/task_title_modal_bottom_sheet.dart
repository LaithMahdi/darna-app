import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/constants/app_style.dart';
import '../../../shared/buttons/custom_back_button.dart';

class TaskTitleModalBottomSheet extends StatelessWidget {
  const TaskTitleModalBottomSheet({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              text: "Change Status : ",
              style: AppStyle.styleMedium18,

              children: [
                TextSpan(text: title, style: AppStyle.styleSemiBold18),
              ],
            ),
          ),
        ),
        CustomBackButton(icon: LucideIcons.x),
      ],
    );
  }
}
