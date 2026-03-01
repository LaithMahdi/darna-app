import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/config.dart';
import '../../../core/constants/app_color.dart';
import '../../../shared/buttons/custom_filled_icon_button.dart';
import '../../../shared/spacer/spacer.dart';
import '../data/home_stat_data.dart';
import '../widgets/home_stat_icon_card.dart';
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
            SliverGrid.builder(
              itemCount: homeStatsData.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 4,
                childAspectRatio: 140 / 68,
              ),
              itemBuilder: (context, index) {
                final stat = homeStatsData[index];
                return HomeStatIconCard(stat: stat);
              },
            ),
          ],
        ),
      ),
    );
  }
}
