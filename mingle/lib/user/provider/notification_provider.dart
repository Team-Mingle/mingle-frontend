import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/user/model/notification_model.dart';
import 'package:mingle/user/repository/notification_repository.dart';

final notificationProvider =
    FutureProvider<List<NotificationModel>>((ref) async {
  final repository = ref.read(notificationRepositoryProvider);
  try {
    final notifications = await repository.getNotifications();
    debugPrint("API response: $notifications");
    return notifications;
  } catch (e) {
    throw Exception("Failed to fetch notifications: $e");
  }
});
