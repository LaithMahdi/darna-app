import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/notification_model.dart';
import '../service/notification_service.dart';

class NotificationViewModel {
  final Ref ref;

  NotificationViewModel({required this.ref});

  /// Get all notifications for user
  Stream<List<NotificationModel>> getUserNotifications({
    required String userId,
  }) {
    final service = ref.read(notificationServiceProvider);
    return service.watchUserNotifications(userId: userId);
  }

  /// Get only unread notifications
  Stream<List<NotificationModel>> getUnreadNotifications({
    required String userId,
  }) {
    final service = ref.read(notificationServiceProvider);
    return service.watchUnreadNotifications(userId: userId);
  }

  /// Get unread count
  Stream<int> getUnreadCount({required String userId}) {
    final service = ref.read(notificationServiceProvider);
    return service.watchUnreadCount(userId: userId);
  }

  /// Mark notification as read
  Future<void> markAsRead({required String notificationId}) async {
    final service = ref.read(notificationServiceProvider);
    await service.markAsRead(notificationId: notificationId);
  }

  /// Mark all as read
  Future<void> markAllAsRead({required String userId}) async {
    final service = ref.read(notificationServiceProvider);
    await service.markAllAsRead(userId: userId);
  }

  /// Delete notification
  Future<void> deleteNotification({required String notificationId}) async {
    final service = ref.read(notificationServiceProvider);
    await service.deleteNotification(notificationId: notificationId);
  }

  /// Delete all notifications
  Future<void> deleteAllNotifications({required String userId}) async {
    final service = ref.read(notificationServiceProvider);
    await service.deleteAllNotifications(userId: userId);
  }

  /// Get statistics
  Stream<NotificationStats> getNotificationStats({required String userId}) {
    return getUserNotifications(userId: userId).map((all) {
      final unread = all.where((n) => !n.isRead).toList();
      final taskNotifications = all
          .where((n) => n.type.name.contains('task'))
          .toList();
      final expenseNotifications = all
          .where((n) => n.type == NotificationType.houseExpense)
          .toList();

      return NotificationStats(
        total: all.length,
        unreadCount: unread.length,
        taskCount: taskNotifications.length,
        expenseCount: expenseNotifications.length,
      );
    });
  }
}

class NotificationStats {
  final int total;
  final int unreadCount;
  final int taskCount;
  final int expenseCount;

  NotificationStats({
    required this.total,
    required this.unreadCount,
    required this.taskCount,
    required this.expenseCount,
  });
}

// Riverpod Providers
final notificationServiceProvider = Provider((ref) => NotificationService());

final notificationViewModelProvider = Provider((ref) {
  return NotificationViewModel(ref: ref);
});

/// Watch all notifications for a user
final userNotificationsProvider =
    StreamProvider.family<List<NotificationModel>, String>((ref, userId) {
      final viewModel = ref.watch(notificationViewModelProvider);
      return viewModel.getUserNotifications(userId: userId);
    });

/// Watch unread notifications for a user
final unreadNotificationsProvider =
    StreamProvider.family<List<NotificationModel>, String>((ref, userId) {
      final viewModel = ref.watch(notificationViewModelProvider);
      return viewModel.getUnreadNotifications(userId: userId);
    });

/// Watch unread count
final unreadCountProvider = StreamProvider.family<int, String>((ref, userId) {
  final viewModel = ref.watch(notificationViewModelProvider);
  return viewModel.getUnreadCount(userId: userId);
});

/// Watch notification statistics
final notificationStatsProvider =
    StreamProvider.family<NotificationStats, String>((ref, userId) {
      final viewModel = ref.watch(notificationViewModelProvider);
      return viewModel.getNotificationStats(userId: userId);
    });

/// Future provider for marking as read
final markAsReadProvider = FutureProvider.family<void, String>((
  ref,
  notificationId,
) async {
  final viewModel = ref.watch(notificationViewModelProvider);
  await viewModel.markAsRead(notificationId: notificationId);
});

/// Future provider for marking all as read
final markAllAsReadProvider = FutureProvider.family<void, String>((
  ref,
  userId,
) async {
  final viewModel = ref.watch(notificationViewModelProvider);
  await viewModel.markAllAsRead(userId: userId);
});

/// Future provider for deletion
final deleteNotificationProvider = FutureProvider.family<void, String>((
  ref,
  notificationId,
) async {
  final viewModel = ref.watch(notificationViewModelProvider);
  await viewModel.deleteNotification(notificationId: notificationId);
});
