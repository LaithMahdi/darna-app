import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/config.dart';
import '../models/notification_model.dart';

class NotificationService {
  final FirebaseFirestore _firestore;

  NotificationService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Stream all notifications for a user, sorted by newest first
  Stream<List<NotificationModel>> watchUserNotifications({
    required String userId,
  }) {
    return _firestore
        .collection(Config.notificationsCollection)
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          final notifications = snapshot.docs
              .map(NotificationModel.fromFirestore)
              .toList(growable: false);
          log(
            'watchUserNotifications: fetched ${notifications.length} notifications',
          );
          return notifications;
        });
  }

  /// Stream only unread notifications for a user
  Stream<List<NotificationModel>> watchUnreadNotifications({
    required String userId,
  }) {
    return _firestore
        .collection(Config.notificationsCollection)
        .where('userId', isEqualTo: userId)
        .where('isRead', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          final notifications = snapshot.docs
              .map(NotificationModel.fromFirestore)
              .toList(growable: false);
          log(
            'watchUnreadNotifications: fetched ${notifications.length} unread',
          );
          return notifications;
        });
  }

  /// Get count of unread notifications
  Stream<int> watchUnreadCount({required String userId}) {
    return watchUnreadNotifications(
      userId: userId,
    ).map((notifications) => notifications.length);
  }

  /// Mark a notification as read
  Future<void> markAsRead({required String notificationId}) async {
    try {
      await _firestore
          .collection(Config.notificationsCollection)
          .doc(notificationId)
          .update({'isRead': true, 'readAt': DateTime.now()});
      log('markAsRead: notification $notificationId marked as read');
    } catch (e) {
      log('markAsRead error: $e');
      rethrow;
    }
  }

  /// Mark all notifications as read for a user
  Future<void> markAllAsRead({required String userId}) async {
    try {
      final batch = _firestore.batch();
      final docs = await _firestore
          .collection(Config.notificationsCollection)
          .where('userId', isEqualTo: userId)
          .where('isRead', isEqualTo: false)
          .get();

      for (var doc in docs.docs) {
        batch.update(doc.reference, {'isRead': true, 'readAt': DateTime.now()});
      }

      await batch.commit();
      log('markAllAsRead: marked ${docs.docs.length} notifications as read');
    } catch (e) {
      log('markAllAsRead error: $e');
      rethrow;
    }
  }

  /// Delete a notification
  Future<void> deleteNotification({required String notificationId}) async {
    try {
      await _firestore
          .collection(Config.notificationsCollection)
          .doc(notificationId)
          .delete();
      log('deleteNotification: notification $notificationId deleted');
    } catch (e) {
      log('deleteNotification error: $e');
      rethrow;
    }
  }

  /// Delete all notifications for a user
  Future<void> deleteAllNotifications({required String userId}) async {
    try {
      final batch = _firestore.batch();
      final docs = await _firestore
          .collection(Config.notificationsCollection)
          .where('userId', isEqualTo: userId)
          .get();

      for (var doc in docs.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
      log('deleteAllNotifications: deleted ${docs.docs.length} notifications');
    } catch (e) {
      log('deleteAllNotifications error: $e');
      rethrow;
    }
  }

  /// Create a notification (typically called by backend)
  Future<String> createNotification({
    required String userId,
    required String title,
    required String message,
    required NotificationType type,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final docRef = await _firestore
          .collection(Config.notificationsCollection)
          .add({
            'userId': userId,
            'title': title,
            'message': message,
            'type': type.name,
            'isRead': false,
            'createdAt': DateTime.now(),
            'readAt': null,
            'metadata': metadata,
          });
      log('createNotification: created notification ${docRef.id}');
      return docRef.id;
    } catch (e) {
      log('createNotification error: $e');
      rethrow;
    }
  }
}
