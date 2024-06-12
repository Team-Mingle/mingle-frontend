import 'package:flutter/material.dart';
import 'package:mingle/backoffice/model/module_review_request_model.dart';
import 'package:mingle/backoffice/model/temp_signup_request_model.dart';
import 'package:mingle/backoffice/view/freshman_module_review_detail_screen.dart';
import 'package:mingle/backoffice/view/freshman_module_review_requests_screen.dart';
import 'package:mingle/backoffice/view/freshman_signup_request_detail_screen.dart';
import 'package:mingle/common/const/colors.dart';

class SignupRequestPreviewCard extends StatelessWidget {
  final int currentIndex;
  final List<dynamic> members;
  final Function removeFromList;
  const SignupRequestPreviewCard(
      {super.key,
      required this.currentIndex,
      required this.members,
      required this.removeFromList});

  @override
  Widget build(BuildContext context) {
    final bool isTempSignup = members is List<TempSignupRequestModel>;
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => isTempSignup
              ? FreshmanSignupRequestDetailScreen(
                  members: members as List<TempSignupRequestModel>,
                  currentIndex: currentIndex,
                  removeFromList: removeFromList)
              : FreshmanModuleReviewDetailScreen(
                  members: members as List<ModuleReviewRequestModel>,
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
        child: Text(
            "${isTempSignup ? members[currentIndex].nickname : members[currentIndex].memberId}님의 회원가입 요청입니다."),
      ),
    );
  }
}
