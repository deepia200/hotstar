// // notification_provider.dart
// import 'package:flutter/material.dart';
// import '../models/notification_model.dart';
//
//
// class NotificationProvider extends ChangeNotifier {
//   final List<NotificationModel> _notifications = [];
//
//   List<NotificationModel> get notifications => _notifications;
//
//   void addNotification(NotificationModel notification) {
//     _notifications.insert(0, notification);
//     notifyListeners();
//   }
//
//   void clearNotifications() {
//     _notifications.clear();
//     notifyListeners();
//   }
// }
