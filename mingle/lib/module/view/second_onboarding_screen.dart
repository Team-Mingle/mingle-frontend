import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/module/view/third_onboarding_screen.dart';
import 'package:show_up_animation/show_up_animation.dart';

class SecondOnboardingScreen extends StatefulWidget {
  const SecondOnboardingScreen({super.key});

  @override
  State<SecondOnboardingScreen> createState() => _SecondOnboardingScreenState();
}

class _SecondOnboardingScreenState extends State<SecondOnboardingScreen> {
  bool isEnabled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 2000)).then((_) {
      setState(() {
        isEnabled = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => isEnabled
          ? Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const ThirdOnboardingScreen()))
          : {},
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
                "assets/img/module_review_screen/second_onboarding_background.png"),
            Column(
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
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(children: [
                          TextSpan(
                            text: "다른 사용자가 작성한 강의평가를 보려면\n",
                            style: TextStyle(
                                fontSize: 20.0,
                                letterSpacing: -0.03,
                                height: 1.5,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                          TextSpan(
                            text: "포인트샵에서 이용권을 구매해야 해요.",
                            style: TextStyle(
                                fontSize: 20.0,
                                letterSpacing: -0.03,
                                height: 1.5,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          )
                        ]),
                      )),
                  // ),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.center,
                  child: ShowUpAnimation(
                    delayStart: const Duration(milliseconds: 500),
                    animationDuration: const Duration(seconds: 1),
                    curve: Curves.bounceIn,
                    direction: Direction.vertical,
                    offset: 0.5,
                    child: const Text(
                      "포인트는 강의평가를 작성하여 얻을 수 있어요.",
                      style: TextStyle(
                          fontSize: 16.0,
                          letterSpacing: -0.02,
                          height: 1.5,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 91.0,
                ),
                SvgPicture.asset(
                    "assets/img/module_review_screen/second_indicator_icon.svg"),
                const SizedBox(
                  height: 96.0,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
