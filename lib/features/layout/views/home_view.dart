import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/config.dart';
import '../../../core/constants/app_color.dart';
import '../../../shared/buttons/custom_filled_icon_button.dart';
import '../../../shared/spacer/spacer.dart';
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
      body: Padding(
        padding: Config.defaultPadding,
        child: CustomScrollView(
          slivers: [
            HomeSliverGrid(),
            SliverToBoxAdapter(child: VerticalSpacer(20)),
            SliverToBoxAdapter(child: HomeTitle(text: "Upcoming Tasks")),
          ],
        ),
      ),
    );
  }
}
