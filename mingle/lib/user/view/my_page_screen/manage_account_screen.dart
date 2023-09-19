import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/user/components/my_page_tile.dart';

class ManageAccountScreen extends StatelessWidget {
  const ManageAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> manageAccountTitle = ["닉네임 변경", "비밀번호 변경", "탈퇴하기"];

    return Scaffold(
      backgroundColor: BACKGROUND_COLOR_GRAY,
      appBar: AppBar(
        backgroundColor: BACKGROUND_COLOR_GRAY,
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
          "계정 관리",
          style: TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 14.0),
        child: MyPageTile(
          list: manageAccountTitle,
          screen: Container(),
        ),
      ),
    );
  }
}
