import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../colocation/service/colocation_service.dart';
import '../models/chat_message_model.dart';
import '../models/chat_room_model.dart';
import '../service/chat_service.dart';

final chatViewModelProvider = Provider((ref) => ChatViewModel(ref));
final colocationServiceProvider = Provider((ref) => ColocationService());

// Message sending state provider
final sendingMessageStateProvider =
    StateNotifierProvider.family<
      SendingMessageStateNotifier,
      AsyncValue<void>,
      String
    >((ref, roomId) {
      return SendingMessageStateNotifier();
    });

class SendingMessageStateNotifier extends StateNotifier<AsyncValue<void>> {
  SendingMessageStateNotifier() : super(const AsyncValue.data(null));

  void setLoading() {
    state = const AsyncValue.loading();
  }

  void setError(Object error, StackTrace stack) {
    state = AsyncValue.error(error, stack);
  }

  void setSuccess() {
    state = const AsyncValue.data(null);
  }
}

class ChatViewModel {
  final Ref ref;

  ChatViewModel(this.ref);

  ChatService get _chatService => ref.watch(chatServiceProvider);

  // ==================== CHAT ROOM PROVIDERS ====================

  /// Watch all chat rooms for a user
  final userChatRoomsProvider = StreamProvider.family<List<ChatRoom>, String>((
    ref,
    userId,
  ) {
    final service = ref.watch(chatServiceProvider);
    return service.watchUserChatRooms(userId);
  });

  /// Colocation chat room
  final colocationChatRoomProvider = FutureProvider.family<ChatRoom?, String>((
    ref,
    colocationId,
  ) {
    final service = ref.watch(chatServiceProvider);
    return service.getColocationChatRoom(colocationId);
  });

  // ==================== MESSAGE PROVIDERS ====================

  /// Watch all messages in a room
  final roomMessagesProvider = StreamProvider.family<List<ChatMessage>, String>(
    (ref, roomId) {
      final service = ref.watch(chatServiceProvider);
      return service.watchRoomMessages(roomId);
    },
  );

  // ==================== METHODS ====================

  /// Get or create individual chat room
  Future<ChatRoom> getOrCreateIndividualRoom(
    String currentUserId,
    String otherUserId,
    String otherUserName,
    String otherUserAvatar,
  ) async {
    return _chatService.getOrCreateIndividualRoom(
      currentUserId,
      otherUserId,
      otherUserName,
      otherUserAvatar,
    );
  }

  /// Create group chat room for colocation
  Future<ChatRoom> createColocationChatRoom(
    String colocationId,
    String colocationName,
    List<String> participants,
  ) async {
    return _chatService.createColocationChatRoom(
      colocationId,
      colocationName,
      participants,
    );
  }

  /// Ensure all colocation chat rooms exist for a user
  Future<void> ensureUserColocationChatRooms(
    String userId,
    List<dynamic> colocations,
  ) async {
    return _chatService.ensureUserColocationChatRooms(userId, colocations);
  }

  /// Send a message with state management
  Future<void> sendMessageWithState({
    required String roomId,
    required String senderId,
    required String senderName,
    required String senderAvatar,
    required String message,
    required WidgetRef widgetRef,
    ChatMessageType type = ChatMessageType.text,
  }) async {
    final notifier = widgetRef.read(
      sendingMessageStateProvider(roomId).notifier,
    );

    try {
      notifier.setLoading();
      await sendMessage(
        roomId: roomId,
        senderId: senderId,
        senderName: senderName,
        senderAvatar: senderAvatar,
        message: message,
        type: type,
      );
      notifier.setSuccess();
    } catch (error, stack) {
      notifier.setError(error, stack);
    }
  }

  /// Send a message
  Future<void> sendMessage({
    required String roomId,
    required String senderId,
    required String senderName,
    required String senderAvatar,
    required String message,
    ChatMessageType type = ChatMessageType.text,
  }) async {
    return _chatService.sendMessage(
      roomId: roomId,
      senderId: senderId,
      senderName: senderName,
      senderAvatar: senderAvatar,
      message: message,
      type: type,
    );
  }

  /// Edit a message
  Future<void> editMessage({
    required String roomId,
    required String messageId,
    required String newMessage,
  }) async {
    return _chatService.editMessage(
      roomId: roomId,
      messageId: messageId,
      newMessage: newMessage,
    );
  }

  /// Delete a message
  Future<void> deleteMessage({
    required String roomId,
    required String messageId,
  }) async {
    return _chatService.deleteMessage(roomId: roomId, messageId: messageId);
  }
}
