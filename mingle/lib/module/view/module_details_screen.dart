import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/component/expanded_section.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/module/components/module_review_card.dart';
import 'package:mingle/module/util/module_satisfaction_enum.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';

class ModuleDetailsScreen extends StatefulWidget {
  const ModuleDetailsScreen({super.key});

  @override
  State<ModuleDetailsScreen> createState() => _ModuleDetailsScreenState();
}

class _ModuleDetailsScreenState extends State<ModuleDetailsScreen> {
  bool isExpanded = false;
  List<String> authors = [
    "23년 1학기 수강자",
    "23년 1학기 수강자(나)",
    "23년 1학기 수강자",
    "23년 1학기 수강자"
  ];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          "강의개요",
          style: TextStyle(fontSize: 16.0, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultPadding(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 24.0,
                  ),
                  const Text(
                    "강의 정보",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                  const Row(
                    children: [
                      SizedBox(
                        width: 72.0,
                        child: Text(
                          "강의명",
                          style: TextStyle(color: GRAYSCALE_GRAY_03),
                        ),
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      Text("밍글학개론")
                    ],
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  const Row(
                    children: [
                      SizedBox(
                        width: 72.0,
                        child: Text(
                          "과목 코드",
                          style: TextStyle(color: GRAYSCALE_GRAY_03),
                        ),
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      Text("MNGL2001")
                    ],
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  const Row(
                    children: [
                      SizedBox(
                        width: 72.0,
                        child: Text(
                          "교수명",
                          style: TextStyle(color: GRAYSCALE_GRAY_03),
                        ),
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      Text("밍끼")
                    ],
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  const Row(
                    children: [
                      SizedBox(
                        width: 72.0,
                        child: Text(
                          "강의시간",
                          style: TextStyle(color: GRAYSCALE_GRAY_03),
                        ),
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      Text("화2/수2")
                    ],
                  ),
                  ExpandedSection(
                    expand: isExpanded,
                    child: expandedModuleInformation(),
                  ),
                  const SizedBox(
                    height: 31.5,
                  ),
                  GestureDetector(
                    onTap: () => setState(() {
                      isExpanded = !isExpanded;
                    }),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isExpanded ? "과목 정보 접기" : "과목 정보 더보기",
                          style: const TextStyle(color: GRAYSCALE_GRAY_04),
                        ),
                        SvgPicture.asset(isExpanded
                            ? "assets/img/module_review_screen/up_tick_icon.svg"
                            : "assets/img/module_review_screen/down_tick_icon.svg")
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15.5,
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 16.0,
              color: GRAYSCALE_GRAY_01,
            ),
            const SizedBox(
              height: 50.0,
            ),
            DefaultPadding(
              child: Column(
                children: [
                  Row(
                    children: [
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                                text: "강의평",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                            TextSpan(
                                text: "(56)",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                    color: GRAYSCALE_GRAY_03))
                          ],
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            const Text("등록순"),
                            SvgPicture.asset(
                                "assets/img/module_review_screen/down_tick_icon.svg")
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  ...List.generate(
                      authors.length,
                      (index) => ModuleReviewCard(
                          reivew: reviews[index],
                          author: authors[index],
                          likes: likes[index],
                          satisfaction: satisfactions[index]))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget expandedModuleInformation() {
    return Column(
      children: [
        const SizedBox(
          height: 24.0,
        ),
        const Row(
          children: [
            SizedBox(
              width: 72.0,
              child: Text(
                "수강인원",
                style: TextStyle(color: GRAYSCALE_GRAY_03),
              ),
            ),
            SizedBox(
              width: 12.0,
            ),
            Text("25")
          ],
        ),
        const SizedBox(
          height: 24.0,
        ),
        Row(
          children: [
            const SizedBox(
              width: 72.0,
              child: Text(
                "선이수과목",
                style: TextStyle(color: GRAYSCALE_GRAY_03),
              ),
            ),
            const SizedBox(
              width: 12.0,
            ),
            preRequisites("밍끼와문학"),
            const SizedBox(
              width: 4.0,
            ),
            preRequisites("밍글로고디자인")
          ],
        ),
        const SizedBox(
          height: 24.0,
        ),
        const Row(
          children: [
            SizedBox(
              width: 72.0,
              child: Text(
                "학년",
                style: TextStyle(color: GRAYSCALE_GRAY_03),
              ),
            ),
            SizedBox(
              width: 12.0,
            ),
            Text("4학년")
          ],
        ),
        const SizedBox(
          height: 24.0,
        ),
        const Row(
          children: [
            SizedBox(
              width: 72.0,
              child: Text(
                "구분",
                style: TextStyle(color: GRAYSCALE_GRAY_03),
              ),
            ),
            SizedBox(
              width: 12.0,
            ),
            Text("Major Core Module")
          ],
        ),
        const SizedBox(
          height: 24.0,
        ),
        const Row(
          children: [
            SizedBox(
              width: 72.0,
              child: Text(
                "장소",
                style: TextStyle(color: GRAYSCALE_GRAY_03),
              ),
            ),
            SizedBox(
              width: 12.0,
            ),
            Text("밍글관 401호")
          ],
        ),
        const SizedBox(
          height: 24.0,
        ),
        const Row(
          children: [
            SizedBox(
              width: 72.0,
              child: Text(
                "학점",
                style: TextStyle(color: GRAYSCALE_GRAY_03),
              ),
            ),
            SizedBox(
              width: 12.0,
            ),
            Text("6")
          ],
        ),
        const SizedBox(
          height: 24.0,
        ),
        const Row(
          children: [
            SizedBox(
              width: 72.0,
              child: Text(
                "수강대상",
                style: TextStyle(color: GRAYSCALE_GRAY_03),
              ),
            ),
            SizedBox(
              width: 12.0,
            ),
            Text("1학년 한정")
          ],
        ),
      ],
    );
  }

  Widget preRequisites(String moduleName) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: GRAYSCALE_GRAY_01,
          border: Border.all(color: GRAYSCALE_GRAY_01),
          borderRadius: BorderRadius.circular(16.0)),
      child: Row(children: [
        Text(
          moduleName,
          style: const TextStyle(color: GRAYSCALE_GRAY_05, fontSize: 12.0),
        ),
        SvgPicture.asset("assets/img/module_review_screen/right_tick_icon.svg")
      ]),
    );
  }
}
