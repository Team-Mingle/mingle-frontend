import 'package:flutter/material.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/module/view/add_module_review_screen.dart';

class MyPointsCard extends StatelessWidget {
  final int pointsOwned;
  const MyPointsCard({super.key, required this.pointsOwned});

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("보유 포인트"),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                "${pointsOwned}p",
                style: const TextStyle(
                    fontSize: 16.0,
                    letterSpacing: -0.02,
                    height: 1.5,
                    fontWeight: FontWeight.w500),
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
