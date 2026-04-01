import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/buttons/custom_back_button.dart';
import '../../../shared/loading/custom_error_widget.dart';
import '../../../shared/loading/loading_indicator.dart';
import '../models/task_model.dart';
import '../view_models/task_detail_view_model.dart';
import '../widgets/task_detail_list_view.dart';

class TaskDetailView extends ConsumerWidget {
  const TaskDetailView({super.key, this.task});

  final TaskModel? task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(taskDetailViewModelProvider);

    if (task == null || task!.id.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          leading: CustomBackButton(),
          title: Text('Task Details'),
        ),
        body: CustomErrorWidget(
          title: 'Task not found',
          message: 'This task may have been deleted or is unavailable.',
        ),
      );
    }

    final taskAsync = ref.watch(taskDetailTaskProvider(task!.id));

    return taskAsync.when(
      loading: () => Scaffold(
        appBar: AppBar(
          leading: CustomBackButton(),
          title: Text('Task Details'),
        ),
        body: LoadingIndicator(),
      ),
      error: (_, _) => Scaffold(
        appBar: AppBar(
          leading: CustomBackButton(),
          title: Text('Task Details'),
        ),
        body: CustomErrorWidget(
          title: 'Failed to load task details',
          message: 'Please check your connection and try again.',
          onRetry: () => ref.invalidate(taskDetailTaskProvider(task!.id)),
        ),
      ),
      data: (liveTask) {
        final currentTask = liveTask ?? task!;
        final history = viewModel.sortHistory(currentTask);
        final changerIds = history
            .map((entry) => entry.changedBy)
            .where((id) => id.trim().isNotEmpty)
            .toSet();
        final userNamesKey = viewModel.buildUserIdsKey(changerIds);
        final userNamesAsync = ref.watch(
          taskDetailUserNamesProvider(userNamesKey),
        );

        return Scaffold(
          appBar: AppBar(
            leading: CustomBackButton(),
            title: Text('Task Details'),
          ),
          body: userNamesAsync.when(
            loading: () => LoadingIndicator(),
            error: (_, _) => CustomErrorWidget(
              title: 'Failed to load timeline users',
              message: 'Could not fetch user names for status changes.',
              onRetry: () =>
                  ref.invalidate(taskDetailUserNamesProvider(userNamesKey)),
            ),
            data: (userNames) {
              return TaskDetailListView(
                currentTask: currentTask,
                viewModel: viewModel,
                history: history,
                userNames: userNames,
              );
            },
          ),
        );
      },
    );
  }
}
