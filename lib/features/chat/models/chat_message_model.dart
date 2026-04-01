import 'package:cloud_firestore/cloud_firestore.dart';

enum ChatMessageType { text, image, audio }

class ChatMessage {
  final String id;
  final String roomId;
  final String senderId;
  final String senderName;
  final String senderAvatar;
  final String message;
  final ChatMessageType type;
  final DateTime createdAt;
  final bool isEdited;
  final DateTime? editedAt;

  ChatMessage({
    required this.id,
    required this.roomId,
    required this.senderId,
    required this.senderName,
    required this.senderAvatar,
    required this.message,
    required this.type,
    required this.createdAt,
    required this.isEdited,
    this.editedAt,
  });

  // Factory constructor from Firestore document
  factory ChatMessage.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return ChatMessage(
      id: doc.id,
      roomId: data['roomId'] ?? '',
      senderId: data['senderId'] ?? '',
      senderName: data['senderName'] ?? 'Unknown',
      senderAvatar: data['senderAvatar'] ?? '',
      message: data['message'] ?? '',
      type: ChatMessageType.values[data['type'] ?? 0],
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isEdited: data['isEdited'] ?? false,
      editedAt: (data['editedAt'] as Timestamp?)?.toDate(),
    );
  }

  // Convert to JSON for Firestore
  Map<String, dynamic> toJson() => {
    'roomId': roomId,
    'senderId': senderId,
    'senderName': senderName,
    'senderAvatar': senderAvatar,
    'message': message,
    'type': type.index,
    'createdAt': Timestamp.fromDate(createdAt),
    'isEdited': isEdited,
    'editedAt': editedAt != null ? Timestamp.fromDate(editedAt!) : null,
  };

  // TimeAgo formatting
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inSeconds < 60) return 'just now';
    if (difference.inMinutes < 60) return '${difference.inMinutes}m ago';
    if (difference.inHours < 24) return '${difference.inHours}h ago';
    if (difference.inDays < 7) return '${difference.inDays}d ago';
    if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()}w ago';
    }
    return '${(difference.inDays / 30).floor()}mo ago';
  }

  // Copy with for immutability
  ChatMessage copyWith({
    String? id,
    String? roomId,
    String? senderId,
    String? senderName,
    String? senderAvatar,
    String? message,
    ChatMessageType? type,
    DateTime? createdAt,
    bool? isEdited,
    DateTime? editedAt,
  }) => ChatMessage(
    id: id ?? this.id,
    roomId: roomId ?? this.roomId,
    senderId: senderId ?? this.senderId,
    senderName: senderName ?? this.senderName,
    senderAvatar: senderAvatar ?? this.senderAvatar,
    message: message ?? this.message,
    type: type ?? this.type,
    createdAt: createdAt ?? this.createdAt,
    isEdited: isEdited ?? this.isEdited,
    editedAt: editedAt ?? this.editedAt,
  );

  @override
  String toString() => 'ChatMessage(id: $id, message: $message)';
}
