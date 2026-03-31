import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/constants/app_color.dart';
import '../../../shared/buttons/custom_filled_icon_button.dart';
import '../../../shared/spacer/spacer.dart';
import '../../tasks/data/task_data.dart';
import '../../tasks/widgets/task_item_card.dart';
import '../widgets/home_history_card.dart';
import '../widgets/home_sliver_grid_view.dart';
import '../widgets/home_title.dart';
import '../widgets/settings_appbar_title.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SettingsAppbarTitle(),
        actions: [
          CustomFilledIconButton(
            icon: LucideIcons.bell,
            onPressed: () {},
            color: AppColor.greyF0,
            foregroundColor: AppColor.black,
            radius: 5,
          ),
          HorizontalSpacer(15),
        ],
        toolbarHeight: 100,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: VerticalSpacer(15)),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            sliver: HomeSliverGrid(),
          ),
          SliverToBoxAdapter(child: VerticalSpacer(20)),
          SliverToBoxAdapter(child: HomeTitle(text: "Upcoming Tasks")),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            sliver: SliverList.separated(
              itemCount: 2,

              itemBuilder: (context, index) {
                final task = tasksData[index];
                return TaskItemCard(
                  task: task,
                  onCardTap: () {},
                  onChangeStatusTap: () {},
                );
              },
              separatorBuilder: (context, index) => VerticalSpacer(10),
            ),
          ),
          SliverToBoxAdapter(child: VerticalSpacer(20)),
          SliverToBoxAdapter(child: HomeTitle(text: "History")),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            sliver: SliverList.separated(
              itemCount: 2,
              itemBuilder: (context, index) => const HomeHistoryCard(),
              separatorBuilder: (context, index) => VerticalSpacer(10),
            ),
          ),
          SliverToBoxAdapter(child: VerticalSpacer(40)),
        ],
      ),
    );
  }
}
