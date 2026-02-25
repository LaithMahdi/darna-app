import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../shared/icones/dialog_avatar.dart';

class ColocationItem extends StatelessWidget {
  const ColocationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 17),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.greyF0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        spacing: 10,
        children: [
          DialogAvatar(icon: LucideIcons.doorOpen, radius: 25, iconSize: 27),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2,
            children: [
              Text("Darna Apartment", style: AppStyle.styleBold14),
              Text(
                "5 members",
                style: AppStyle.styleRegular14.copyWith(color: AppColor.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
