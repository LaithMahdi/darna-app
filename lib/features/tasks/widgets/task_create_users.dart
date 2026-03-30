import 'package:darna/shared/spacer/spacer.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../models/task_user.dart';
import '../../../shared/buttons/custom_filled_icon_button.dart';
import 'task_create_users_dialog.dart';

class TaskCreateUsers extends StatelessWidget {
  const TaskCreateUsers({
    super.key,
    required this.availableUsers,
    required this.selectedUserIds,
    required this.onUsersSelected,
    required this.onRemoveUser,
  });

  final List<TaskUser> availableUsers;
  final Set<String> selectedUserIds;
  final ValueChanged<Set<String>> onUsersSelected;
  final ValueChanged<String> onRemoveUser;

  Future<void> _showUsersDialog(BuildContext context) async {
    final tempSelection = Set<String>.from(selectedUserIds);

    final result = await showDialog<Set<String>>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return TaskCreateUsersDialog(
              availableUsers: availableUsers,
              tempSelection: tempSelection,
              onChanged: (user, value) {
                setDialogState(() {
                  if (value ?? false) {
                    tempSelection.add(user.id);
                  } else {
                    tempSelection.remove(user.id);
                  }
                });
              },
            );
          },
        );
      },
    );

    if (result != null) {
      onUsersSelected(result);
    }
  }

  List<TaskUser> get _selectedUsers => availableUsers
      .where((user) => selectedUserIds.contains(user.id))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColor.greyF0)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Members', style: AppStyle.styleSemiBold14),
                    SizedBox(height: 2),
                    Text(
                      '${_selectedUsers.length} selected',
                      style: AppStyle.styleRegular12.copyWith(
                        color: AppColor.grey9A,
                      ),
                    ),
                  ],
                ),
              ),
              CustomFilledIconButton(
                icon: LucideIcons.plus,
                onPressed: () => _showUsersDialog(context),
                color: AppColor.greyF0,
                foregroundColor: AppColor.grey9A,
              ),
            ],
          ),
        ),
        VerticalSpacer(10),
        if (_selectedUsers.isEmpty)
          Text(
            'No members selected yet.',
            style: AppStyle.styleRegular12.copyWith(color: AppColor.grey9A),
          )
        else
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _selectedUsers
                .map(
                  (user) => Chip(
                    label: Text(user.name, style: AppStyle.styleMedium12),
                    backgroundColor: AppColor.greyF9,
                    side: BorderSide(color: AppColor.greyF0),
                    deleteIcon: Icon(LucideIcons.x, size: 16),
                    onDeleted: () => onRemoveUser(user.id),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}
