import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/dio/dio.dart';
import 'package:mingle/user/model/user_model.dart';
import 'package:mingle/user/provider/user_provider.dart';
import 'package:mingle/user/view/app_start_screen.dart';
import 'package:mingle/user/view/home_screen/home_root_tab.dart';
import 'package:mingle/user/view/login_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  final _secureStorage = const FlutterSecureStorage();
  
  @override
  void initState() {
    checkToken();
    super.initState();
  }

  void checkToken() async {
    final accessToken = await _secureStorage.read(key: ACCESS_TOKEN_KEY);
    final Dio dio = ref.read(dioProvider);
    if (accessToken == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const AppStartScreen()),
          (route) => false);
      return;
    }
    try {
      final resp = await dio.get('https://$baseUrl/auth/verify-login-status',
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));

      ref
          .read(currentUserProvider.notifier)
          .update((state) => UserModel.fromJson(resp.data));
      //FirebaseAnalytics.instance.logLogin(loginMethod: 'login');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => HomeRootTab()), (route) => false);
    } catch (e) {
      print(e);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const AppStartScreen()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR_ORANGE_02,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(
            height: 324,
          ),
          SvgPicture.asset(
            "assets/img/splash_screen/logo_final.svg",
            semanticsLabel: 'Mingle Logo',
          )
        ]),
      ),
    );
  }
}
