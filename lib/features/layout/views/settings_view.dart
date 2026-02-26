import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/helper/cacher_helper.dart';
import '../../../routes/routes.dart';
import '../../../shared/buttons/custom_filled_icon_button.dart';
import '../../../shared/spacer/spacer.dart';
import '../widgets/settings_appbar_title.dart';
import '../widgets/settings_list_tile.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

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
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            sliver: SliverToBoxAdapter(
              child: Column(
                spacing: 15,
                children: [
                  SettingsListTile(
                    title: "Manage Colocations",
                    icon: LucideIcons.bedSingle,
                    onTap: () => GoRouter.of(context).push(Routes.colocation),
                  ),
                  SettingsListTile(
                    title: "Join Colocation",
                    icon: LucideIcons.ticket,
                    onTap: () {},
                  ),
                  SettingsListTile(
                    title: "Manage Account",
                    icon: LucideIcons.wrench,
                    onTap: () {},
                  ),
                  SettingsListTile(
                    title: "Password",
                    icon: LucideIcons.keyRound,
                    onTap: () {},
                  ),
                  SettingsListTile(
                    title: "Language",
                    icon: LucideIcons.languages,
                    onTap: () {},
                  ),
                  SettingsListTile(
                    title: "Help",
                    icon: LucideIcons.messageCircleQuestionMark,
                    onTap: () {},
                  ),
                  SettingsListTile(
                    title: "Privacy",
                    icon: LucideIcons.hatGlasses,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.fromLTRB(25, 0, 25, 25),
              child: SettingsListTile(
                title: "Logout",
                color: AppColor.error,
                icon: LucideIcons.logOut,
                onTap: () {
                  CacherHelper().setCompletProfile(false);
                  GoRouter.of(context).push(Routes.login);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
