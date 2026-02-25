import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../shared/buttons/custom_filled_icon_button.dart';
import '../../../shared/icones/custom_prefix_icon.dart';

class ColocationDetailMemberCard extends StatelessWidget {
  const ColocationDetailMemberCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColor.greyF0)),
      ),
      child: Row(
        spacing: 15,
        children: [
          CustomPrefixIcon(
            icon: LucideIcons.users,
            color: AppColor.black,
            size: 20,
          ),
          Expanded(
            child: Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Members", style: AppStyle.styleSemiBold14),
                Text(
                  "4 colocataires",
                  style: AppStyle.styleMedium12.copyWith(
                    color: AppColor.grey9A,
                  ),
                ),
              ],
            ),
          ),
          CustomFilledIconButton(
            icon: LucideIcons.plus,
            onPressed: () {},
            color: AppColor.greyF0,
            foregroundColor: AppColor.grey9A,
          ),
        ],
      ),
    );
  }
}
