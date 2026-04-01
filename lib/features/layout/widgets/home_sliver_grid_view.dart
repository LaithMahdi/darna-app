import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_models/home_view_model.dart';
import '../../../shared/loading/loading_indicator.dart';
import '../../../shared/loading/custom_error_widget.dart';
import 'home_stat_icon_card.dart';

class HomeSliverGrid extends ConsumerWidget {
  final String userId;

  const HomeSliverGrid({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(homeStatsProvider(userId));

    return statsAsync.when(
      loading: () => SliverToBoxAdapter(
        child: SizedBox(height: 150, child: Center(child: LoadingIndicator())),
      ),
      error: (error, stack) => SliverToBoxAdapter(
        child: SizedBox(
          height: 150,
          child: CustomErrorWidget(
            title: 'Failed to load stats',
            message: error.toString(),
            onRetry: () {
              // ignore: unused_result
              ref.refresh(homeStatsProvider(userId));
            },
          ),
        ),
      ),
      data: (stats) => SliverGrid.builder(
        itemCount: stats.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 4,
          childAspectRatio: 140 / 68,
        ),
        itemBuilder: (context, index) {
          final stat = stats[index];
          return HomeStatIconCard(stat: stat);
        },
      ),
    );
  }
}
