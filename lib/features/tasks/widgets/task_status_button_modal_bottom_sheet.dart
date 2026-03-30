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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.success.withValues(alpha: .2)
              : AppColor.greyF9,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? AppColor.success : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              status.label,
              style: AppStyle.styleSemiBold14.copyWith(
                color: isSelected ? AppColor.success : AppColor.black21,
              ),
            ),
            isSelected
                ? CustomPrefixIcon(
                    icon: LucideIcons.circleCheck500,
                    color: AppColor.success,
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
