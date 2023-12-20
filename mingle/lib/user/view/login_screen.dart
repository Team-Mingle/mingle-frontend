import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/component/next_button.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/common/view/splash_screen.dart';
import 'package:mingle/dio/dio.dart';
import 'package:mingle/secure_storage/secure_storage.dart';
import 'package:mingle/user/view/home_screen/home_root_tab.dart';
import 'package:mingle/user/view/home_screen/home_tab_screen.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';
import 'package:mingle/user/view/signup_screen/select_country_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final formGlobalKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? errorMsg;

  @override
  void initState() {
    emailController.addListener(() {
      print("email");
      setState(() {});
    });
    passwordController.addListener(() {
      print("pw");
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dio = ref.watch(dioProvider);
    void validateForm() async {
      final credentials = {
        "email": emailController.text,
        "password": passwordController.text,
        "fcmToken": "string"
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
        print(resp.data);
        if (resp.statusCode == 200) {
          print(resp.data);
          final refreshToken = resp.data['refreshToken'];
          final accessToken = resp.data['accessToken'];
          final storage = ref.read(secureStorageProvider);
          await storage.write(key: REFRESH_TOKEN_KEY, value: refreshToken);
          await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const HomeRootTab()));
        } else {
          String? error;
          print(resp.data['code']);
          switch (resp.data['code']) {
            case "FAILED_TO_LOGIN":
              error = resp.data['message'];
            case "MEMBER_DELETED_ERROR":
              error = resp.data['message'];
            case "MEMBER_REPORTED_ERROR":
              error = resp.data['message'];
            default:
              error = "뭔가 잘못됨";
          }
          setState(() {
            errorMsg = error;
          });
        }
      } catch (e) {
        if (e is DioException) {
          print("diodio");
        }
        print(e);
        setState(() {
          errorMsg = generalErrorMsg;
        });
      }
    }

    return Form(
      key: formGlobalKey,
      child: Scaffold(
          body: DefaultPadding(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 112,
                ),
                const Text(
                  "로그인",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400),
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
                          borderSide:
                              BorderSide(color: PRIMARY_COLOR_ORANGE_01)),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: GRAYSCALE_GRAY_03))),
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
                      hintStyle: const TextStyle(color: GRAYSCALE_GRAY_02),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: PRIMARY_COLOR_ORANGE_01)),
                      border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: GRAYSCALE_GRAY_03))),
                ),
                const SizedBox(
                  height: 88.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const SelectCountryScreen())),
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
                      onTap: () {},
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
                )
              ]),
        ),
      )),
    );
  }
}
