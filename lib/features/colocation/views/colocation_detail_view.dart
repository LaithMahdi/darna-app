import 'package:flutter/material.dart';
import '../../../core/config.dart';
import '../../../shared/buttons/custom_back_button.dart';
import '../../../shared/buttons/primary_button.dart';
import '../../../shared/spacer/spacer.dart';
import '../../../shared/text/sub_label.dart';
import '../data/colocators_data.dart';
import '../widgets/colocation_detail_item_card.dart';
import '../widgets/colocation_detail_member_card.dart';
import '../widgets/colocation_detail_list_item_card.dart';

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
          SliverPadding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 25),
            // padding: Config.defaultPadding,
            sliver: SliverList.separated(
              itemCount: colocatorsData.length,
              itemBuilder: (context, index) {
                final colocator = colocatorsData[index];
                return ColocationDetailListItemCard(colocator: colocator);
              },
              separatorBuilder: (context, index) => VerticalSpacer(15),
            ),
          ),
          SliverToBoxAdapter(child: VerticalSpacer(21)),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(25, 10, 25, 25),
        child: PrimaryButton(text: "Save", onPressed: () {}),
      ),
    );
  }
}
