import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/loading/custom_error_widget.dart';
import '../../../shared/loading/loading_indicator.dart';
import '../../../shared/spacer/spacer.dart';
import '../../tasks/widgets/task_item_card.dart';
import '../view_models/home_view_model.dart';
import '../widgets/home_title.dart';
import 'home_upcoming_empty.dart';

class HomeUpcomingTasksSection extends ConsumerWidget {
  const HomeUpcomingTasksSection({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upcomingTasksAsync = ref.watch(upcomingTasksProvider(userId));

    return upcomingTasksAsync.when(
      loading: () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeTitle(text: 'Upcoming Tasks'),
          LoadingIndicator(),
        ],
      ),
      error: (error, stack) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeTitle(text: 'Upcoming Tasks'),
          CustomErrorWidget(
            title: 'Failed to load tasks',
            message: error.toString(),
            onRetry: () => ref.refresh(upcomingTasksProvider(userId)),
          ),
        ],
      ),
      data: (tasks) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeTitle(text: 'Upcoming Tasks'),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: tasks.isEmpty
                ? HomeUpComingEmpty()
                : Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return TaskItemCard(
                          task: task,
                          onCardTap: () {},
                          onChangeStatusTap: () {},
                        );
                      },
                      separatorBuilder: (context, index) => VerticalSpacer(12),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
