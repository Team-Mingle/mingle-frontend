import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/module/util/module_satisfaction_enum.dart';

class ModuleReviewCard extends StatefulWidget {
  String reivew;
  String author;
  moduleSatisfaction satisfaction;
  int likes;
  ModuleReviewCard(
      {super.key,
      required this.reivew,
      required this.author,
      required this.likes,
      required this.satisfaction});

  @override
  State<ModuleReviewCard> createState() => _ModuleReviewCardState();
}

class _ModuleReviewCardState extends State<ModuleReviewCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(color: GRAYSCALE_GRAY_01, width: 1.0))),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          getSatisfactionWidget(),
          const Spacer(),
          SvgPicture.asset(
              "assets/img/module_review_screen/triple_dot_icon.svg")
        ]),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          widget.reivew,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Row(
          children: [
            Text(
              widget.author,
              style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: GRAYSCALE_GRAY_04),
            ),
            const SizedBox(
              width: 4.0,
            ),
            SvgPicture.asset(
                "assets/img/module_review_screen/thubsup_icon.svg"),
            const SizedBox(
              width: 4.0,
            ),
            Text(
              widget.likes.toString(),
              style: const TextStyle(
                  fontSize: 12.0, color: PRIMARY_COLOR_ORANGE_01),
            ),
            const Spacer(),
            const Text(
              "공감하기",
              style: TextStyle(fontSize: 12.0, color: GRAYSCALE_GRAY_04),
            )
          ],
        )
      ]),
    );
  }

  Widget getSatisfactionWidget() {
    String satisfactionText;
    Color backgroundColor;
    String icon;
    switch (widget.satisfaction) {
      case moduleSatisfaction.satisfied:
        satisfactionText = "추천해요";
        backgroundColor = SATISFIED_GREEN;
        icon =
            "assets/img/module_review_screen/satisfied_satisfaction_icon.svg";
      case moduleSatisfaction.meh:
        satisfactionText = "보통이에요";
        backgroundColor = GRAYSCALE_GRAY_01;
        icon = "assets/img/module_review_screen/meh_satisfaction_icon.svg";
      case moduleSatisfaction.unsatisfied:
        satisfactionText = "비추천해요";
        backgroundColor = UNSATISFIED_RED;
        icon =
            "assets/img/module_review_screen/unsatisfied_satisfaction_icon.svg";
    }
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: backgroundColor),
          borderRadius: BorderRadius.circular(12.0)),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(children: [
        SvgPicture.asset(icon),
        const SizedBox(
          width: 4.0,
        ),
        Text(
          satisfactionText,
          style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),
        )
      ]),
    );
  }
}
