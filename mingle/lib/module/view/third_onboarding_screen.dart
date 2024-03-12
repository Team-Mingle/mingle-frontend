import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/module/view/module_review_main_screen.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';
import 'package:show_up_animation/show_up_animation.dart';

class ThirdOnboardingScreen extends StatelessWidget {
  const ThirdOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultPadding(
        child: Column(
          children: [
            const SizedBox(
              height: 96.0,
            ),
            Align(
              alignment: Alignment.center,
              child: ShowUpAnimation(
                // delayStart: const Duration(seconds: 1),
                animationDuration: const Duration(seconds: 1),
                curve: Curves.bounceIn,
                direction: Direction.vertical,
                offset: -0.5,
                child: const Text(
                  "     강의평가를 참고하여\n완벽한 시간표를 짜 봅시다!",
                  style: TextStyle(
                      fontSize: 20.0,
                      letterSpacing: -0.03,
                      height: 1.5,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const Spacer(),
            SvgPicture.asset(
                "assets/img/module_review_screen/third_indicator_icon.svg"),
            const SizedBox(
              height: 32.0,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (_) => const ModuleReviewMainScreen())),
              child: Container(
                height: 48.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: PRIMARY_COLOR_ORANGE_02,
                    border: Border.all(color: PRIMARY_COLOR_ORANGE_02),
                    borderRadius: BorderRadius.circular(8.0)),
                child: const Center(
                  child: Text(
                    "시작하기",
                    style: TextStyle(
                        fontSize: 16.0,
                        letterSpacing: -0.02,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16.0,
            )
          ],
        ),
      ),
    );
  }
}
