import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/config.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../shared/spacer/spacer.dart';
import '../models/task_model.dart';
import '../view_models/task_detail_view_model.dart';
import 'task_detail_container.dart';
import 'task_detail_info_chip.dart';
import 'task_detail_time_line_tile.dart';

class TaskDetailListView extends StatelessWidget {
  const TaskDetailListView({
    super.key,
    required this.currentTask,
    required this.viewModel,
    required this.history,
    required this.userNames,
  });

  final TaskModel currentTask;
  final TaskDetailViewModel viewModel;
  final List<TaskStatusHistoryEntry> history;
  final Map<String, String> userNames;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: Config.defaultPadding,
      children: [
        TaskDetailContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentTask.title,
                          style: AppStyle.styleSemiBold16,
                        ),
                        VerticalSpacer(6),
                        Text(
                          currentTask.description.trim().isEmpty
                              ? 'No description provided.'
                              : currentTask.description,
                          style: AppStyle.styleMedium13.copyWith(
                            color: AppColor.grey9A,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  HorizontalSpacer(10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: viewModel
                          .statusColor(currentTask.status)
                          .withValues(alpha: .15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      viewModel.statusLabel(currentTask.status),
                      style: AppStyle.styleSemiBold12.copyWith(
                        color: viewModel.statusColor(currentTask.status),
                      ),
                    ),
                  ),
                ],
              ),
              VerticalSpacer(14),
              Row(
                children: [
                  Expanded(
                    child: TaskDetailInfoChip(
                      icon: LucideIcons.user,
                      label: 'Assigned To',
                      value: currentTask.affectedBy,
                    ),
                  ),
                  HorizontalSpacer(8),
                  Expanded(
                    child: TaskDetailInfoChip(
                      icon: LucideIcons.calendarDays,
                      label: 'Due Date',
                      value: viewModel.formatDueDate(currentTask.dueDate),
                    ),
                  ),
                ],
              ),
              VerticalSpacer(8),
              TaskDetailInfoChip(
                icon: LucideIcons.clock3,
                label: 'Last Update',
                value: viewModel.formatDateTime(currentTask.updatedAt),
              ),
            ],
          ),
        ),
        VerticalSpacer(18),
        TaskDetailContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(LucideIcons.history, size: 16, color: AppColor.primary),
                  HorizontalSpacer(8),
                  Text('Status Timeline', style: AppStyle.styleSemiBold14),
                ],
              ),
              VerticalSpacer(4),
              Text(
                'Track each status update in chronological order.',
                style: AppStyle.styleMedium12.copyWith(color: AppColor.grey9A),
              ),
              VerticalSpacer(14),
              TaskDetailTimeLineTile(
                title: 'Task created',
                subtitle: currentTask.createdAt != null
                    ? viewModel.formatDateTime(currentTask.createdAt)
                    : 'Creation time unavailable',
                color: AppColor.primary,
                isFirst: true,
                isLast: history.isEmpty,
              ),
              if (history.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 36, top: 6),
                  child: Text(
                    'No status changes yet.',
                    style: AppStyle.styleMedium12.copyWith(
                      color: AppColor.grey9A,
                    ),
                  ),
                )
              else
                ...List.generate(history.length, (index) {
                  final entry = history[index];
                  final isLast = index == history.length - 1;
                  final updatedBy = entry.changedBy.trim().isEmpty
                      ? 'Unknown'
                      : (userNames[entry.changedBy] ?? entry.changedBy);

                  return TaskDetailTimeLineTile(
                    title:
                        '${viewModel.statusLabel(entry.from)} -> ${viewModel.statusLabel(entry.to)}',
                    subtitle:
                        '${viewModel.formatDateTime(entry.changedAt)}\nUpdated by: $updatedBy',
                    color: viewModel.statusColor(entry.to),
                    isFirst: false,
                    isLast: isLast,
                  );
                }),
            ],
          ),
        ),
      ],
    );
  }
}
