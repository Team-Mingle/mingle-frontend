import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/dio/dio.dart';
import 'package:mingle/secure_storage/secure_storage.dart';
import 'package:mingle/user/model/user_model.dart';
import 'package:mingle/user/provider/user_provider.dart';
import 'package:mingle/user/view/app_start_screen.dart';
import 'package:mingle/user/view/home_screen/home_root_tab.dart';
import 'package:mingle/user/view/login_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkToken();
  }

  void checkToken() async {
    final storage = ref.read(secureStorageProvider);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final Dio dio = ref.read(dioProvider);

    try {
      final resp = await dio.get('https://$baseUrl/auth/verify-login-status',
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));

      ref
          .read(currentUserProvider.notifier)
          .update((state) => UserModel.fromJson(resp.data));
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => HomeRootTab()), (route) => false);
    } catch (e) {
      print(e);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const AppStartScreen()),
          (route) => false);
    }
    //   Navigator.of(context).pushAndRemoveUntil(
    //       MaterialPageRoute(builder: (_) => const HomeRootTab()), (route) => false);
    // } catch (e) {
    //   Navigator.of(context).pushAndRemoveUntil(
    //       MaterialPageRoute(builder: (_) => const LoginScreen()),
    //       (route) => false);
    // }
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
