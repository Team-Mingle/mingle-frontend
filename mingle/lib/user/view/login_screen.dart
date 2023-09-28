import 'package:flutter/material.dart';
import 'package:mingle/common/component/next_button.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/view/splash_screen.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';
import 'package:mingle/user/view/signup_screen/select_country_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultPadding(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
          const TextField(
            obscureText: true,
            decoration: InputDecoration(
                hintText: "학교 이메일 주소",
                hintStyle: TextStyle(color: GRAYSCALE_GRAY_02),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: PRIMARY_COLOR_ORANGE_01)),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: GRAYSCALE_GRAY_03))),
          ),
          const SizedBox(
            height: 25.0,
          ),
          const TextField(
            obscureText: true,
            decoration: InputDecoration(
                hintText: "비밀번호",
                hintStyle: TextStyle(color: GRAYSCALE_GRAY_02),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: PRIMARY_COLOR_ORANGE_01)),
                border: UnderlineInputBorder(
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
          NextButton(nextScreen: const SplashScreen(), buttonName: "로그인")
        ]),
      ),
    ));
  }
}
