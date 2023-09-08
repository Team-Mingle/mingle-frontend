import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FirstSignupScreen extends StatelessWidget {
  const FirstSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 17.0),
            child: IconButton(
              icon: const ImageIcon(
                AssetImage("asset/img/signup_screen/cross_icon.png"),
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: SvgPicture.asset(
            "asset/img/signup_screen/first_indicator.svg",
            semanticsLabel: 'First indicator',
          )),
    );
  }
}
