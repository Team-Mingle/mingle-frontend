import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mingle/common/component/next_button.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/common/view/splash_screen.dart';
import 'package:mingle/dio/dio.dart';
import 'package:mingle/secure_storage/secure_storage.dart';
import 'package:mingle/user/model/user_model.dart';
import 'package:mingle/user/provider/is_fresh_login_provider.dart';
import 'package:mingle/user/provider/user_provider.dart';
import 'package:mingle/user/view/app_start_screen.dart';
import 'package:mingle/user/view/home_screen/home_root_tab.dart';
import 'package:mingle/user/view/home_screen/home_tab_screen.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';
import 'package:mingle/user/view/signup_screen/select_country_screen.dart';
import 'package:mingle/user/view/signup_screen/select_school_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  final bool isFromSplash;
  const LoginScreen({super.key, this.isFromSplash = false});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final formGlobalKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _secureStorage = const FlutterSecureStorage();

  String? errorMsg;

  Future<String?> getMyDeviceToken() async {
    String? fcmToken = await _secureStorage.read(key: FCM_TOKEN_KEY);

    if (fcmToken == null) {
      fcmToken = await FirebaseMessaging.instance.getToken();
      print("내 디바이스 토큰 저장: $fcmToken");
      await _secureStorage.write(key: FCM_TOKEN_KEY, value: fcmToken!);
    } else {
      print("저장된 토큰 : $fcmToken");
    }

    return fcmToken;
  }

  @override
  void initState() {
    emailController.addListener(() {
      setState(() {});
    });
    passwordController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dio = ref.watch(dioProvider);

    void validateForm() async {
      final String? fcmtoken = await getMyDeviceToken();
      final credentials = {
        "email": emailController.text,
        "password": passwordController.text,
        "fcmToken": fcmtoken,
      };
      print(credentials);
      try {
        final resp = await dio.post(
          'https://$baseUrl/auth/login',
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
          data: jsonEncode(credentials),
        );
        if (resp.statusCode == 200) {
          final refreshToken = resp.data['refreshToken'];
          final accessToken = resp.data['accessToken'];
          final encryptedEmail = resp.data['hashedEmail'];
          final int memberId = resp.data['memberId'];
          final String nickName = resp.data['nickName'];
          final String univName = resp.data['univName'];
          final String hashedEmail = resp.data['hashedEmail'];

          final UserModel user = UserModel(
              memberId: memberId,
              hashedEmail: hashedEmail,
              nickName: nickName,
              univName: univName);

          final storage = ref.read(secureStorageProvider);
          await storage.write(key: REFRESH_TOKEN_KEY, value: refreshToken);
          await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);
          await storage.write(key: ENCRYPTED_EMAIL_KEY, value: encryptedEmail);
          await storage.write(key: FCM_TOKEN_KEY, value: fcmtoken);
          await storage.write(key: IS_FRESH_LOGIN_KEY, value: "y");
          ref.read(currentUserProvider.notifier).update((state) => user);
          // final r = await dio.post('https://$baseUrl/auth/refresh-token',
          //     options: Options(headers: {
          //       'X-Refresh-Token': refreshToken,
          //       'Content-Type': "application/json",
          //       'accept': "*/*"
          //     }),
          //     data: jsonEncode({"encryptedEmail": encryptedEmail}));
          // final r = await dio.post('https://$baseUrl/auth/refresh-token',
          //     options: Options(headers: {
          //       'X-Refresh-Token': refreshToken,
          //       'Content-Type': "application/json",
          //     }),
          //     data: jsonEncode({"encryptedEmail": encryptedEmail}));
          // print(r.data);
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => HomeRootTab(isFromLogin: true)));
        }
      } on DioException catch (e) {
        // String error = generalErrorMsg;
        // switch (e.response!.data['code']) {
        //   case "FAILED_TO_LOGIN":
        //     error = e.response!.data['message'];
        //   case "MEMBER_DELETED_ERROR":
        //     error = e.response!.data['message'];
        //   case "MEMBER_REPORTED_ERROR":
        //     error = e.response!.data['message'];
        //   default:
        //     error = generalErrorMsg;
        // }
        setState(() {
          errorMsg = e.response?.data['message'] ?? generalErrorMsg;
        });
      }
    }

    return PopScope(
      canPop: false,
      child: Form(
        key: formGlobalKey,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
              backgroundColor: Colors.white,
              appBar: widget.isFromSplash
                  ? AppBar(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      leading: IconButton(
                        icon: const ImageIcon(
                          AssetImage(
                              "assets/img/signup_screen/previous_screen_icon.png"),
                          color: GRAYSCALE_BLACK,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ))
                  : AppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.white,
                      elevation: 0,
                    ),
              body: DefaultPadding(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 34,
                        ),
                        const Text(
                          "로그인",
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 32.0,
                        ),
                        TextFormField(
                          controller: emailController,
                          obscureText: false,
                          decoration: const InputDecoration(
                              hintText: "학교 이메일 주소",
                              hintStyle: TextStyle(color: GRAYSCALE_GRAY_02),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: PRIMARY_COLOR_ORANGE_01)),
                              border: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: GRAYSCALE_GRAY_03))),
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              errorText: errorMsg,
                              hintText: "비밀번호",
                              hintStyle:
                                  const TextStyle(color: GRAYSCALE_GRAY_02),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: PRIMARY_COLOR_ORANGE_01)),
                              border: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: GRAYSCALE_GRAY_03))),
                        ),
                        const SizedBox(
                          height: 66.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const SelectCountryScreen())),
                              child: const Text(
                                "회원가입",
                                style: TextStyle(
                                    color: GRAYSCALE_GRAY_04,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            const SizedBox(
                              height: 16.0,
                              width: 48,
                              child: VerticalDivider(
                                thickness: 1,
                                color: GRAYSCALE_GRAY_04,
                              ),
                            ),
                            InkWell(
                              onTap: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => const SelectCountryScreen(
                                            isPasswordReset: true,
                                          ))),
                              child: const Text(
                                "비밀번호 재설정",
                                style: TextStyle(
                                    color: GRAYSCALE_GRAY_04,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        NextButton(
                          nextScreen: const SplashScreen(),
                          buttonName: "로그인",
                          checkSelected: emailController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty,
                          validators: [validateForm],
                        ),
                        const SizedBox(
                          height: 40.0,
                        )
                      ]),
                ),
              )),
        ),
      ),
    );
  }
}
