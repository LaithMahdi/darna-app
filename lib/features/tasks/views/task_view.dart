import 'package:flutter/material.dart';

import '../../../shared/spacer/spacer.dart';
import '../widgets/task_easy_time_section.dart' show TaskEasyTimeSection;

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [VerticalSpacer(20), TaskEasyTimeSection()],
            ),
          ),
        ],
      ),
    );
  }
}
