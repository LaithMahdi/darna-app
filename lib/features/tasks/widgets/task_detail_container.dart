import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';

class TaskDetailContainer extends StatelessWidget {
  const TaskDetailContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColor.whiteFB,
        border: Border.all(color: AppColor.greyF0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}
