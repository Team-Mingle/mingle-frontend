import 'dart:async';
import 'dart:convert';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/view/splash_screen.dart';
import 'package:mingle/firebase_notification.dart';
import 'package:mingle/firebase_options.dart';
import 'package:mingle/module/view/first_onboarding_screen.dart';
import 'package:mingle/module/view/module_review_main_screen.dart';
import 'package:mingle/point_shop/view/point_shop_screen.dart';
import 'package:mingle/post/view/post_detail_screen.dart';
import 'package:mingle/second_hand_market/view/second_hand_post_detail_screen.dart';
import 'package:mingle/timetable/view/friend_timetable_screen.dart';
import 'package:mingle/timetable/view/timetable_tab_screen.dart';
import 'package:mingle/upgrader/lib/upgrader.dart';
import 'package:mingle/user/provider/user_provider.dart';
import 'package:mingle/user/view/home_screen/home_root_tab.dart';
import 'package:mingle/user/view/signup_screen/enter_free_domain_email_screen.dart';
import 'package:mingle/user/view/signup_screen/enter_offer_id_screen.dart';
import 'package:mingle/user/view/signup_screen/finish_temp_signup_screen.dart';
import 'package:mingle/user/view/signup_screen/service_agreement_screen.dart';
import 'package:mingle/user/view/signup_screen/upload_identification_screen.dart';
import 'package:overlay_support/overlay_support.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.data);

  print("Handling a background message: ${message.messageId}");
  final contentType = message.data['contentType'];
  print(contentType);
  final contentId = message.data['contentId'];
  print(contentId);

  // contentId와 contentType 사용
  print('contentId: $contentId');
  print('contentType: $contentType');
  if (contentType == "POST") {
    await Navigator.of(navigatorKey.currentState!.context)
        .push(MaterialPageRoute(
      builder: (_) => PostDetailScreen(
        postId: contentId,
        refreshList: () {},
      ),
    ));
  } else if (contentType == "ITEM") {
    await Navigator.of(navigatorKey.currentState!.context)
        .push(MaterialPageRoute(
      builder: (_) => SecondHandPostDetailScreen(
        itemId: contentId,
        refreshList: () {},
      ),
    ));
  }
}

@pragma('vm:entry-point')
void backgroundHandler(NotificationResponse details) async {
  print("Background Handler : $details");

  if (details.payload != null) {
    List<String> parts = details.payload!.split(',');
    String contentType = parts[0].trim();
    int contentId = int.tryParse(parts[1].trim()) ?? 0;

    // contentId와 contentType 사용
    print('contentId: $contentId');
    print('contentType: $contentType');
    if (contentType == "POST") {
      await Navigator.of(navigatorKey.currentState!.context)
          .push(MaterialPageRoute(
        builder: (_) => PostDetailScreen(
          postId: contentId,
          refreshList: () {},
        ),
      ));
    } else if (contentType == "ITEM") {
      await Navigator.of(navigatorKey.currentState!.context)
          .push(MaterialPageRoute(
        builder: (_) => SecondHandPostDetailScreen(
          itemId: contentId,
          refreshList: () {},
        ),
      ));
    }
  }
}

Future<void> handleNotificationClick(NotificationResponse details) async {
  print('onDidReceiveNotificationResponse - contentId2: $details');

  print(details.payload);

  if (details.payload != null) {
    List<String> parts = details.payload!.split(',');
    String contentType = parts[0].trim();
    int contentId = int.tryParse(parts[1].trim()) ?? 0;

    // contentId와 contentType 사용
    print('contentId: $contentId');
    print('contentType: $contentType');
    if (contentType == "POST") {
      await Navigator.of(navigatorKey.currentState!.context)
          .push(MaterialPageRoute(
        builder: (_) => PostDetailScreen(
          postId: contentId,
          refreshList: () {},
        ),
      ));
    } else if (contentType == "ITEM") {
      await Navigator.of(navigatorKey.currentState!.context)
          .push(MaterialPageRoute(
        builder: (_) => SecondHandPostDetailScreen(
          itemId: contentId,
          refreshList: () {},
        ),
      ));
    }
  }
}

