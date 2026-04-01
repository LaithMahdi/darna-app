import 'package:flutter/material.dart';
import '../models/chat_room_model.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../shared/icones/dialog_avatar.dart';

class ChatCard extends StatelessWidget {
  final ChatRoom chatRoom;
  final VoidCallback onTap;

  const ChatCard({super.key, required this.chatRoom, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
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
              icon: Icons.person,
              text: _getInitials(chatRoom.name),
              radius: 24,
              backgroundColor: AppColor.primary.withValues(alpha: .2),
              textStyle: AppStyle.styleBold14.copyWith(color: AppColor.primary),
            ),
            Expanded(
              child: Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chatRoom.name,
                    style: AppStyle.styleSemiBold12,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    chatRoom.lastMessage,
                    style: AppStyle.styleMedium12.copyWith(
                      color: AppColor.grey9A,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: 5,
              children: [
                Text(
                  _formatTime(chatRoom.lastMessageAt),
                  style: AppStyle.styleRegular12.copyWith(
                    color: AppColor.grey9A,
                  ),
                ),
                if (chatRoom.unreadCount > 0)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${chatRoom.unreadCount > 9 ? '9+' : chatRoom.unreadCount}',
                      style: AppStyle.styleSemiBold11.copyWith(
                        color: AppColor.white,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getInitials(String name) {
    final parts = name.split(' ');
    if (parts.isEmpty) return 'U';
    if (parts.length == 1) {
      return parts[0].substring(0, 1).toUpperCase();
    }
    return '${parts[0].substring(0, 1)}${parts[1].substring(0, 1)}'
        .toUpperCase();
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) return 'just now';
    if (difference.inMinutes < 60) return '${difference.inMinutes}m';
    if (difference.inHours < 24) return '${difference.inHours}h';
    if (difference.inDays == 1) return 'yesterday';
    if (difference.inDays < 7) return '${difference.inDays}d';
    return '${dateTime.month}/${dateTime.day}';
  }
}
