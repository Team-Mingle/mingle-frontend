import 'package:flutter/material.dart';
import 'package:mingle/common/const/colors.dart';

class ChangeNicknameScreen extends StatelessWidget {
  const ChangeNicknameScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          "닉네임 변경",
          style: TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black),
        ),
      ),
    );
  }
}
