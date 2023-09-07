import 'package:flutter/material.dart';

class AppStartScreen extends StatelessWidget {
  const AppStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(top: 105, bottom: 65.67, left: 5),
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                  "asset/img/login_screen/ios_illust_gradationApply.jpg"),
              fit: BoxFit.cover,
            )),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: const Padding(
            padding: EdgeInsets.only(top: 100, left: 39),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "내 유학생활의 종착지,",
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                "mingle",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400),
              )
            ]),
          ),
        ),
      ]),
    );
  }
}
