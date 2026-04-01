import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/config.dart';
import '../../../routes/routes.dart';
import '../../../shared/spacer/spacer.dart';
import '../models/task_model.dart';
import 'task_change_status_modal_bottom_sheet.dart';
import 'task_item_card.dart';

class TaskListViewData extends StatelessWidget {
  const TaskListViewData({super.key, required this.tasks});

  final List<TaskModel> tasks;

  @override
  Widget build(BuildContext context) {
    log("Building TaskListViewData with ${tasks.length} tasks");
    return ListView.separated(
      padding: Config.defaultPadding,
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskItemCard(
          task: task,
          onCardTap: () {
            GoRouter.of(context).push(Routes.taskDetail, extra: task);
          },
          onChangeStatusTap: () {
            showModalBottomSheet(
              context: context,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7,
              ),
              builder: (_) => TaskChangeStatusModalBottomSheet(task: task),
            );
          },
        );
      },
      separatorBuilder: (context, index) => VerticalSpacer(10),
    );
  }
}
