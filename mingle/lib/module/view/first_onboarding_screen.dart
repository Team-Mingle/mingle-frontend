import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/module/view/second_onboarding_screen.dart';
import 'package:show_up_animation/show_up_animation.dart';

class FirstOnboardingScreen extends StatefulWidget {
  const FirstOnboardingScreen({super.key});

  @override
  State<FirstOnboardingScreen> createState() => _FirstOnboardingScreenState();
}

class _FirstOnboardingScreenState extends State<FirstOnboardingScreen> {
  bool isEnabled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500)).then((_) {
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
              MaterialPageRoute(builder: (_) => const SecondOnboardingScreen()))
          : {},
      onHorizontalDragUpdate: (details) {
        // if (details.delta.dx > 0) {
        //   // print("Dragging in +X direction");
        // } else {
        //   // print("Dragging in -X direction");
        // }
        print(details.delta.dx);
        if (details.delta.dx < -20 && isEnabled) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) => const SecondOnboardingScreen()));
          // print("Dragging in +Y direction");
        } else {
          // print("Dragging in -Y direction");
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Center(
              child: Image.asset(
                  "assets/img/timetable_screen/first_onboarding.png"),
            ),
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
                    child: const Text(
                      "이젠 밍글에서 강의평가를 할 수 있어요.",
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
                    "assets/img/module_review_screen/first_indicator_icon.svg"),
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
