import 'package:flutter/material.dart';
import '../models/chat_room_model.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../shared/icones/dialog_avatar.dart';

class ChatRoomAppbar extends StatelessWidget {
  final ChatRoom chatRoom;
  final VoidCallback? onTap;

  const ChatRoomAppbar({super.key, required this.chatRoom, this.onTap});

  String _getInitials(String name) {
    final parts = name.split(' ');
    if (parts.isEmpty) return 'U';
    if (parts.length == 1) {
      return parts[0].substring(0, 1).toUpperCase();
    }
    return '${parts[0].substring(0, 1)}${parts[1].substring(0, 1)}'
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DialogAvatar(
            icon: Icons.person,
            text: _getInitials(chatRoom.name),
            radius: 22,
            textStyle: AppStyle.styleBold14.copyWith(color: AppColor.primary),
            color: AppColor.primary,
            backgroundColor: AppColor.primary.withValues(alpha: .25),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                Text(
                  chatRoom.name,
                  style: AppStyle.styleSemiBold14,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  chatRoom.type == ChatRoomType.group
                      ? '${chatRoom.participants.length} members'
                      : 'Online',
                  style: AppStyle.styleRegular12.copyWith(
                    color: AppColor.grey9A,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
