import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/config.dart';
import '../models/chat_message_model.dart';
import '../models/chat_room_model.dart';

final chatServiceProvider = Provider((ref) => ChatService());

class ChatService {
  final _firestore = FirebaseFirestore.instance;

  // ==================== CHAT ROOM OPERATIONS ====================

  /// Get all chat rooms for a user
  Stream<List<ChatRoom>> watchUserChatRooms(String userId) {
    return _firestore
        .collection(Config.chatRoomsCollection)
        .where('participants', arrayContains: userId)
        .orderBy('lastMessageAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => ChatRoom.fromFirestore(doc))
              .toList();
        })
        .handleError((error) {
          debugPrint('watchUserChatRooms error: $error');
          return [];
        });
  }

  /// Get group chat room for a colocation
  Future<ChatRoom?> getColocationChatRoom(String colocationId) async {
    try {
      final query = await _firestore
          .collection(Config.chatRoomsCollection)
          .where('type', isEqualTo: ChatRoomType.group.index)
          .where('colocationId', isEqualTo: colocationId)
          .limit(1)
          .get();

      if (query.docs.isEmpty) return null;
      return ChatRoom.fromFirestore(query.docs.first);
    } catch (error) {
      debugPrint('getColocationChatRoom error: $error');
      return null;
    }
  }

  /// Get or create individual chat room between two users
  Future<ChatRoom> getOrCreateIndividualRoom(
    String currentUserId,
    String otherUserId,
    String otherUserName,
    String otherUserAvatar,
  ) async {
    try {
      // Query for existing room
      final query = await _firestore
          .collection(Config.chatRoomsCollection)
          .where('type', isEqualTo: ChatRoomType.individual.index)
          .where('participants', arrayContains: currentUserId)
          .get();

      // Find room with other user
      for (var doc in query.docs) {
        final room = ChatRoom.fromFirestore(doc);
        if (room.participants.contains(otherUserId)) {
          return room;
        }
      }

      // Create new room if not found
      final newRoomRef = _firestore
          .collection(Config.chatRoomsCollection)
          .doc();

      final newRoom = ChatRoom(
        id: newRoomRef.id,
        type: ChatRoomType.individual,
        otherUserId: otherUserId,
        name: otherUserName,
        avatar: otherUserAvatar,
        participants: [currentUserId, otherUserId],
        lastMessage: '',
        lastMessageAt: DateTime.now(),
        unreadCount: 0,
        createdAt: DateTime.now(),
      );

      await newRoomRef.set(newRoom.toJson());
      debugPrint('Created new individual chat room: ${newRoom.id}');
      return newRoom;
    } catch (error) {
      debugPrint('getOrCreateIndividualRoom error: $error');
      rethrow;
    }
  }

  /// Ensure colocation chat room exists (create if not)
  Future<ChatRoom?> ensureColocationChatRoom(
    String colocationId,
    String colocationName,
    List<String> participants,
  ) async {
    try {
      final normalizedParticipants = {...participants}.toList();

      // Check if already exists
      final existing = await getColocationChatRoom(colocationId);
      if (existing != null) {
        final mergedParticipants = {
          ...existing.participants,
          ...normalizedParticipants,
        }.toList();

        final shouldUpdateParticipants =
            mergedParticipants.length != existing.participants.length;
        final shouldUpdateName = existing.name != colocationName;

        if (shouldUpdateParticipants || shouldUpdateName) {
          final updates = <String, dynamic>{};
          if (shouldUpdateParticipants) {
            updates['participants'] = mergedParticipants;
          }
          if (shouldUpdateName) {
            updates['name'] = colocationName;
          }

          await _firestore
              .collection(Config.chatRoomsCollection)
              .doc(existing.id)
              .update(updates);

          debugPrint('Updated colocation chat room members: $colocationId');
          return existing.copyWith(
            participants: mergedParticipants,
            name: colocationName,
          );
        }

        debugPrint('Colocation chat room already exists: $colocationId');
        return existing;
      }

      // Create if not exists
      final newRoom = await createColocationChatRoom(
        colocationId,
        colocationName,
        normalizedParticipants,
      );
      return newRoom;
    } catch (error) {
      debugPrint('ensureColocationChatRoom error: $error');
      rethrow;
    }
  }

  /// Ensure chat rooms exist for all user colocations
  Future<void> ensureUserColocationChatRooms(
    String userId,
    List<dynamic> colocations,
  ) async {
    try {
      for (var colocation in colocations) {
        final colocationId = colocation.id;
        final colocationName = colocation.name;
        final participants = List<String>.from(colocation.memberIds ?? []);

        if (!participants.contains(userId)) {
          participants.add(userId);
        }

        await ensureColocationChatRoom(
          colocationId,
          colocationName,
          participants,
        );
      }
      debugPrint('Ensured all colocation chat rooms for user: $userId');
    } catch (error) {
      debugPrint('ensureUserColocationChatRooms error: $error');
      rethrow;
    }
  }

  /// Create group chat room for colocation
  Future<ChatRoom> createColocationChatRoom(
    String colocationId,
    String colocationName,
    List<String> participants,
  ) async {
    try {
      final normalizedParticipants = {...participants}.toList();

      final newRoomRef = _firestore
          .collection(Config.chatRoomsCollection)
          .doc();

      final newRoom = ChatRoom(
        id: newRoomRef.id,
        type: ChatRoomType.group,
        colocationId: colocationId,
        name: colocationName,
        participants: normalizedParticipants,
        lastMessage: 'Group chat created',
        lastMessageAt: DateTime.now(),
        unreadCount: 0,
        createdAt: DateTime.now(),
      );

      await newRoomRef.set(newRoom.toJson());
      debugPrint('Created colocation chat room: ${newRoom.id}');
      return newRoom;
    } catch (error) {
      debugPrint('createColocationChatRoom error: $error');
      rethrow;
    }
  }

  // ==================== MESSAGE OPERATIONS ====================

  /// Get all messages in a room
  Stream<List<ChatMessage>> watchRoomMessages(String roomId) {
    return _firestore
        .collection(Config.chatRoomsCollection)
        .doc(roomId)
        .collection(Config.messagesCollection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => ChatMessage.fromFirestore(doc))
              .toList();
        })
        .handleError((error) {
          debugPrint('watchRoomMessages error: $error');
          return [];
        });
  }

  /// Send a message
  Future<void> sendMessage({
    required String roomId,
    required String senderId,
    required String senderName,
    required String senderAvatar,
    required String message,
    required ChatMessageType type,
  }) async {
    try {
      final messageRef = _firestore
          .collection(Config.chatRoomsCollection)
          .doc(roomId)
          .collection(Config.messagesCollection)
          .doc();

      final chatMessage = ChatMessage(
        id: messageRef.id,
        roomId: roomId,
        senderId: senderId,
        senderName: senderName,
        senderAvatar: senderAvatar,
        message: message,
        type: type,
        createdAt: DateTime.now(),
        isEdited: false,
      );

      // Save message
      await messageRef.set(chatMessage.toJson());

      // Update room's last message
      await _firestore
          .collection(Config.chatRoomsCollection)
          .doc(roomId)
          .update({
            'lastMessage': message,
            'lastMessageAt': Timestamp.fromDate(DateTime.now()),
          });

      debugPrint('Message sent to room: $roomId');
    } catch (error) {
      debugPrint('sendMessage error: $error');
      rethrow;
    }
  }

  /// Edit a message
  Future<void> editMessage({
    required String roomId,
    required String messageId,
    required String newMessage,
  }) async {
    try {
      await _firestore
          .collection(Config.chatRoomsCollection)
          .doc(roomId)
          .collection(Config.messagesCollection)
          .doc(messageId)
          .update({
            'message': newMessage,
            'isEdited': true,
            'editedAt': Timestamp.fromDate(DateTime.now()),
          });

      debugPrint('Message edited: $messageId');
    } catch (error) {
      debugPrint('editMessage error: $error');
      rethrow;
    }
  }

  /// Delete a message
  Future<void> deleteMessage({
    required String roomId,
    required String messageId,
  }) async {
    try {
      await _firestore
          .collection(Config.chatRoomsCollection)
          .doc(roomId)
          .collection(Config.messagesCollection)
          .doc(messageId)
          .delete();

      debugPrint('Message deleted: $messageId');
    } catch (error) {
      debugPrint('deleteMessage error: $error');
      rethrow;
    }
  }
}
