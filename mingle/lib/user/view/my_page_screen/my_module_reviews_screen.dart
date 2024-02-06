import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/module/util/module_satisfaction_enum.dart';
import 'package:mingle/module/view/module_details_screen.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';

class MyModuleReviewsScreen extends StatelessWidget {
  const MyModuleReviewsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    List<Widget> author = List.generate(
      4,
      (index) => GestureDetector(
        // onTap: () => Navigator.of(context).push(
        //   MaterialPageRoute(builder: (_) => const ModuleDetailsScreen()),
        // ),
        child: RichText(
            text: const TextSpan(
                children: [
              TextSpan(text: "23년 1학기 "),
              TextSpan(
                  text: "밍끼와 철학",
                  style: TextStyle(
                      color: GRAYSCALE_GRAY_04,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline)),
              TextSpan(text: "에 작성")
            ],
                style: TextStyle(
                    color: GRAYSCALE_GRAY_03,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400))),
      ),
    );

    List<String> reviews = [
      "완전 꿀강임!\n학점 얻어가세요",
      "교수가 제정신이 아님.....................",
      "걍..네",
      "완전 꿀강임!\n학점 얻어가세요"
    ];
    List<moduleSatisfaction> satisfactions = [
      moduleSatisfaction.satisfied,
      moduleSatisfaction.unsatisfied,
      moduleSatisfaction.meh,
      moduleSatisfaction.satisfied
    ];
    List<int> likes = [8, 8, 4, 8];

    Widget reviewCard(String review, Widget author, int likes,
        moduleSatisfaction satisfaction) {
      Widget getSatisfactionWidget(moduleSatisfaction satisfaction) {
        String satisfactionText;
        Color backgroundColor;
        String icon;
        switch (satisfaction) {
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
              style:
                  const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),
            )
          ]),
        );
      }

      return Container(
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(color: GRAYSCALE_GRAY_01, width: 1.0))),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: DefaultPadding(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              getSatisfactionWidget(satisfaction),
            ]),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              review,
            ),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                // Text(
                //   author,
                //   style: const TextStyle(
                //       fontSize: 12.0,
                //       fontWeight: FontWeight.w500,
                //       color: GRAYSCALE_GRAY_04),
                // ),
                author,
                const SizedBox(
                  width: 4.0,
                ),
                SvgPicture.asset(
                    "assets/img/module_review_screen/thubsup_icon.svg"),
                const SizedBox(
                  width: 4.0,
                ),
                Text(
                  likes.toString(),
                  style: const TextStyle(
                      fontSize: 12.0, color: PRIMARY_COLOR_ORANGE_01),
                ),
              ],
            )
          ]),
        ),
      );
    }

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
          "내가 작성한 강의평",
          style: TextStyle(fontSize: 16.0, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            width: double.infinity,
            color: GRAYSCALE_GRAY_01,
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            child: const Text(
              "강의평은 수정하거나 삭제할 수 없습니다.",
              style: TextStyle(fontSize: 12.0, color: GRAYSCALE_GRAY_04),
            ),
          ),
          ...List.generate(
              author.length,
              (index) => reviewCard(reviews[index], author[index], likes[index],
                  satisfactions[index]))
        ],
      )),
    );
  }
}
