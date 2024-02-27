import 'package:flutter/material.dart';
import 'package:mingle/common/component/next_button.dart';
import 'package:mingle/user/view/app_start_screen.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';

class QuitSuccessStart extends StatelessWidget {
  const QuitSuccessStart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 74.0,
              ),
              const Text(
                "탈퇴 처리가",
                style: TextStyle(
                    fontSize: 24.0,
                    letterSpacing: -0.04,
                    height: 1.4,
                    fontWeight: FontWeight.w400),
              ),
              const Text(
                "완료되었어요.",
                style: TextStyle(
                    fontSize: 24.0,
                    letterSpacing: -0.04,
                    height: 1.4,
                    fontWeight: FontWeight.w400),
              ),
              Expanded(child: Container()),
              NextButton(
                nextScreen: const AppStartScreen(),
                buttonName: "알겠습니다",
                isReplacement: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
