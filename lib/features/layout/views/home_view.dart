import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/constants/app_color.dart';
import '../../../routes/routes.dart';
import '../../../shared/buttons/custom_filled_icon_button.dart';
import '../../../shared/spacer/spacer.dart';
import '../widgets/home_sliver_grid_view.dart';
import '../widgets/settings_appbar_title.dart';
import '../widgets/home_upcoming_tasks_section.dart';
import '../widgets/home_history_section.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final userId = currentUser?.uid ?? '';

    return Scaffold(
      appBar: AppBar(
        title: SettingsAppbarTitle(),
        actions: [
          CustomFilledIconButton(
            icon: LucideIcons.bell,
            onPressed: () {
              GoRouter.of(context).push(Routes.notifications);
            },
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
            sliver: HomeSliverGrid(userId: userId),
          ),
          SliverToBoxAdapter(child: VerticalSpacer(20)),
          SliverToBoxAdapter(child: HomeUpcomingTasksSection(userId: userId)),
          SliverToBoxAdapter(child: VerticalSpacer(20)),
          SliverToBoxAdapter(
            child: HomeHistorySection(userId: userId, onHistoryItemTap: () {}),
          ),
          SliverToBoxAdapter(child: VerticalSpacer(40)),
        ],
      ),
    );
  }
}
