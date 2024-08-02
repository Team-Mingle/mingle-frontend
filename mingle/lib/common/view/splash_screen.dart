import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/dio/dio.dart';
import 'package:mingle/firebase_notification.dart';
import 'package:mingle/main.dart';
import 'package:mingle/module/view/first_onboarding_screen.dart';
import 'package:mingle/post/view/post_detail_screen.dart';
import 'package:mingle/secure_storage/secure_storage.dart';
import 'package:mingle/upgrader_source/upgrader.dart';
import 'package:mingle/user/model/user_model.dart';
import 'package:mingle/user/provider/user_provider.dart';
import 'package:mingle/user/view/app_start_screen.dart';
import 'package:mingle/user/view/home_screen/home_root_tab.dart';
import 'package:mingle/user/view/login_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashScreen extends ConsumerStatefulWidget {
  final Upgrader upgrader;
  const SplashScreen({super.key, required this.upgrader});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  final _secureStorage = const FlutterSecureStorage();
  var messageString = "";

  @override
  void initState() {
    checkToken();
    super.initState();
  }

  Future<void> checkToken() async {
    final accessToken = await _secureStorage.read(key: ACCESS_TOKEN_KEY);
    print(accessToken);
    await Future.delayed(const Duration(seconds: 2));
    final Dio dio = ref.read(dioProvider);
    if (widget.upgrader.belowMinAppVersion()) {
      print("belowMinAppVersion");
      return;
    }
    if (accessToken == null) {
      _navigateToAppStartScreen();
      return;
    }
    try {
      final resp = await dio.get('https://$baseUrl/auth/verify-login-status',
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));
      // options: Options(headers: {'Authorization': 'Bearer mingle-user'}));
      print(resp);

      ref
          .read(currentUserProvider.notifier)
          .update((state) => UserModel.fromJson(resp.data));
      //FirebaseAnalytics.instance.logLogin(loginMethod: 'login');
      _navigateToHomeRootTab();
    } on DioException catch (e) {
      _navigateToAppStartScreen();
    }
  }

  void _navigateToAppStartScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const AppStartScreen()),
        (route) => false);
  }

  void _navigateToHomeRootTab() {
    Navigator.of(context)
        .pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => HomeRootTab()), (route) => false)
        .then((value) async {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PRIMARY_COLOR_ORANGE_02,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(
              height: 324,
            ),
            SvgPicture.asset(
              "assets/img/splash_screen/logo_final.svg",
              semanticsLabel: 'Mingle Logo',
            )
          ]),
        ));
  }
}
