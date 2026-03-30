import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/config.dart';
import '../../../core/constants/app_color.dart';
import '../../../routes/routes.dart';
import '../../../shared/icones/custom_prefix_icon.dart';
import '../../../shared/spacer/spacer.dart';
import '../data/task_data.dart';
import '../widgets/task_change_status_modal_bottom_sheet.dart';
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
                return TaskItemCard(
                  task: task,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.7,
                      ),
                      builder: (context) =>
                          TaskChangeStatusModalBottomSheet(task: task),
                    );
                  },
                );
              },
              separatorBuilder: (context, index) => VerticalSpacer(10),
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
