import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../models/status_model.dart';

class TaskStatusItemButton extends StatelessWidget {
  const TaskStatusItemButton({
    super.key,
    required this.status,
    required this.isSelected,
    required this.onTap,
  });

  final StatusModel status;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(7),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.primary.withValues(alpha: .2)
              : AppColor.grey9A.withValues(alpha: .2),
          borderRadius: BorderRadius.circular(7),
          border: Border.all(
            color: isSelected ? AppColor.primary : AppColor.transparent,
          ),
        ),
        child: Text(
          status.label,
          style: AppStyle.styleMedium12.copyWith(
            color: isSelected ? AppColor.primary : AppColor.grey9A,
          ),
        ),
      ),
    );
  }
}
