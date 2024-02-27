import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/component/next_button.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/user/view/login_screen.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';

class PasswordChangeSuccessScreen extends StatelessWidget {
  const PasswordChangeSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 17.0),
            child: IconButton(
              icon: const ImageIcon(
                AssetImage("assets/img/signup_screen/previous_screen_icon.png"),
                color: GRAYSCALE_BLACK,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: DefaultPadding(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "비밀번호 재설정이",
                            style: TextStyle(
                                fontSize: 24.0,
                                letterSpacing: -0.04,
                                height: 1.4,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "완료되었어요.",
                            style: TextStyle(
                                fontSize: 24.0,
                                letterSpacing: -0.04,
                                height: 1.4,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 128.0,
                  ),
                  Image.asset("assets/img/my_page_screen/lock_icon.png"),
                  Expanded(child: Container()),
                  NextButton(
                    buttonName: "로그인 화면으로",
                    nextScreen: const LoginScreen(),
                    isReplacement: true,
                  ),
                  const SizedBox(
                    height: 40.0,
                  )
                ]),
          ),
        ));
  }
}
