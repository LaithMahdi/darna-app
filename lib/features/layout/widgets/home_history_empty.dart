import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../shared/icones/custom_prefix_icon.dart';
import '../../tasks/widgets/task_detail_container.dart';

class HomeHistoryEmpty extends StatelessWidget {
  const HomeHistoryEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return TaskDetailContainer(
      child: Column(
        spacing: 8,
        children: [
          CustomPrefixIcon(
            icon: LucideIcons.history,
            size: 40,
            color: AppColor.grey9A,
          ),
          Text(
            'No task history',
            style: AppStyle.styleSemiBold14.copyWith(color: AppColor.grey9A),
          ),
          Text(
            'Complete tasks to see them here',
            style: AppStyle.styleMedium12.copyWith(color: AppColor.grey9A),
          ),
        ],
      ),
    );
  }
}
