import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/functions/show_toast.dart';
import '../../../core/helper/cacher_helper.dart';
import '../../../features/auth/view_models/auth_view_model.dart';
import '../../../features/colocation/models/colocation_model.dart';
import '../../../routes/routes.dart';
import '../../../shared/buttons/custom_filled_icon_button.dart';
import '../../../shared/spacer/spacer.dart';
import '../widgets/join_colocation_dialog.dart';
import '../widgets/settings_appbar_title.dart';
import '../widgets/settings_list_tile.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    final success = await ref.read(authViewModelProvider.notifier).signOut();

    if (!context.mounted) return;

    if (!success) {
      final error = ref.read(authViewModelProvider).errorMessage;
      showToast(context, error ?? 'Logout failed.', isError: true);
      return;
    }

    await CacherHelper().deleteData();

    if (!context.mounted) return;
    GoRouter.of(context).go(Routes.login);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    onTap: () async {
                      final joinedColocation =
                          await showDialog<ColocationModel>(
                            context: context,
                            builder: (context) => const JoinColocationDialog(),
                          );

                      if (joinedColocation == null || !context.mounted) return;

                      GoRouter.of(
                        context,
                      ).push(Routes.colocationDetail, extra: joinedColocation);
                    },
                  ),
                  SettingsListTile(
                    title: "Manage Account",
                    icon: LucideIcons.wrench,
                    onTap: () =>
                        GoRouter.of(context).push(Routes.manageAccount),
                  ),
                  SettingsListTile(
                    title: "Password",
                    icon: LucideIcons.keyRound,
                    onTap: () => GoRouter.of(context).push(Routes.password),
                  ),
                  SettingsListTile(
                    title: "Language",
                    icon: LucideIcons.languages,
                    onTap: () {},
                  ),
                  SettingsListTile(
                    title: "Help",
                    icon: LucideIcons.messageCircleQuestionMark,
                    onTap: () =>
                        GoRouter.of(context).push(Routes.helpAndSupport),
                  ),
                  SettingsListTile(
                    title: "Privacy",
                    icon: LucideIcons.hatGlasses,
                    onTap: () => GoRouter.of(context).push(Routes.privacy),
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
                onTap: () => _logout(context, ref),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
