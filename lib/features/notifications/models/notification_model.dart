import 'package:cloud_firestore/cloud_firestore.dart';

enum NotificationType {
  taskAssigned,
  taskCompleted,
  taskReminder,
  houseExpense,
  memberJoined,
  system,
}

class NotificationModel {
  final String id;
  final String userId;
  final String title;
  final String message;
  final NotificationType type;
  final bool isRead;
  final DateTime createdAt;
  final DateTime? readAt;
  final Map<String, dynamic>? metadata; // for task ID, user info, etc

  NotificationModel({
    this.id = '',
    required this.userId,
    required this.title,
    required this.message,
    required this.type,
    this.isRead = false,
    required this.createdAt,
    this.readAt,
    this.metadata,
  });

  factory NotificationModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? <String, dynamic>{};
    final createdAtRaw = data['createdAt'];
    final readAtRaw = data['readAt'];

    final createdAt = createdAtRaw is Timestamp
        ? createdAtRaw.toDate()
        : DateTime.now();
    final readAt = readAtRaw is Timestamp ? readAtRaw.toDate() : null;

    return NotificationModel(
      id: doc.id,
      userId: (data['userId'] ?? '') as String,
      title: (data['title'] ?? '') as String,
      message: (data['message'] ?? '') as String,
      type: _parseNotificationType(data['type'] as String? ?? 'system'),
      isRead: (data['isRead'] ?? false) as bool,
      createdAt: createdAt,
      readAt: readAt,
      metadata: data['metadata'] as Map<String, dynamic>?,
    );
  }

  static NotificationType _parseNotificationType(String type) {
    switch (type) {
      case 'taskAssigned':
        return NotificationType.taskAssigned;
      case 'taskCompleted':
        return NotificationType.taskCompleted;
      case 'taskReminder':
        return NotificationType.taskReminder;
      case 'houseExpense':
        return NotificationType.houseExpense;
      case 'memberJoined':
        return NotificationType.memberJoined;
      default:
        return NotificationType.system;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': title,
      'message': message,
      'type': type.name,
      'isRead': isRead,
      'createdAt': createdAt,
      'readAt': readAt,
      'metadata': metadata,
    };
  }

  // Time ago formatting
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${(difference.inDays / 7).floor()}w ago';
    }
  }

  NotificationModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? message,
    NotificationType? type,
    bool? isRead,
    DateTime? createdAt,
    DateTime? readAt,
    Map<String, dynamic>? metadata,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      readAt: readAt ?? this.readAt,
      metadata: metadata ?? this.metadata,
    );
  }
}
