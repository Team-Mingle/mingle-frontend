import 'package:flutter/material.dart';
import 'package:mingle/backoffice/view/freshman_signup_request_detail_screen.dart';
import 'package:mingle/common/const/colors.dart';

class SignupRequestPreviewCard extends StatelessWidget {
  final int currentIndex;
  const SignupRequestPreviewCard({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => FreshmanSignupRequestDetailScreen(
            memberIds: List.generate(30, (index) => index.toString()),
            currentIndex: currentIndex,
          ),
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: GRAYSCALE_GRAY_03),
          ),
        ),
        child: const Text("닉네임님의 회원가입 요청입니다."),
      ),
    );
  }
}
