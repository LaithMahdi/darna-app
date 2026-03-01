import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../shared/icones/dialog_avatar.dart';
import '../models/home_stat_model.dart';

class HomeStatIconCard extends StatelessWidget {
  const HomeStatIconCard({super.key, required this.stat});

  final HomeStatModel stat;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(color: AppColor.greyF9),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
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
          ),
          DialogAvatar(
            icon: stat.icon,
            color: stat.color,
            backgroundColor: stat.color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(7),
            radius: 25,
            iconSize: 25,
          ),
        ],
      ),
    );
  }
}
