import 'package:darna/core/config.dart';
import 'package:darna/core/constants/app_color.dart';
import 'package:darna/core/constants/app_style.dart';
import 'package:darna/shared/buttons/copy_button.dart';
import 'package:darna/shared/buttons/custom_filled_icon_button.dart';
import 'package:darna/shared/icones/custom_prefix_icon.dart';
import 'package:darna/shared/icones/dialog_avatar.dart';
import 'package:darna/shared/spacer/spacer.dart';
import 'package:darna/shared/text/sub_label.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../shared/buttons/custom_back_button.dart';
import '../data/colocators_data.dart';
import '../widgets/colocation_detail_item_card.dart';
import '../widgets/colocation_detail_member_card.dart';

class ColocationDetailView extends StatelessWidget {
  const ColocationDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        title: Text("Colocation Invitation"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: Config.defaultPadding,
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubLabel(
                    text:
                        "You’ve received an invitation to join this colocation. Join your roommates and start managing your shared home together.",
                  ),
                  VerticalSpacer(21),
                  ColocationDetailItemCard(),
                  VerticalSpacer(23),
                  ColocationDetailMemberCard(),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: VerticalSpacer(21)),
          SliverList.separated(
            itemCount: colocatorsData.length,
            itemBuilder: (context, index) {
              final colocator = colocatorsData[index];
              return Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  color: AppColor.whiteFB,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  spacing: 10,
                  children: [
                    DialogAvatar(
                      icon: LucideIcons.aLargeSmall,
                      text: colocator.fullName,
                      textStyle: AppStyle.styleBold12.copyWith(
                        color: AppColor.primary,
                      ),
                      backgroundColor: AppColor.primary.withValues(alpha: .2),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              colocator.fullName,
                              style: AppStyle.styleSemiBold12,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => VerticalSpacer(15),
          ),
        ],
      ),
    );
  }
}
