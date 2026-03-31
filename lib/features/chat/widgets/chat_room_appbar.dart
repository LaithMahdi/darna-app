import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../shared/icones/dialog_avatar.dart';

class ChatRoomAppbar extends StatelessWidget {
  const ChatRoomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DialogAvatar(
          icon: Icons.abc,
          text: "LD",
          radius: 22,
          textStyle: AppStyle.styleBold14.copyWith(color: AppColor.primary),
          color: AppColor.primary,
          backgroundColor: AppColor.primary.withValues(alpha: .25),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 5,
          children: [
            Text("Lucas Dubois", style: AppStyle.styleSemiBold14),
            Text(
              "Online",
              style: AppStyle.styleMedium12.copyWith(color: AppColor.grey9A),
            ),
          ],
        ),
      ],
    );
  }
}
