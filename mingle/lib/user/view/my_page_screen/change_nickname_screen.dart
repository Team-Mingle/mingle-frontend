import 'package:flutter/material.dart';
import 'package:mingle/common/component/next_button.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/user/view/my_page_screen/manage_account_screen.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';

class ChangeNicknameScreen extends StatefulWidget {
  const ChangeNicknameScreen({super.key});

  @override
  State<ChangeNicknameScreen> createState() => _ChangeNicknameScreenState();
}

class _ChangeNicknameScreenState extends State<ChangeNicknameScreen> {
  String currentNickname = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const ImageIcon(
            AssetImage("assets/img/signup_screen/previous_screen_icon.png"),
            color: GRAYSCALE_BLACK,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "닉네임 변경",
          style: TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: DefaultPadding(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 56.0,
            ),
            Container(
              height: 44,
              decoration: const BoxDecoration(color: GRAYSCALE_GRAY_01),
              child: TextFormField(
                decoration: const InputDecoration(
                  enabled: false,
                  hintText: "학교 이메일 주소",
                  hintStyle: TextStyle(color: GRAYSCALE_GRAY_02),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: PRIMARY_COLOR_ORANGE_01)),
                      
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: GRAYSCALE_GRAY_03),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            const Text(
              "학교는 변경할 수 없습니다",
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  color: GRAYSCALE_GRAY_04),
            ),
            const SizedBox(
              height: 25.0,
            ),
            SizedBox(
              // width: 144,
              height: 44,
              child: TextFormField(
                autofocus: true,
                onChanged: (value) {
                  setState(() {
                    currentNickname = value;
                  });
                },
                decoration: InputDecoration(
                    hintText: "닉네임 작성",
                    suffix: Text("${currentNickname.length}/10"),
                    hintStyle: const TextStyle(color: GRAYSCALE_GRAY_02),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: PRIMARY_COLOR_ORANGE_01)),
                    border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: GRAYSCALE_GRAY_03))),
              ),
            ),
            Expanded(child: Container()),
            NextButton(buttonName: "저장하기")
          ],
        )),
      ),
    );
  }
}
