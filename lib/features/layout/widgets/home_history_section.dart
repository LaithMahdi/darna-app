import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/loading/custom_error_widget.dart';
import '../../../shared/loading/loading_indicator.dart';
import '../../../shared/spacer/spacer.dart';
import '../view_models/home_view_model.dart';
import '../widgets/home_title.dart';
import '../widgets/history_card.dart';
import 'home_history_empty.dart';

class HomeHistorySection extends ConsumerWidget {
  final String userId;
  final VoidCallback? onHistoryItemTap;

  const HomeHistorySection({
    super.key,
    required this.userId,
    this.onHistoryItemTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskHistoryAsync = ref.watch(taskHistoryProvider(userId));

    return taskHistoryAsync.when(
      loading: () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeTitle(text: 'History'),
          LoadingIndicator(),
        ],
      ),
      error: (error, stack) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeTitle(text: 'History'),
          CustomErrorWidget(
            title: 'Failed to load history',
            message: error.toString(),
            onRetry: () => ref.refresh(taskHistoryProvider(userId)),
          ),
        ],
      ),
      data: (tasks) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeTitle(text: 'History'),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: tasks.isEmpty
                ? HomeHistoryEmpty()
                : ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return HistoryCard(
                        task: task,
                        userName: task.affectedBy,
                        onTap: onHistoryItemTap,
                      );
                    },
                    separatorBuilder: (context, index) => VerticalSpacer(10),
                  ),
          ),
        ],
      ),
    );
  }
}
