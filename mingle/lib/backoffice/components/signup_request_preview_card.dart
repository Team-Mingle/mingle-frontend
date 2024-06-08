import 'package:flutter/material.dart';
import 'package:mingle/backoffice/model/temp_signup_request_model.dart';
import 'package:mingle/backoffice/view/freshman_signup_request_detail_screen.dart';
import 'package:mingle/common/const/colors.dart';

class SignupRequestPreviewCard extends StatelessWidget {
  final int currentIndex;
  final List<TempSignupRequestModel> members;
  final Function removeFromList;
  const SignupRequestPreviewCard(
      {super.key,
      required this.currentIndex,
      required this.members,
      required this.removeFromList});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => FreshmanSignupRequestDetailScreen(
              members: members,
              currentIndex: currentIndex,
              removeFromList: removeFromList),
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
        child: Text("${members[currentIndex].nickname}님의 회원가입 요청입니다."),
      ),
    );
  }
}
