import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../enums/status_enum.dart';

class TaskStatusButton extends StatelessWidget {
  const TaskStatusButton({
    super.key,
    required this.status,
    required this.onTap,
  });

  final StatusEnum status;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final statusLabel = status.name == "Completed"
        ? "Completed"
        : status.name == "InProgress"
        ? "In Progress"
        : "Pending";

    final statusColor = status.name == "Completed"
        ? AppColor.success
        : status.name == "InProgress"
        ? AppColor.gold
        : AppColor.blueSky02;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(34),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          color: statusColor.withValues(alpha: .2),
          borderRadius: BorderRadius.circular(34),
        ),
        child: Text(
          statusLabel,
          style: AppStyle.styleSemiBold11.copyWith(color: statusColor),
        ),
      ),
    );
  }
}