void initializeNotification() async {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(const AndroidNotificationChannel(
          'high_importance_channel', 'high_importance_notification',
          importance: Importance.max));

  await flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(),
    ),
    onDidReceiveNotificationResponse: (details) {
      handleNotificationClick(details);
    },
    onDidReceiveBackgroundNotificationResponse: backgroundHandler,
  );

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    final contentType = message.data['contentType'];
    print(contentType);
    final contentId = message.data['contentId'];
    print(contentId);

    if (notification != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'high_importance_notification',
              importance: Importance.max,
            ),
            iOS: DarwinNotificationDetails(),
          ),
          payload:
              message.data["contentType"] + "," + message.data["contentId"]);
      print("수신자 측 메시지 수신");
    }
  });

  RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    if (message.data['contentType'] == "POST") {
      Navigator.of(navigatorKey.currentState!.context).push(MaterialPageRoute(
          builder: (_) => PostDetailScreen(
              postId: int.parse(message.data['contentId']),
              refreshList: () {})));
    } else if ((message.data['contentType'] == "ITEM")) {
      Navigator.of(navigatorKey.currentState!.context).push(MaterialPageRoute(
          builder: (_) => SecondHandPostDetailScreen(
              itemId: int.parse(message.data['contentId']),
              refreshList: () {})));
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await Firebase.initializeApp(
    name: "mingle",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initializeNotification();

  runApp(const _App());
}

class _App extends ConsumerStatefulWidget {
  const _App();

  @override
  ConsumerState<_App> createState() => _AppState();
}

class _AppState extends ConsumerState<_App> {
  var messageString = "";

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.data['contentType'] == "POST") {
        print(context);
        Navigator.of(navigatorKey.currentState!.context).push(MaterialPageRoute(
            builder: (_) => PostDetailScreen(
                postId: int.parse(message.data['contentId']),
                refreshList: () {})));
      } else if ((message.data['contentType'] == "ITEM")) {
        print(context);
        Navigator.of(navigatorKey.currentState!.context).push(MaterialPageRoute(
            builder: (_) => SecondHandPostDetailScreen(
                itemId: int.parse(message.data['contentId']),
                refreshList: () {})));
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appcastUpgrader = UpgraderAppcastStore(
        appcastURL:
            "https://raw.githubusercontent.com/Team-Mingle/mingle-frontend/timetable-ui/mingle/lib/appcast.xml");
    final upgrader = Upgrader(
        messages: MyUpgraderMessages(),
        storeController: UpgraderStoreController(
          onAndroid: () => appcastUpgrader,
          oniOS: () => appcastUpgrader,
        ),
        minAppVersion: "4.2.0",
        // debugDisplayAlways: true,
        debugLogging: true);
    // upgrader.
    // final upgrader = Upgrader(
    //     minAppVersion: "5.0.0", debugLogging: true, debugDisplayAlways: true);
    return OverlaySupport.global(
      child: ProviderScope(
        child: MaterialApp(
          builder: FToastBuilder(),
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
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: analytics),
          ],
          debugShowCheckedModeBanner: false,
          home:
              // const ModuleReviewMainScreen()
              UpgradeAlert(
            upgrader: upgrader,
            child: SplashScreen(
              upgrader: upgrader,
            ),
          ),
          // HomeRootTab(),
          //  const EnterOfferIdScreen()
          // const FinishTempSinupScreen(),
          // const FirstOnboardingScreen()
          // const PointShopScreen()
          //     const FriendTimetableScreen(
          //   friendId: 1,
          // ),
          // const ServiceAgreementScreen(),
        ),
      ),
    );
  }
}

class MyUpgraderMessages extends UpgraderMessages {
  @override
  String get body => '새 업데이트가 출시되었습니다!';

  @override
  String get buttonTitleUpdate => '업데이트';

  @override
  String get title => '';

  @override
  String get prompt => '';
}
