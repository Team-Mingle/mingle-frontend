import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/common/view/splash_screen.dart';
import 'package:mingle/dio/dio.dart';
import 'package:mingle/firebase_options.dart';
import 'package:mingle/post/models/post_detail_model.dart';
import 'package:mingle/post/view/post_detail_screen.dart';
import 'package:mingle/secure_storage/secure_storage.dart';
import 'package:mingle/user/model/user_model.dart';
import 'package:mingle/user/provider/user_provider.dart';
import 'package:mingle/user/view/app_start_screen.dart';
import 'package:mingle/user/view/home_screen/home_root_tab.dart';
import 'package:mingle/user/view/login_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class _App extends ConsumerStatefulWidget {
  const _App();

  @override
  ConsumerState<_App> createState() => _AppState();
}

class _AppState extends ConsumerState<_App> {
  var messageString = "";

  @override
  void initState() {
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null&& android != null) {
        FlutterLocalNotificationsPlugin().show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'high_importance_notification',
              importance: Importance.max,
            ),
          ),
        );
        setState(() {
          messageString = message.notification!.body!;
          print("Foreground 메시지 수신: $messageString");
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> firebaseMessagingBackgroundHandler(
        RemoteMessage message) async {
      print("백그라운드 메시지 처리.. ${message.notification!.body!}");
    }

    void handleNotificationClick(NotificationResponse response) {
      print('onDidReceiveNotificationResponse - payload: ${response.payload}');
      final payload = response.payload ?? '';

      final parsedJson = jsonDecode(payload);
      if (!parsedJson.containsKey('contentId')) {
        return;
      }

      final int postId = (parsedJson['routeTo'] as int);

      final state = navigatorKey.currentState;
      if (state != null) {
        state.push(MaterialPageRoute(
          builder: (_) => PostDetailScreen(
            postId: postId,
            refreshList: () {},
          ),
        ));
      }
    }

    void initializeNotification() async {
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();

      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      const InitializationSettings initializationSettings =
          InitializationSettings(android: initializationSettingsAndroid);

      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse response) async {
          handleNotificationClick(response);
        },
      );

      void handleMessage(RemoteMessage message) async {
        final state = navigatorKey.currentState;
        final accessToken =
            await ref.watch(secureStorageProvider).read(key: ACCESS_TOKEN_KEY);
        print(accessToken);
        await Future.delayed(const Duration(seconds: 2));
        final Dio dio = ref.read(dioProvider);
        if (accessToken == null) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const AppStartScreen()),
              (route) => false);
          return;
        }
        try {
          final resp = await dio.get(
              'https://$baseUrl/auth/verify-login-status',
              options:
                  Options(headers: {'Authorization': 'Bearer $accessToken'}));
          print(resp);

          ref
              .read(currentUserProvider.notifier)
              .update((state) => UserModel.fromJson(resp.data));
          //FirebaseAnalytics.instance.logLogin(loginMethod: 'login');
        } on DioException catch (e) {
          // print(e.response?.data['message']);
          // print(e);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const AppStartScreen()),
              (route) => false);
        }
        if (state != null && message.data['route'] != null) {
          state.pushNamed(message.data['route']);
        }
      }

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(
            const AndroidNotificationChannel(
              'high_importance_channel',
              'High Importance Notifications',
              description: 'Description for high importance channel',
              importance: Importance.high,
            ),
          );

      FirebaseMessaging.instance.requestPermission(
        badge: true,
        alert: true,
        sound: true,
      );

      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      // 앱이 종료된 상태에서 알림 클릭 처리
      FirebaseMessaging.instance.getInitialMessage().then((message) {
        if (message != null) {
          print(message.notification!.body!);
          handleMessage(message);
        }
      });

      // 백그라운드에서 알림 클릭 처리
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        print(message.notification!.body!);
        handleMessage(message);
      });
    }

    Future<void> main() async {
      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp(
        name: "mingle",
        options: DefaultFirebaseOptions.currentPlatform,
      );
      runApp(const _App());
      initializeNotification();
    }

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

class _secureStorage {}
