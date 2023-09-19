import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/component/next_button.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/user/view/my_page_screen/quit_success_screen.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';

class QuitEnterCredentialScreen extends StatelessWidget {
  const QuitEnterCredentialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 13.0),
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
      body: SafeArea(
        child: DefaultPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                "안전한 탈퇴를 위해",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400),
              ),
              const Text(
                "아이디와 비밀번호를",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400),
              ),
              const Text(
                "입력해 주세요.",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 40.0,
              ),
              SizedBox(
                height: 44,
                child: TextFormField(
                  decoration: const InputDecoration(
                      hintText: "학교 이메일 주소",
                      hintStyle: TextStyle(color: GRAYSCALE_GRAY_02),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: PRIMARY_COLOR_ORANGE_01)),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: GRAYSCALE_GRAY_03))),
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              SizedBox(
                height: 44,
                child: TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      hintText: "비밀번호",
                      hintStyle: TextStyle(color: GRAYSCALE_GRAY_02),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: PRIMARY_COLOR_ORANGE_01)),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: GRAYSCALE_GRAY_03))),
                ),
              ),
              Expanded(child: Container()),
              NextButton(
                  nextScreen: const QuitSuccessStart(),
                  buttonName: "밍글을 탈퇴합니다.")
            ],
          ),
        ),
      ),
    );
  }
}
