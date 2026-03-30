import 'package:flutter/material.dart';
import '../data/statuses_data.dart';
import 'task_status_item_button.dart';

class TaskStatusSection extends StatelessWidget {
  const TaskStatusSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        spacing: 10,
        children: List.generate(statusesData.length, (index) {
          final status = statusesData[index];
          return TaskStatusItemButton(status: status);
        }),
      ),
    );
  }
}
