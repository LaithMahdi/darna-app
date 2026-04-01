import 'package:flutter/material.dart';
import '../models/chat_message_model.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../shared/spacer/spacer.dart';

class ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isCurrentUser;
  final VoidCallback? onLongPress;

  const ChatMessageBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: Align(
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          decoration: BoxDecoration(
            color: isCurrentUser ? AppColor.primary : AppColor.greyF0,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            crossAxisAlignment: isCurrentUser
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              if (!isCurrentUser) ...[
                Text(
                  message.senderName,
                  style: AppStyle.styleMedium12.copyWith(
                    color: AppColor.grey9A,
                  ),
                ),
                VerticalSpacer(2),
              ],
              Text(
                message.message,
                style: AppStyle.styleMedium13.copyWith(
                  color: isCurrentUser ? AppColor.white : AppColor.black,
                ),
              ),
              VerticalSpacer(2),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message.timeAgo,
                    style: AppStyle.styleRegular12.copyWith(
                      color: isCurrentUser ? AppColor.greyF0 : AppColor.grey9A,
                    ),
                  ),
                  if (message.isEdited) ...[
                    HorizontalSpacer(4),
                    Text(
                      '(edited)',
                      style: AppStyle.styleRegular12.copyWith(
                        color: isCurrentUser
                            ? AppColor.greyF0
                            : AppColor.grey9A,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
