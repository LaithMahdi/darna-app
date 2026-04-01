import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../shared/buttons/custom_back_button.dart';
import '../../../shared/loading/loading_indicator.dart';
import '../../../shared/loading/custom_error_widget.dart';
import '../../../shared/spacer/spacer.dart';
import '../view_models/notification_view_model.dart';
import '../widgets/notification_card.dart';
import '../widgets/notification_empty_data.dart';

class NotificationView extends ConsumerWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final userId = currentUser?.uid ?? '';

    if (userId.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          leading: CustomBackButton(),
          title: Text('Notifications'),
        ),
        body: Center(child: Text('Please log in to view notifications')),
      );
    }

    final notificationsAsync = ref.watch(userNotificationsProvider(userId));

    return Scaffold(
      appBar: AppBar(leading: CustomBackButton(), title: Text('Notifications')),
      body: notificationsAsync.when(
        loading: () => Center(child: LoadingIndicator()),
        error: (error, stack) => CustomErrorWidget(
          title: 'Failed to load notifications',
          message: error.toString(),
          onRetry: () => ref.refresh(userNotificationsProvider(userId)),
        ),
        data: (notifications) => notifications.isEmpty
            ? NotificationEmptyData()
            : ListView.separated(
                padding: EdgeInsets.all(16),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return NotificationCard(
                    notification: notification,
                    onTap: () async {
                      if (!notification.isRead) {
                        await ref
                            .read(notificationViewModelProvider)
                            .markAsRead(notificationId: notification.id);
                      }
                    },
                    onDismiss: () async {
                      await ref
                          .read(notificationViewModelProvider)
                          .deleteNotification(notificationId: notification.id);
                    },
                  );
                },
                separatorBuilder: (context, index) => VerticalSpacer(8),
              ),
      ),
    );
  }
}
