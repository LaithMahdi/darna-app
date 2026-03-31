import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../data/statuses_data.dart';
import '../view_models/task_view_model.dart';
import 'task_status_item_button.dart';

class TaskStatusSection extends ConsumerWidget {
  const TaskStatusSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedStatus = ref.watch(selectedTaskStatusProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        spacing: 10,
        children: [
          InkWell(
            onTap: () =>
                ref.read(selectedTaskStatusProvider.notifier).state = null,
            borderRadius: BorderRadius.circular(7),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              decoration: BoxDecoration(
                color: selectedStatus == null
                    ? AppColor.primary.withValues(alpha: .2)
                    : AppColor.grey9A.withValues(alpha: .2),
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                  color: selectedStatus == null
                      ? AppColor.primary
                      : AppColor.transparent,
                ),
              ),
              child: Text(
                'All',
                style: AppStyle.styleMedium12.copyWith(
                  color: selectedStatus == null
                      ? AppColor.primary
                      : AppColor.grey9A,
                ),
              ),
            ),
          ),
          ...List.generate(statusesData.length, (index) {
            final status = statusesData[index];
            return TaskStatusItemButton(
              status: status,
              isSelected: selectedStatus == status.status,
              onTap: () {
                ref.read(selectedTaskStatusProvider.notifier).state =
                    status.status;
              },
            );
          }),
        ],
      ),
    );
  }
}
