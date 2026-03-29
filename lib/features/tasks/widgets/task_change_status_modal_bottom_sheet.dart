import 'package:darna/core/config.dart';
import 'package:darna/shared/text/bottom_sheet_title.dart';
import 'package:flutter/material.dart';

import '../models/task_model.dart';

class TaskChangeStatusModalBottomSheet extends StatelessWidget {
  const TaskChangeStatusModalBottomSheet({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Config.defaultPadding,
      child: Column(
        children: [BottomSheetTitle(title: "Change Status : ${task.title}")],
      ),
    );
  }
}
