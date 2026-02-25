import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../shared/buttons/copy_button.dart';
import '../../../shared/icones/dialog_avatar.dart';

class ColocationDetailItemCard extends StatelessWidget {
  const ColocationDetailItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(color: AppColor.greyF0),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        spacing: 10,
        children: [
          DialogAvatar(icon: LucideIcons.doorOpen, radius: 26, iconSize: 26),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                Text("Darna Apartment", style: AppStyle.styleSemiBold14),
                Text(
                  "Code : 4555502",
                  style: AppStyle.styleSemiBold12.copyWith(
                    color: AppColor.grey9A,
                  ),
                ),
              ],
            ),
          ),
          CopyButton(code: "4555502"),
        ],
      ),
    );
  }
}
