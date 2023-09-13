import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/user/view/app_start_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => AppStartScreen())),
      child: Scaffold(
        backgroundColor: PRIMARY_COLOR_ORANGE_01,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              height: 324,
            ),
            SvgPicture.asset(
              "assets/img/splash_screen/logo_final.svg",
              semanticsLabel: 'Mingle Logo',
            )
          ]),
        ),
      ),
    );
  }
}
