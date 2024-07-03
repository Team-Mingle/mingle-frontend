// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:mingle/main.dart';
// import 'package:mingle/post/view/post_detail_screen.dart';

// // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// //     FlutterLocalNotificationsPlugin();

// // class FlutterLocalNotification {
// //   FlutterLocalNotification._();

//   static init() async {
//     // 초기화 설정
//     await _initializeNotifications();

//     // 앱이 종료된 상태에서 알림 클릭 처리
//     FirebaseMessaging.instance.getInitialMessage().then((message) {
//       if (message != null) {
//         _handleMessage(message);
//       }
//     });
//     // 백그라운드에서 알림 클릭 처리
//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       print("앱 열림 : $message");
//       _handleMessage(message);
//     });
//   }

//   // static Future<void> _initializeNotifications() async {
//   //   AndroidInitializationSettings androidInitializationSettings =
//   //       const AndroidInitializationSettings('mipmap/ic_launcher');

//   //   DarwinInitializationSettings iosInitializationSettings =
//   //       const DarwinInitializationSettings(
//   //     requestAlertPermission: false,
//   //     requestBadgePermission: false,
//   //     requestSoundPermission: false,
//   //   );

//   //   InitializationSettings initializationSettings = InitializationSettings(
//   //     android: androidInitializationSettings,
//   //     iOS: iosInitializationSettings,
//   //   );

//   //   await flutterLocalNotificationsPlugin.initialize(
//   //     initializationSettings,
//   //     onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
//   //   );
//   // }

//   static Future<void> _initializeNotifications() async {
//     final AndroidFlutterLocalNotificationsPlugin
//         androidFlutterLocalNotificationsPlugin =
//         flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()!;

//     await androidFlutterLocalNotificationsPlugin
//         .createNotificationChannel(const AndroidNotificationChannel(
//       'high_importance_channel',
//       'high_importance_notification',
//       importance: Importance.max,
//     ));

//     await flutterLocalNotificationsPlugin.initialize(
//       const InitializationSettings(
//         android: AndroidInitializationSettings("@mipmap/ic_launcher"),
//         iOS: DarwinInitializationSettings(
//           requestAlertPermission: false,
//           requestBadgePermission: false,
//           requestSoundPermission: false,
//         ),
//       ),
//       onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
//     );
//   }

//   static _handleMessage(RemoteMessage message) {
//     final routeFromMessage = message.data['contentId'];
//     if (routeFromMessage != null) {
//       print("Navigate to $routeFromMessage");
//       final int postId = int.tryParse(routeFromMessage) ?? 0;

//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         final context = navigatorKey.currentContext;

//         Navigator.of(context!).push(MaterialPageRoute(builder: (context) {
//           return PostDetailScreen(
//             postId: postId,
//             refreshList: () {},
//           );
//         }));
//       });
//     }
//   }

// //   static requestNotificationPermission() {
// //     flutterLocalNotificationsPlugin
// //         .resolvePlatformSpecificImplementation<
// //             IOSFlutterLocalNotificationsPlugin>()
// //         ?.requestPermissions(
// //           alert: true,
// //           badge: true,
// //           sound: true,
// //         );
// //   }

//   // foreground에서 알림 클릭 처리
//   static void onDidReceiveNotificationResponse(
//       NotificationResponse notificationResponse) async {
//     final String payload = notificationResponse.payload ?? "";

//     if (notificationResponse.payload != null ||
//         notificationResponse.payload!.isNotEmpty) {
//       print('FOREGROUND PAYLOAD: $payload');

//       final int postId = int.parse(payload);

//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         final context = navigatorKey.currentContext;

//         Navigator.of(context!).push(MaterialPageRoute(builder: (context) {
//           return PostDetailScreen(
//             postId: postId,
//             refreshList: () {},
//           );
//         }));
//       });
//     }
//   }

//   @pragma('vm:entry-point')
//   static Future<void> onBackgroundNotificationResponse() async {
//     final NotificationAppLaunchDetails? notificationAppLaunchDetails =
//         await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

//     if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
//       String payload =
//           notificationAppLaunchDetails!.notificationResponse?.payload ?? "";

// //       print("BACKGROUND PAYLOAD: $payload");

//       final int postId = int.parse(payload);

//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         final context = navigatorKey.currentContext;

//         Navigator.of(context!).push(MaterialPageRoute(builder: (context) {
//           return PostDetailScreen(
//             postId: postId,
//             refreshList: () {},
//           );
//         }));
//       });
//     }
//   }
// }
