import 'package:flutter/material.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';

class AskMingleScreen extends StatelessWidget {
  const AskMingleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const ImageIcon(
              AssetImage("assets/img/signup_screen/previous_screen_icon.png"),
              color: GRAYSCALE_BLACK,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: const DefaultPadding(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 20.0,
            ),
            Text(
              "궁금한 점은\n아래로 문의주세요",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 23.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "team-mingle@mingle.community",
              style: TextStyle(color: PRIMARY_COLOR_ORANGE_02),
            )
          ]),
        ));
  }
}
