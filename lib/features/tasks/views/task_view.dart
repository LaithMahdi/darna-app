import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/config.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../routes/routes.dart';
import '../../../shared/icones/custom_prefix_icon.dart';
import '../../../shared/spacer/spacer.dart';
import '../view_models/task_view_model.dart';
import '../widgets/task_change_status_modal_bottom_sheet.dart';
import '../widgets/task_easy_time_section.dart';
import '../widgets/task_item_card.dart';
import '../widgets/task_status_section.dart';

class TaskView extends ConsumerWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskListAsync = ref.watch(filteredTaskListProvider);
    final hasDateFilter = ref.watch(selectedTaskDateProvider) != null;
    final hasStatusFilter = ref.watch(selectedTaskStatusProvider) != null;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                VerticalSpacer(20),
                TaskEasyTimeSection(),
                VerticalSpacer(24),
                TaskStatusSection(),
              ],
            ),
          ),
          taskListAsync.when(
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, _) => SliverFillRemaining(
              child: Center(child: Text('Error loading tasks: $error')),
            ),
            data: (tasks) {
              if (tasks.isEmpty) {
                final emptyMessage = hasDateFilter || hasStatusFilter
                    ? 'No tasks match your selected filters.'
                    : 'No tasks yet. Create your first task.';

                return SliverFillRemaining(
                  child: Center(
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
                            Text(
                              'No Tasks Found',
                              style: AppStyle.styleSemiBold16,
                            ),
                            VerticalSpacer(6),
                            Text(
                              emptyMessage,
                              style: AppStyle.styleMedium12.copyWith(
                                color: AppColor.grey9A,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            if (hasStatusFilter) ...[
                              VerticalSpacer(14),
                              TextButton(
                                onPressed: () {
                                  ref
                                          .read(
                                            selectedTaskStatusProvider.notifier,
                                          )
                                          .state =
                                      null;
                                },
                                child: Text('Show all statuses'),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }

              return SliverFillRemaining(
                child: ListView.separated(
                  padding: Config.defaultPadding,
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return TaskItemCard(
                      task: task,
                      onCardTap: () {
                        GoRouter.of(
                          context,
                        ).push(Routes.taskDetail, extra: task);
                      },
                      onChangeStatusTap: () {
                        showModalBottomSheet(
                          context: context,
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * 0.7,
                          ),
                          builder: (_) =>
                              TaskChangeStatusModalBottomSheet(task: task),
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) => VerticalSpacer(10),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: CustomPrefixIcon(icon: LucideIcons.plus, color: AppColor.white),
        onPressed: () => GoRouter.of(context).push(Routes.taskCreate),
      ),
    );
  }
}
