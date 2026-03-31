import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../shared/icones/dialog_avatar.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({super.key});

  @override
  Widget build(BuildContext context) {
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
            icon: Icons.abc,
            text: "LD",
            radius: 24,
            backgroundColor: AppColor.primary.withValues(alpha: .2),
            textStyle: AppStyle.styleBold14.copyWith(color: AppColor.primary),
          ),
          Expanded(
            child: Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Lucas Dubois", style: AppStyle.styleSemiBold12),
                Text(
                  "Je suis à la maison",
                  style: AppStyle.styleMedium12.copyWith(
                    color: AppColor.grey9A,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "10 min ago",
            style: AppStyle.styleRegular12.copyWith(color: AppColor.grey9A),
          ),
        ],
      ),
    );
  }
}
