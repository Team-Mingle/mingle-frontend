import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/module/view/module_search_screen.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';

class AddModuleReviewScreen extends StatefulWidget {
  const AddModuleReviewScreen({super.key});

  @override
  State<AddModuleReviewScreen> createState() => _AddModuleReviewScreenState();
}

class _AddModuleReviewScreenState extends State<AddModuleReviewScreen> {
  var selecetedSatisfactionIndex;
  String moduleReview = "";
  var selectedSemesterIndex;
  List<String> semesters = ["23년도 2학기", "23년도 1학기", "22년도 2학기"];
  List<String> satisfactions = ["추천해요", "보통이에요", "비추천해요"];
  @override
  void initState() {
    super.initState();
  }

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
          "강의평가 작성",
          style: TextStyle(fontSize: 16.0, color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 23.0),
            child: Center(
              child: GestureDetector(
                onTap: () {},
                child: const Text(
                  "게시하기",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: PRIMARY_COLOR_ORANGE_01),
                ), 
              ),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: GRAYSCALE_GRAY_01,
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            child: const Text(
              "강의를 작성하면 100포인트가 적립됩니다.\n허위, 중복, 저작권 침해, 성의없는 내용 등 이용약관에 위반되는 내용\n작성 시 서비스 이용에 제한을 받거나 포인트 적립이 취소될 수 있습니다.",
              style: TextStyle(fontSize: 12.0, color: GRAYSCALE_GRAY_04),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          DefaultPadding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "강의명*",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const ModuleSearchScreen())),
                  child: Container(
                    height: 48.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: GRAYSCALE_GRAY_02),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(children: [
                        const Text(
                          "강의명을 검색하세요.",
                          style: TextStyle(
                              color: GRAYSCALE_GRAY_03, fontSize: 16.0),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 0.0),
                          child: Hero(
                            tag: "search",
                            child: SvgPicture.asset(
                              "assets/img/module_review_screen/search_icon.svg",
                              height: 24.0,
                              width: 24.0,
                              colorFilter: const ColorFilter.mode(
                                  Colors.black, BlendMode.srcIn),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const Text(
                  "수강시기*",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                GestureDetector(
                  onTap: () => showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 248,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 32.0,
                              ),
                              ListTile(
                                title: Center(
                                  child: Text(
                                    semesters[0],
                                    style: TextStyle(
                                      fontWeight: selectedSemesterIndex == 0
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    selectedSemesterIndex = 0;
                                  }); // 선택한 항목 설정
                                  print("판매중");
                                },
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              ListTile(
                                title: Center(
                                  child: Text(
                                    semesters[1],
                                    style: TextStyle(
                                      fontWeight: selectedSemesterIndex == 1
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    selectedSemesterIndex = 1;
                                  }); // 선택한 항목 설정
                                },
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              ListTile(
                                title: Center(
                                  child: Text(
                                    semesters[2],
                                    style: TextStyle(
                                      fontWeight: selectedSemesterIndex == 2
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    selectedSemesterIndex = 2;
                                  }); // 선택한 항목 설정
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    backgroundColor: Colors.transparent,
                  ),
                  child: Container(
                    width: 167.0,
                    height: 48.0,
                    decoration: BoxDecoration(
                        border: Border.all(color: GRAYSCALE_GRAY_02),
                        borderRadius: BorderRadius.circular(8.0)),
                    padding: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 11.0, vertical: 15.0),
                      child: Row(
                        children: [
                          Text(
                            selectedSemesterIndex != null
                                ? semesters[selectedSemesterIndex]
                                : "수강 년도 및 학기",
                            style: const TextStyle(
                                fontSize: 16.0, color: GRAYSCALE_GRAY_03),
                          ),
                          const Spacer(),
                          SvgPicture.asset(
                            "assets/img/module_review_screen/down_tick_icon.svg",
                            height: 24.0,
                            width: 24.0,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const Text(
                  "강의는 어땠나요?*",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Row(
                  children: List.generate(
                    2 * satisfactions.length - 1,
                    (index) => index % 2 != 0
                        ? const SizedBox(
                            width: 4.0,
                          )
                        : GestureDetector(
                            onTap: () => setState(
                              () {
                                selecetedSatisfactionIndex =
                                    (index / 2).round();
                              },
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: selecetedSatisfactionIndex ==
                                        (index / 2).round()
                                    ? PRIMARY_COLOR_ORANGE_02
                                    : Colors.white,
                                border: Border.all(color: GRAYSCALE_GRAY_01_5),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 8.0),
                              child: Text(
                                satisfactions[(index / 2).round()],
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: selecetedSatisfactionIndex ==
                                            (index / 2).round()
                                        ? Colors.white
                                        : GRAYSCALE_GRAY_04),
                              ),
                            ),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: GRAYSCALE_GRAY_02),
                      borderRadius: BorderRadius.circular(8.0)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 16.0),
                  child: SizedBox(
                    height: 72.0,
                    child: TextFormField(
                      onChanged: (String review) {
                        setState(() {
                          moduleReview = review;
                        });
                      },
                      decoration: const InputDecoration(
                        counterText: "",
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        border: InputBorder.none,
                        hintText: "상품에 대해 설명해 주세요.*",
                        hintStyle: TextStyle(
                            fontSize: 16.0,
                            color: GRAYSCALE_GRAY_02,
                            fontWeight: FontWeight.w600),
                      ),
                      maxLength: 500,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${moduleReview.length}/500",
                    style: const TextStyle(
                        color: GRAYSCALE_GRAY_02, fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
