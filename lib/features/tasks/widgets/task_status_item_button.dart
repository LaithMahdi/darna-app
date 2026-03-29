import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../models/status_model.dart';

class TaskStatusItemButton extends StatelessWidget {
  const TaskStatusItemButton({super.key, required this.status});

  final StatusModel status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: AppColor.grey9A.withValues(alpha: .2),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        status.label,
        style: AppStyle.styleMedium12.copyWith(color: AppColor.grey9A),
      ),
    );
  }
}
