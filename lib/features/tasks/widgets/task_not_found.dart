import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/config.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../shared/spacer/spacer.dart';

class TaskNotFound extends StatelessWidget {
  const TaskNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: Config.defaultPadding,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColor.whiteFB,
            border: Border.all(color: AppColor.greyF0),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: AppColor.primary.withValues(alpha: .14),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  LucideIcons.clipboardList,
                  color: AppColor.primary,
                  size: 28,
                ),
              ),
              VerticalSpacer(12),
              Text('No Tasks Found', style: AppStyle.styleSemiBold16),
              VerticalSpacer(6),
              Text(
                "No tasks yet. Create your first task. Or adjust your filters to see existing tasks.",
                style: AppStyle.styleMedium12.copyWith(color: AppColor.grey9A),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
