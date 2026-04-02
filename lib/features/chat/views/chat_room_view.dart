import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/chat_room_model.dart';
import '../view_models/chat_view_model.dart';
import '../../../shared/buttons/custom_back_button.dart';
import '../../../shared/loading/loading_indicator.dart';
import '../../../shared/loading/custom_error_widget.dart';
import '../widgets/chat_room_appbar.dart';
import '../widgets/chat_room_message_bubble.dart';
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
                return messages.isEmpty
                    ? ChatEmptyState(
                        title: 'No messages yet',
                        subtitle: 'Start the conversation',
                      )
                    : ListView.builder(
                        reverse: true,
                        padding: EdgeInsets.all(16),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          final isCurrentUser = message.senderId == userId;
                          return ChatRoomMessageBubble(
                            message: message,
                            isCurrentUser: isCurrentUser,
                          );
                        },
                      );
              },
            ),
          ),
          ChatRoomInputField(
            roomId: chatRoom.id,
            sendingState: sendingState,
            onSend: (message) async => await chatViewModel.sendMessageWithState(
              roomId: chatRoom.id,
              senderId: currentUser?.uid ?? '',
              senderName: currentUser?.displayName ?? 'Unknown',
              senderAvatar: currentUser?.photoURL ?? '',
              message: message,
              widgetRef: ref,
            ),
          ),
        ],
      ),
    );
  }
}
