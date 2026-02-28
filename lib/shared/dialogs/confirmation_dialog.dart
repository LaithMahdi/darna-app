import 'package:flutter/material.dart';
import '../../core/constants/app_color.dart';
import '../buttons/ghost_button.dart';
import '../buttons/primary_button.dart';
import '../icones/dialog_avatar.dart';
import '../spacer/spacer.dart';
import '../text/dialog_description.dart';
import '../text/dialog_title.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.description,
    this.icon,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.onConfirm,
  });

  final String title;
  final String description;
  final IconData? icon;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.whiteFB,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Center(child: DialogAvatar(icon: icon!)),
              VerticalSpacer(16),
            ],
            DialogTitle(title: title),
            DialogDescription(description: description),
            VerticalSpacer(16),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: GhostButton(
                    text: cancelText,
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                ),
                Expanded(
                  child: PrimaryButton(
                    text: confirmText,
                    onPressed: () {
                      onConfirm?.call();
                      Navigator.of(context).pop(true);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String description,
    IconData? icon,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    VoidCallback? onConfirm,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => ConfirmationDialog(
        title: title,
        description: description,
        icon: icon,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
      ),
    );
  }
}
