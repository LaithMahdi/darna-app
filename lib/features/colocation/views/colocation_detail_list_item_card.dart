import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../core/functions/get_initials.dart';
import '../../../shared/card/dismissible_card.dart';
import '../../../shared/card/user_badge.dart';
import '../../../shared/icones/dialog_avatar.dart';
import '../models/colocator_model.dart';

class ColocationDetailListItemCard extends StatelessWidget {
  const ColocationDetailListItemCard({super.key, required this.colocator});

  final ColocatorModel colocator;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(colocator.fullName),
      background: DismissibleCard(),
      child: Container(
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
              text: getInitials(colocator.fullName),
              textStyle: AppStyle.styleBold12.copyWith(color: AppColor.primary),
              backgroundColor: AppColor.primary.withValues(alpha: .2),
              radius: 25,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 3,
              children: [
                Row(
                  spacing: 9,
                  children: [
                    Text(colocator.fullName, style: AppStyle.styleSemiBold13),
                    UserBadge(isAdmin: colocator.isAdmin),
                  ],
                ),
                Text(
                  colocator.email,
                  style: AppStyle.styleMedium12.copyWith(
                    color: AppColor.grey9A,
                  ),
                ),
                Text(
                  "Membre depuis le ${colocator.joinAt}",
                  style: AppStyle.styleMedium12.copyWith(
                    color: AppColor.grey9A,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
