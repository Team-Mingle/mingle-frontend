import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/module/util/module_satisfaction_enum.dart';
import 'package:mingle/module/view/module_details_screen.dart';

class ModuleReviewCard extends StatefulWidget {
  final String reivew;
  final String semester;
  final moduleSatisfaction satisfaction;
  final int likes;
  final bool isFromMypageScreen;
  final bool isMine;
  final int? courseId;
  const ModuleReviewCard({
    super.key,
    required this.reivew,
    required this.semester,
    required this.likes,
    required this.satisfaction,
    required this.isMine,
    required this.courseId,
    this.isFromMypageScreen = false,
  });

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
          // SvgPicture.asset(
          //     "assets/img/module_review_screen/triple_dot_icon.svg")
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
            getAuthorWidget(),
            // Text(
            //   widget.semester,
            //   style: const TextStyle(
            //       fontSize: 12.0,
            //       letterSpacing: -0.005,
            //       height: 1.3,
            //       fontWeight: FontWeight.w500,
            //       color: GRAYSCALE_GRAY_04),
            // ),
            // const SizedBox(
            //   width: 4.0,
            // ),
            // SvgPicture.asset(
            //     "assets/img/module_review_screen/thubsup_icon.svg"),
            // const SizedBox(
            //   width: 4.0,
            // ),
            // Text(
            //   widget.likes.toString(),
            //   style: const TextStyle(
            //       fontSize: 12.0,
//letterSpacing: -0.005,
//height: 1.3, color: PRIMARY_COLOR_ORANGE_01),
            // ),
            const Spacer(),
            // const Text(
            //   "공감하기",
            //   style: TextStyle(fontSize: 12.0,
//letterSpacing: -0.005,
//height: 1.3, color: GRAYSCALE_GRAY_04),
            // )
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
          style: const TextStyle(
              fontSize: 12.0,
              letterSpacing: -0.005,
              height: 1.3,
              fontWeight: FontWeight.w500),
        )
      ]),
    );
  }

  Widget getAuthorWidget() {
    if (!widget.isFromMypageScreen) {
      return Text(
        widget.isMine ? "${widget.semester} 수강자(나)" : "${widget.semester} 수강자",
        style: const TextStyle(
            fontSize: 12.0,
            letterSpacing: -0.005,
            height: 1.3,
            fontWeight: FontWeight.w500,
            color: GRAYSCALE_GRAY_04),
      );
    } else {
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(text: "${widget.semester} "),
            WidgetSpan(
                child: GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) =>
                      ModuleDetailsScreen(courseId: widget.courseId!))),
              child: const Text("밍끼와 철학",
                  style: TextStyle(
                      color: GRAYSCALE_GRAY_04,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline)),
            )),
            // const TextSpan(
            //     text: "밍끼와 철학",
            //     style: TextStyle(
            //         color: GRAYSCALE_GRAY_04,
            //         fontWeight: FontWeight.w500,
            //         decoration: TextDecoration.underline)),
            const TextSpan(text: "에 작성")
          ],
          style: const TextStyle(
              color: GRAYSCALE_GRAY_03,
              fontSize: 12.0,
              letterSpacing: -0.005,
              height: 1.3,
              fontWeight: FontWeight.w400),
        ),
      );
    }
  }
}
