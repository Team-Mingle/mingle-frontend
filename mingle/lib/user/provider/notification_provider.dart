import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/user/model/notification_model.dart';
import 'package:mingle/user/repository/notification_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final notificationProvider =
    FutureProvider<List<NotificationModel>>((ref) async {
  final repository = ref.read(notificationRepositoryProvider);
  try {
    final cachedNotifications = await getCachedNotifications();
    if (cachedNotifications != null) {
      debugPrint("Notifications loaded from cache: $cachedNotifications");
      return cachedNotifications;
    }
    final notifications = await repository.getNotifications();
    debugPrint("API response: $notifications");
    await cacheNotifications(notifications);

    debugPrint("Notifications fetched from API and cached: $notifications");
    return notifications;
  } catch (e) {
    throw Exception("Failed to fetch notifications: $e");
  }
});

Future<List<NotificationModel>?> getCachedNotifications() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final cachedJson = prefs.getString('notificationsCache');
    if (cachedJson != null) {
      final parsedNotifications = (jsonDecode(cachedJson) as List)
          .map((json) => NotificationModel.fromJson(json))
          .toList();
      return parsedNotifications;
    }
    return null;
  } catch (e) {
    debugPrint("Error getting cached notifications: $e");
    return null;
  }
}

Future<void> cacheNotifications(List<NotificationModel> notifications) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = jsonEncode(notifications);
    await prefs.setString('notificationsCache', jsonData);
  } catch (e) {
    debugPrint("Error caching notifications: $e");
  }
}
