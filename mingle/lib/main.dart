// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:mingle/common/const/colors.dart';
// import 'package:mingle/common/const/data.dart';
// import 'package:mingle/common/view/splash_screen.dart';
// import 'package:mingle/dio/dio.dart';
// import 'package:mingle/firebase_options.dart';
// import 'package:mingle/post/models/post_detail_model.dart';
// import 'package:mingle/post/view/post_detail_screen.dart';
// import 'package:mingle/secure_storage/secure_storage.dart';
// import 'package:mingle/user/model/user_model.dart';
// import 'package:mingle/user/provider/user_provider.dart';
// import 'package:mingle/user/view/app_start_screen.dart';
// import 'package:mingle/user/view/home_screen/home_root_tab.dart';
// import 'package:mingle/user/view/login_screen.dart';

// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
// @pragma('vm:entry-point')
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print("function _firebaseMessagingBackgroundHandler");
//   print("Handling a background message: ${message.data['contentId']}");
// }

// @pragma('vm:entry-point')
// void backgroundHandler(NotificationResponse details) {
//   print("backgroundHandler : $details");

//   final parsedJson = jsonDecode(details.payload!);
//   print(parsedJson);
//   if (!parsedJson.containsKey('contentId')) {
//     return;
//   }
//   final int postId = (parsedJson['contentId'] as int);

