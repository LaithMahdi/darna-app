import 'package:flutter/material.dart';
import '../../../core/config.dart';
import '../../../shared/spacer/spacer.dart';
import '../data/task_data.dart';
import '../widgets/task_easy_time_section.dart';
import '../widgets/task_item_card.dart';
import '../widgets/task_status_section.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
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
          SliverFillRemaining(
            child: ListView.separated(
              padding: Config.defaultPadding,
              itemCount: tasksData.length,
              itemBuilder: (context, index) {
                final task = tasksData[index];
                return TaskItemCard(task: task);
              },
              separatorBuilder: (context, index) => VerticalSpacer(10),
            ),
          ),
        ],
      ),
    );
  }
}
