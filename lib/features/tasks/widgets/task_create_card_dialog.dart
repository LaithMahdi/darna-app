import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../shared/icones/dialog_avatar.dart';
import '../../../shared/spacer/spacer.dart';
import '../models/task_user.dart';

class TaskCreateCardDialog extends StatelessWidget {
  const TaskCreateCardDialog({
    super.key,
    required this.isChecked,
    required this.onChanged,
    required this.user,
  });

  final bool isChecked;
  final void Function(TaskUser user, bool? value)? onChanged;
  final TaskUser user;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: isChecked ? AppColor.primary : AppColor.greyF0,
          width: isChecked ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: () => onChanged?.call(user, !isChecked),
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              DialogAvatar(
                icon: LucideIcons.users,
                text: user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                backgroundColor: AppColor.primary.withValues(alpha: .2),
                color: AppColor.primary,
                iconSize: 22,
                radius: 24,
                textStyle: AppStyle.styleSemiBold18.copyWith(
                  color: AppColor.primary,
                ),
              ),
              HorizontalSpacer(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: [
                    Text(user.name, style: AppStyle.styleBold14),
                    Text(
                      user.email,
                      style: AppStyle.styleMedium12.copyWith(
                        color: AppColor.grey9A,
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isChecked ? AppColor.primary : Colors.transparent,
                  border: Border.all(
                    color: isChecked ? AppColor.primary : AppColor.grey9A,
                    width: 2,
                  ),
                ),
                child: isChecked
                    ? const Icon(Icons.check, size: 16, color: Colors.white)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
