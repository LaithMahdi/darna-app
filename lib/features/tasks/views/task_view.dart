import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/constants/app_color.dart';
import '../../../routes/routes.dart';
import '../../../shared/icones/custom_prefix_icon.dart';
import '../../../shared/loading/custom_error_widget.dart';
import '../../../shared/loading/loading_indicator.dart';
import '../../../shared/spacer/spacer.dart';
import '../view_models/task_view_model.dart';
import '../widgets/task_easy_time_section.dart';
import '../widgets/task_list_view_data.dart';
import '../widgets/task_not_found.dart';
import '../widgets/task_status_section.dart';

class TaskView extends ConsumerWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskListAsync = ref.watch(filteredTaskListProvider);

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
            loading: () => const SliverFillRemaining(child: LoadingIndicator()),
            error: (error, _) => SliverFillRemaining(
              child: CustomErrorWidget(
                title: 'Could not load tasks',
                message: error.toString(),
                onRetry: () => ref.invalidate(filteredTaskListProvider),
              ),
            ),
            data: (data) => SliverFillRemaining(
              child: data.isEmpty
                  ? TaskNotFound()
                  : TaskListViewData(tasks: data),
            ),
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
