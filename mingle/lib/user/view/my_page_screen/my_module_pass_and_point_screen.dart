import 'package:flutter/material.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/module/components/my_points_card.dart';
import 'package:mingle/module/components/viewing_pass_card.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';

class MyModulePassAndPointScreen extends StatelessWidget {
  const MyModulePassAndPointScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(
            bottom: BorderSide(color: GRAYSCALE_GRAY_01, width: 1)),
        backgroundColor: Colors.white,
        titleSpacing: 0.0,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: const ImageIcon(
              AssetImage("assets/img/module_review_screen/back_tick_icon.png"),
              color: GRAYSCALE_BLACK,
            ),
            color: GRAYSCALE_BLACK,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: const Text(
          "이용권 및 포인트",
          style: TextStyle(fontSize: 16.0, color: Colors.black),
        ),
      ),
      body: const Column(children: [
        DefaultPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 24.0,
              ),
              Text(
                "나의 이용권",
                style: TextStyle(color: GRAYSCALE_GRAY_04),
              ),
              SizedBox(
                height: 8.0,
              ),
              ViewingPassCard(
                title: "강의평가 30일 조회 이용권",
                purchaseDate: "23.11.4",
                expiryDate: "23.11.4",
              ),
            ],
          ),
        ),
        Divider(
          height: 48.0,
        ),
        DefaultPadding(child: MyPointsCard())
      ]),
    );
  }
}
