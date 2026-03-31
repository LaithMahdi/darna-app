import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../shared/icones/custom_prefix_icon.dart';
import '../models/status_model.dart';

class TaskStatusButtonModalBottomSheet extends StatelessWidget {
  const TaskStatusButtonModalBottomSheet({
    super.key,
    required this.status,
    this.isSelected = false,
    required this.onTap,
  });

  final StatusModel status;
  final bool isSelected;
  final VoidCallback onTap;

  Color get _statusColor {
    switch (status.status.name) {
      case 'Completed':
        return AppColor.success;
      case 'InProgress':
        return AppColor.gold;
      default:
        return AppColor.blueSky02;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 240),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? statusColor.withValues(alpha: .16)
              : AppColor.greyF9,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? statusColor : AppColor.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 10,
              children: [
                Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
                ),
                Text(
                  status.label,
                  style: AppStyle.styleSemiBold14.copyWith(
                    color: isSelected ? statusColor : AppColor.black21,
                  ),
                ),
              ],
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: isSelected ? 1 : 0,
              child: CustomPrefixIcon(
                icon: LucideIcons.circleCheck500,
                color: statusColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
