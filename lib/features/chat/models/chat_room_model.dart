import 'package:cloud_firestore/cloud_firestore.dart';

enum ChatRoomType { individual, group }

class ChatRoom {
  final String id;
  final ChatRoomType type;
  final String? colocationId; // For group chats
  final String? otherUserId; // For individual chats
  final String name;
  final String? avatar;
  final List<String> participants;
  final String lastMessage;
  final DateTime lastMessageAt;
  final int unreadCount;
  final DateTime createdAt;

  ChatRoom({
    required this.id,
    required this.type,
    this.colocationId,
    this.otherUserId,
    required this.name,
    this.avatar,
    required this.participants,
    required this.lastMessage,
    required this.lastMessageAt,
    required this.unreadCount,
    required this.createdAt,
  });

  // Factory constructor from Firestore document
  factory ChatRoom.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return ChatRoom(
      id: doc.id,
      type: ChatRoomType.values[data['type'] ?? 0],
      colocationId: data['colocationId'],
      otherUserId: data['otherUserId'],
      name: data['name'] ?? 'Unknown',
      avatar: data['avatar'],
      participants: List<String>.from(data['participants'] ?? []),
      lastMessage: data['lastMessage'] ?? '',
      lastMessageAt:
          (data['lastMessageAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      unreadCount: data['unreadCount'] ?? 0,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  // Convert to JSON for Firestore
  Map<String, dynamic> toJson() => {
    'type': type.index,
    'colocationId': colocationId,
    'otherUserId': otherUserId,
    'name': name,
    'avatar': avatar,
    'participants': participants,
    'lastMessage': lastMessage,
    'lastMessageAt': Timestamp.fromDate(lastMessageAt),
    'unreadCount': unreadCount,
    'createdAt': Timestamp.fromDate(createdAt),
  };

  // Copy with for immutability
  ChatRoom copyWith({
    String? id,
    ChatRoomType? type,
    String? colocationId,
    String? otherUserId,
    String? name,
    String? avatar,
    List<String>? participants,
    String? lastMessage,
    DateTime? lastMessageAt,
    int? unreadCount,
    DateTime? createdAt,
  }) => ChatRoom(
    id: id ?? this.id,
    type: type ?? this.type,
    colocationId: colocationId ?? this.colocationId,
    otherUserId: otherUserId ?? this.otherUserId,
    name: name ?? this.name,
    avatar: avatar ?? this.avatar,
    participants: participants ?? this.participants,
    lastMessage: lastMessage ?? this.lastMessage,
    lastMessageAt: lastMessageAt ?? this.lastMessageAt,
    unreadCount: unreadCount ?? this.unreadCount,
    createdAt: createdAt ?? this.createdAt,
  );

  @override
  String toString() => 'ChatRoom(id: $id, name: $name, type: $type)';
}
