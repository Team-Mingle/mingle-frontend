import 'package:flutter/material.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/module/view/add_module_review_screen.dart';

class MyPointsCard extends StatelessWidget {
  const MyPointsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: GRAYSCALE_GRAY_01,
          border: Border.all(color: GRAYSCALE_GRAY_01),
          borderRadius: BorderRadius.circular(8.0)),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Row(
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("보유 포인트"),
              SizedBox(
                height: 8.0,
              ),
              Text(
                "0p",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              )
            ],
          ),
          const Spacer(),
          const SizedBox(
            width: 8.0,
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => const AddModuleReviewScreen())),
            child: const Text(
              "강의평가 작성하기",
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: PRIMARY_COLOR_ORANGE_01),
            ),
          )
        ],
      ),
    );
  }
}
