import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../shared/icones/dialog_avatar.dart';
import '../../../shared/spacer/spacer.dart';
import '../models/task_user.dart';
import 'task_create_actions_dialog.dart';
import 'task_create_card_dialog.dart';

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

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        width: width * 0.9,
        constraints: const BoxConstraints(maxWidth: 500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColor.primary.withValues(alpha: .1),
                    AppColor.primary.withValues(alpha: .05),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Row(
                children: [
                  DialogAvatar(
                    icon: LucideIcons.users,
                    backgroundColor: AppColor.primary.withValues(alpha: .2),
                    color: AppColor.primary,
                    iconSize: 22,
                    radius: 24,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  const HorizontalSpacer(12),
                  Text(
                    'Select Team Members',
                    style: AppStyle.styleBold18.copyWith(
                      color: AppColor.primary,
                    ),
                  ),
                ],
              ),
            ),
            VerticalSpacer(10),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: availableUsers.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final user = availableUsers[index];
                  final isChecked = tempSelection.contains(user.id);
                  return TaskCreateCardDialog(
                    isChecked: isChecked,
                    onChanged: onChanged,
                    user: user,
                  );
                },
              ),
            ),
            VerticalSpacer(10),
            TaskCreateActionsDialog(tempSelection: tempSelection),
          ],
        ),
      ),
    );
  }
}
