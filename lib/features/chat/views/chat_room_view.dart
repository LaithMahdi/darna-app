import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/chat_room_model.dart';
import '../models/chat_message_model.dart';
import '../view_models/chat_view_model.dart';
import '../../../shared/buttons/custom_back_button.dart';
import '../../../shared/loading/loading_indicator.dart';
import '../../../shared/loading/custom_error_widget.dart';
import '../widgets/chat_room_appbar.dart';
import '../widgets/chat_message_bubble.dart';
import '../widgets/chat_input_field.dart';
import '../widgets/chat_empty_state.dart';

class ChatRoomView extends ConsumerWidget {
  final ChatRoom chatRoom;

  const ChatRoomView({super.key, required this.chatRoom});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final userId = currentUser?.uid ?? '';

    final chatViewModel = ref.watch(chatViewModelProvider);
    final messagesAsync = ref.watch(
      chatViewModel.roomMessagesProvider(chatRoom.id),
    );
    final sendingState = ref.watch(sendingMessageStateProvider(chatRoom.id));

    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        title: ChatRoomAppbar(chatRoom: chatRoom),
      ),
      body: Column(
        children: [
          Expanded(
            child: messagesAsync.when(
              loading: () => Center(child: LoadingIndicator()),
              error: (error, stack) => CustomErrorWidget(
                title: 'Failed to load messages',
                message: error.toString(),
                onRetry: () => ref.refresh(
                  chatViewModel.roomMessagesProvider(chatRoom.id),
                ),
              ),
              data: (messages) {
                if (messages.isEmpty) {
                  return ChatEmptyState(
                    title: 'No messages yet',
                    subtitle: 'Start the conversation',
                  );
                }

                return ListView.builder(
                  reverse: true,
                  padding: EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isCurrentUser = message.senderId == userId;

                    return ChatMessageBubble(
                      message: message,
                      isCurrentUser: isCurrentUser,
                      onLongPress: isCurrentUser
                          ? () {
                              _showMessageOptions(
                                context,
                                message,
                                chatViewModel,
                              );
                            }
                          : null,
                    );
                  },
                );
              },
            ),
          ),
          ChatInputField(
            roomId: chatRoom.id,
            sendingState: sendingState,
            onSend: (message) =>
                _sendMessage(context, ref, message, currentUser, chatViewModel),
          ),
        ],
      ),
    );
  }

  Future<void> _sendMessage(
    BuildContext context,
    WidgetRef widgetRef,
    String message,
    User? currentUser,
    ChatViewModel chatViewModel,
  ) async {
    if (message.isEmpty || currentUser == null) return;

    try {
      await chatViewModel.sendMessageWithState(
        roomId: chatRoom.id,
        senderId: currentUser.uid,
        senderName: currentUser.displayName ?? 'Unknown',
        senderAvatar: currentUser.photoURL ?? '',
        message: message,
        widgetRef: widgetRef,
      );
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send message: $error')),
        );
      }
    }
  }

  void _showMessageOptions(
    BuildContext context,
    ChatMessage message,
    ChatViewModel chatViewModel,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Edit'),
              onTap: () {
                Navigator.pop(context);
                _showEditDialog(context, message, chatViewModel);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: Colors.red),
              title: Text('Delete', style: TextStyle(color: Colors.red)),
              onTap: () async {
                Navigator.pop(context);
                await chatViewModel.deleteMessage(
                  roomId: chatRoom.id,
                  messageId: message.id,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(
    BuildContext context,
    ChatMessage message,
    ChatViewModel chatViewModel,
  ) {
    final controller = TextEditingController(text: message.message);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Message'),
        content: TextField(
          controller: controller,
          maxLines: null,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Edit your message',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (controller.text.isNotEmpty) {
                await chatViewModel.editMessage(
                  roomId: chatRoom.id,
                  messageId: message.id,
                  newMessage: controller.text,
                );
                // ignore: use_build_context_synchronously
                if (context.mounted) Navigator.pop(context);
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
