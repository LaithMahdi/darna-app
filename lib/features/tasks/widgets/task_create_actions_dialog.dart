import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../shared/buttons/ghost_button.dart';
import '../../../shared/buttons/primary_button.dart';

class TaskCreateActionsDialog extends StatelessWidget {
  const TaskCreateActionsDialog({super.key, required this.tempSelection});

  final Set<String> tempSelection;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 5, 25, 15),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColor.greyF0)),
      ),
      child: Row(
        spacing: 10,
        children: [
          Expanded(
            child: GhostButton(
              onPressed: () => Navigator.pop(context),
              textStyle: AppStyle.styleMedium14,
              text: "Cancel",
            ),
          ),
          Expanded(
            child: PrimaryButton(
              text: "Add Selected",
              width: double.infinity,
              height: 45,
              enableElevation: false,
              textStyle: AppStyle.styleMedium14,
              onPressed: () => Navigator.pop(context, tempSelection),
            ),
          ),
        ],
      ),
    );
  }
}