//   print("알람 : $postId");
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp(
//     name: "mingle",
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   runApp(const _App());
// }

// class _App extends ConsumerStatefulWidget {
//   const _App();

//   @override
//   ConsumerState<_App> createState() => _AppState();
// }

// class _AppState extends ConsumerState<_App> {
//   var messageString = "";

//   @override
//   void initState() {
//     FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//     FirebaseMessaging.instance.requestPermission();

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;

//       if (notification != null) {
//         FlutterLocalNotificationsPlugin().show(
//             notification.hashCode,
//             notification.title,
//             notification.body,
//             const NotificationDetails(
//               android: AndroidNotificationDetails(
//                 'high_importance_channel',
//                 'high_importance_notification',
//                 importance: Importance.max,
//               ),
//               iOS: DarwinNotificationDetails(),
//             ),
//             payload: message.data['contentId']);
//         setState(() {
//           messageString = message.notification!.body!;
//           print("Foreground 메시지 수신: $messageString");
//         });
//       }
//     });

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // 클릭시 할 것
//     void handleNotificationClick(NotificationResponse response) {
//       print('onDidReceiveNotificationResponse - contentId2: $response');
//       final String payload = response.payload ?? "";

//       if (response.payload != null || response.payload!.isNotEmpty) {
//         print('FOREGROUND PAYLOAD: $payload');
//         print(payload.runtimeType);
//         final int postId = int.parse(payload);
//         print("postId : $postId");
//         print(postId.runtimeType);

//         // Navigator.of(context).push(
//         //   MaterialPageRoute(
//         //     builder: (_) => PostDetailScreen(
//         //       postId: postId,
//         //       refreshList: () {},
//         //     ),
//         //   ),
//         // );
//         // final NavigatorState? state = navigatorKey.currentState;
//         // if (payload.isNotEmpty) {
//         //   state.push(
//         //     MaterialPageRoute(
//         //       builder: (_) => PostDetailScreen(
//         //         postId: postId,
//         //         refreshList: () {},
//         //       ),
//         //     ),
//         //   );
//         // }

//         if (payload.isNotEmpty) {
//           final NavigatorState? state = navigatorKey.currentState;
//           print(state);
//           if (state != null) {
//             navigatorKey.currentState?.pushNamed('/PostDetailScreen');
//             state.push(
//               MaterialPageRoute(
//                 builder: (_) => PostDetailScreen(
//                   postId: postId,
//                   refreshList: () {},
//                 ),
//               ),
//             );
//           } else {
//             // Handle the case when navigatorKey.currentState is null
//             print('Navigator state is null!');
//           }
//         }
//       }
//     }

//     void initializeNotification() async {
//       final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//           FlutterLocalNotificationsPlugin();

//       await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               AndroidFlutterLocalNotificationsPlugin>()
//           ?.createNotificationChannel(const AndroidNotificationChannel(
//             'high_importance_channel',
//             'high_importance_notification',
//             importance: Importance.max,
//           ));

//       await flutterLocalNotificationsPlugin.initialize(
//         const InitializationSettings(
//           android: AndroidInitializationSettings("@mipmap/ic_launcher"),
//           iOS: DarwinInitializationSettings(),
//         ),
//         onDidReceiveNotificationResponse: (details) {
//           //클릭시 액션
//           handleNotificationClick(details);
//         },
//         onDidReceiveBackgroundNotificationResponse: backgroundHandler,
//       );

//       void handleMessage(RemoteMessage message) async {
//         final state = navigatorKey.currentState;
//         final accessToken =
//             await ref.watch(secureStorageProvider).read(key: ACCESS_TOKEN_KEY);
//         print(accessToken);
//         await Future.delayed(const Duration(seconds: 2));
//         final Dio dio = ref.read(dioProvider);
//         if (accessToken == null) {
//           Navigator.of(context).pushAndRemoveUntil(
//               MaterialPageRoute(builder: (_) => const AppStartScreen()),
//               (route) => false);
//           return;
//         }
//         try {
//           final resp = await dio.get(
//               'https://$baseUrl/auth/verify-login-status',
//               options:
//                   Options(headers: {'Authorization': 'Bearer $accessToken'}));
//           print(resp);

//           ref
//               .read(currentUserProvider.notifier)
//               .update((state) => UserModel.fromJson(resp.data));
//           //FirebaseAnalytics.instance.logLogin(loginMethod: 'login');
//         } on DioException catch (e) {
//           // print(e.response?.data['message']);
//           // print(e);
//           Navigator.of(context).pushAndRemoveUntil(
//               MaterialPageRoute(builder: (_) => const AppStartScreen()),
//               (route) => false);
//         }
//         if (state != null && message.data['route'] != null) {
//           state.pushNamed(message.data['route']);
//         }
//       }

//       FirebaseMessaging.instance.requestPermission(
//         badge: true,
//         alert: true,
//         sound: true,
//       );

//       FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//         alert: true,
//         badge: true,
//         sound: true,
//       );

//       // 앱이 종료된 상태에서 알림 클릭 처리
//       FirebaseMessaging.instance.getInitialMessage().then((message) {
//         if (message != null) {
//           print(message.notification!.body!);
//           handleMessage(message);
//         }
//       });

//       // 백그라운드에서 알림 클릭 처리
//       FirebaseMessaging.onMessageOpenedApp.listen((message) {
//         print(message.notification!.body!);
//         handleMessage(message);
//       });
//       RemoteMessage? message =
//           await FirebaseMessaging.instance.getInitialMessage();

// //   if (message != null) {
// //     print("알람 : ${message.data}");
// //     FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
// //   }
//     }

//     initializeNotification();
//     return ProviderScope(
//       child: MaterialApp(
//           navigatorKey: navigatorKey,
//           theme: ThemeData(
//             splashColor: Colors.transparent,
//             highlightColor: Colors.transparent,
//             fontFamily: 'Pretendard',
//             disabledColor: GRAYSCALE_GRAY_02,
//             bottomSheetTheme:
//                 const BottomSheetThemeData(backgroundColor: Colors.transparent),
//             textSelectionTheme: const TextSelectionThemeData(
//               cursorColor: GRAYSCALE_GRAY_04,
//               selectionColor: SECONDARY_COLOR_ORANGE_03,
//               selectionHandleColor: PRIMARY_COLOR_ORANGE_01,
//             ),
//             cupertinoOverrideTheme: const CupertinoThemeData(
//               primaryColor: PRIMARY_COLOR_ORANGE_01,
//             ),
//           ),
//           debugShowCheckedModeBanner: false,
//           home: const SplashScreen()),
//     );
//   }
// }

// class _secureStorage {}

// @pragma('vm:entry-point')
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print("function _firebaseMessagingBackgroundHandler");
//   print("Handling a background message: ${message.data['contentId']}");
// }

// @pragma('vm:entry-point')
// void backgroundHandler(NotificationResponse details) {
//   print("backgroundHandler : $details");
// }

// void handleNotificationClick(
//     BuildContext context, NotificationResponse response) {
//   print('onDidReceiveNotificationResponse - contentId2: $response');
//   final String payload = response.payload ?? "";

//   if (response.payload != null || response.payload!.isNotEmpty) {
//     print('FOREGROUND PAYLOAD: $payload');
//     print(payload.runtimeType);
//     final int postId = int.parse(payload);
//     print("postId : $postId");
//     print(postId.runtimeType);

//     if (payload.isNotEmpty) {
//       Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (_) => PostDetailScreen(
//             postId: postId,
//             refreshList: () {},
//           ),
//         ),
//       );
//     }
//   }
// }

// void initializeNotification(BuildContext context) async {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(const AndroidNotificationChannel(
//         'high_importance_channel',
//         'high_importance_notification',
//         importance: Importance.max,
//       ));

//   await flutterLocalNotificationsPlugin.initialize(
//     const InitializationSettings(
//       android: AndroidInitializationSettings("@mipmap/ic_launcher"),
//       iOS: DarwinInitializationSettings(
//         requestAlertPermission: false,
//         requestBadgePermission: false,
//         requestSoundPermission: false,
//       ),
//     ),
//     onDidReceiveNotificationResponse: (details) {
//       // 클릭시 액션
//       handleNotificationClick(context, details);
//     },
//     onDidReceiveBackgroundNotificationResponse: backgroundHandler,
//   );

//   // void handleMessage(BuildContext context, RemoteMessage message) async {
//   //   final state = navigatorKey.currentState;
//   //   final FlutterSecureStorage secureStorage = secureStorageProvider.read();
//   //   final String? accessToken = await secureStorage.read(key: ACCESS_TOKEN_KEY);
//   //   print(accessToken);
//   //   await Future.delayed(const Duration(seconds: 2));
//   //   final Dio dio = Dio();
//   //   if (accessToken == null) {
//   //     Navigator.of(context).pushAndRemoveUntil(
//   //         MaterialPageRoute(builder: (_) => const AppStartScreen()),
//   //         (route) => false);
//   //     return;
//   //   }
//   //   try {
//   //     final resp = await dio.get('https://$baseUrl/auth/verify-login-status',
//   //         options: Options(headers: {'Authorization': 'Bearer $accessToken'}));
//   //     print(resp);

//   //     currentUserProvider.state = UserModel.fromJson(resp.data);
//   //     //FirebaseAnalytics.instance.logLogin(loginMethod: 'login');
//   //   } on DioException catch (e) {
//   //     // print(e.response?.data['message']);
//   //     // print(e);
//   //     Navigator.of(context).pushAndRemoveUntil(
//   //         MaterialPageRoute(builder: (_) => const AppStartScreen()),
//   //         (route) => false);
//   //   }
//   //   if (state != null && message.data['route'] != null) {
//   //     state.pushNamed(message.data['route']);
//   //   }
//   // }

//   FirebaseMessaging.instance.requestPermission(
//     badge: true,
//     alert: true,
//     sound: true,
//   );

//   FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );

//   // 앱이 종료된 상태에서 알림 클릭 처리
//   FirebaseMessaging.instance.getInitialMessage().then((message) {
//     if (message != null) {
//       print(message.notification!.body!);
//       //handleMessage(message);
//     }
//   });

//   // 백그라운드에서 알림 클릭 처리
//   FirebaseMessaging.onMessageOpenedApp.listen((message) {
//     print(message.notification!.body!);
//     //handleMessage(message);
//   });
//   RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();

//   if (message != null) {
//     print("알람 : ${message.data}");
//     FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
//   }
// }

import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/view/splash_screen.dart';
import 'package:mingle/firebase_notification.dart';
import 'package:mingle/firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//StreamController<String> streamController = StreamController.broadcast();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: "mingle",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterLocalNotification.onBackgroundNotificationResponse();
  runApp(const _App());
}

class _App extends ConsumerStatefulWidget {
  const _App();

  @override
  ConsumerState<_App> createState() => _AppState();
}

class _AppState extends ConsumerState<_App> {
  var messageString = "";

  @override
  void initState() {
    FlutterLocalNotification.init();
    Future.delayed(const Duration(seconds: 3),
        FlutterLocalNotification.requestNotificationPermission());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
          navigatorKey: navigatorKey,
          theme: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            fontFamily: 'Pretendard',
            disabledColor: GRAYSCALE_GRAY_02,
            bottomSheetTheme:
                const BottomSheetThemeData(backgroundColor: Colors.transparent),
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: GRAYSCALE_GRAY_04,
              selectionColor: SECONDARY_COLOR_ORANGE_03,
              selectionHandleColor: PRIMARY_COLOR_ORANGE_01,
            ),
            cupertinoOverrideTheme: const CupertinoThemeData(
              primaryColor: PRIMARY_COLOR_ORANGE_01,
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen()),
    );
  }
}
