// notifications_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/notification_provider.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  String _formatTimestamp(DateTime timestamp) {
    // Format the timestamp as needed, e.g., '2 hours ago'
    final duration = DateTime.now().difference(timestamp);
    if (duration.inMinutes < 60) {
      return '${duration.inMinutes} minutes ago';
    } else if (duration.inHours < 24) {
      return '${duration.inHours} hours ago';
    } else {
      return '${duration.inDays} days ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NotificationProvider(),
      child: Consumer<NotificationProvider>(
        builder: (context, notificationProvider, child) {
          final notifications = notificationProvider.notifications;

          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: const Text(
                'Notifications',
                style: TextStyle(color: Colors.white),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
              actions: [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    notificationProvider.clearNotifications();
                  },
                ),
              ],
            ),
            body: notifications.isEmpty
                ? const Center(
              child: Text(
                'No notifications',
                style: TextStyle(color: Colors.white70),
              ),
            )
                : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return ListTile(
                  title: Text(
                    notification.title,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    notification.message,
                    style: const TextStyle(color: Colors.white70),
                  ),
                  trailing: Text(
                    _formatTimestamp(notification.timestamp),
                    style: const TextStyle(color: Colors.white54),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
