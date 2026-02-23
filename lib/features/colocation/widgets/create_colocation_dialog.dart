import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/constants/app_color.dart';
import '../../../shared/buttons/copy_button.dart';
import '../../../shared/buttons/primary_button.dart';
import '../../../shared/forms/input.dart';
import '../../../shared/spacer/spacer.dart';
import '../../../shared/text/dialog_description.dart';
import '../../../shared/text/dialog_title.dart';

class CreateColocationDialog extends StatefulWidget {
  const CreateColocationDialog({super.key});

  @override
  State<CreateColocationDialog> createState() => _CreateColocationDialogState();
}

class _CreateColocationDialogState extends State<CreateColocationDialog> {
  final TextEditingController _codeController = TextEditingController(
    text: "ABCD1234",
  );
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Icon(
                LucideIcons.badgeCheck,
                size: 58,
                color: AppColor.success,
              ),
            ),
            VerticalSpacer(16),
            DialogTitle(title: "Colocation Created Successfully!"),
            DialogDescription(
              description:
                  "Your shared home has been set up. Invite your roommates using the code below to start managing tasks and expenses together.",
            ),
            VerticalSpacer(16),
            Input(
              hintText: "Colocation Code",
              controller: _codeController,
              readOnly: true,
              suffixIcon: CopyButton(code: _codeController.text),
            ),

            VerticalSpacer(16),
            PrimaryButton(text: "Share Code", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
