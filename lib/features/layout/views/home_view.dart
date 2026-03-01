import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/config.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../shared/buttons/custom_filled_icon_button.dart';
import '../../../shared/spacer/spacer.dart';
import '../data/home_stat_data.dart';
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
              ),
              itemBuilder: (context, index) {
                final stat = homeStatsData[index];
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    border: Border.all(color: AppColor.greyF9),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            stat.title,
                            style: AppStyle.styleRegular12.copyWith(
                              color: AppColor.black21,
                            ),
                          ),
                          Text(stat.value, style: AppStyle.styleBold22),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
