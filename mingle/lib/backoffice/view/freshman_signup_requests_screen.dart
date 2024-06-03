import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/backoffice/components/signup_request_preview_card.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';

class FreshmanSignupRequestScreen extends StatefulWidget {
  const FreshmanSignupRequestScreen({super.key});

  @override
  State<FreshmanSignupRequestScreen> createState() =>
      _FreshmanSignupRequestScreenState();
}

class _FreshmanSignupRequestScreenState
    extends State<FreshmanSignupRequestScreen> {
  List<Widget> signupRequests = List.generate(
      30,
      (index) => SignupRequestPreviewCard(
            currentIndex: index,
          ));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: InkWell(
            child: SvgPicture.asset("assets/img/signup_screen/cross_icon.svg",
                fit: BoxFit.scaleDown),
            onTap: () => Navigator.of(context).pop(),
          ),
        ),
        title: const Text(
          "신입생 회원가입 요청",
          style: TextStyle(
              fontSize: 16.0,
              letterSpacing: -0.02,
              height: 1.5,
              fontWeight: FontWeight.w400,
              color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            ...signupRequests,
            const SizedBox(
              height: 10.0,
            )
          ],
        ),
      ),
    );
  }
}
