import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../shared/buttons/ghost_button.dart';
import '../../../shared/buttons/primary_button.dart';
import '../models/task_user.dart';

class TaskCreateUsersDialog extends StatelessWidget {
  const TaskCreateUsersDialog({
    super.key,
    required this.availableUsers,
    required this.tempSelection,
    required this.onChanged,
  });

  final List<TaskUser> availableUsers;
  final Set<String> tempSelection;
  final void Function(TaskUser user, bool? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return AlertDialog(
      title: Text('Choose users', style: AppStyle.styleSemiBold16),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: availableUsers.length,
          separatorBuilder: (_, __) => Divider(color: AppColor.greyF0),
          itemBuilder: (context, index) {
            final user = availableUsers[index];
            final isChecked = tempSelection.contains(user.id);
            return CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: isChecked,
              activeColor: AppColor.primary,
              title: Text(user.name, style: AppStyle.styleMedium14),
              subtitle: Text(
                user.email,
                style: AppStyle.styleRegular12.copyWith(color: AppColor.grey9A),
              ),
              onChanged: (value) => onChanged?.call(user, value),
            );
          },
        ),
      ),
      actions: [
        GhostButton(onPressed: () => Navigator.pop(context), text: "Cancel"),
        PrimaryButton(
          text: "Add",
          width: width / 2.5,
          onPressed: () => Navigator.pop(context, tempSelection),
        ),
      ],
    );
  }
}
