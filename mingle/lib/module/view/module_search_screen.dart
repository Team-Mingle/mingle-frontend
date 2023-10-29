import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';

class ModuleSearchScreen extends StatefulWidget {
  const ModuleSearchScreen({super.key});

  @override
  State<ModuleSearchScreen> createState() => _ModuleSearchScreenState();
}

class _ModuleSearchScreenState extends State<ModuleSearchScreen> {
  List<String> previousSearch = ["CS3230", "CS3203"];
  @override
  void initState() {
    // TODO: implement initState
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
        title: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Container(
            height: 40.0,
            decoration: BoxDecoration(
                color: GRAYSCALE_GRAY_01,
                border: Border.all(color: GRAYSCALE_GRAY_01),
                borderRadius: BorderRadius.circular(8.0)),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                obscureText: false,
                decoration: InputDecoration(
                    hintText: "강의명을 입력하세요.",
                    hintStyle: const TextStyle(
                        color: GRAYSCALE_GRAY_03, fontSize: 16.0),
                    border: InputBorder.none,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                    )),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: previousSearch.isEmpty
            ? [
                const SizedBox(
                  height: 48.0,
                ),
                const Align(
                  child: Text(
                    "최근 검색어 내역이 없습니다.",
                    style: TextStyle(fontSize: 16.0, color: GRAYSCALE_GRAY_03),
                  ),
                )
              ]
            : List.generate(
                previousSearch.length + 1,
                (index) => index == 0
                    ? Container(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 16.0),
                        child: Row(children: [
                          const Text(
                            "최근 검색어",
                            style: TextStyle(color: GRAYSCALE_GRAY_03),
                          ),
                          const Spacer(),
                          GestureDetector(
                            child: const Text(
                              "전체삭제",
                              style: TextStyle(
                                  color: GRAYSCALE_GRAY_04,
                                  fontWeight: FontWeight.w500),
                            ),
                            onTap: () => setState(() {
                              previousSearch.clear();
                            }),
                          )
                        ]),
                      )
                    : recentSearchCard(previousSearch[index - 1], index - 1),
              ),
      ),
    );
  }

  Widget recentSearchCard(String moduleCode, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
      child: Row(
        children: [
          Text(
            moduleCode,
            style: const TextStyle(fontSize: 16.0),
          ),
          const Spacer(),
          const SizedBox(
            width: 8.0,
          ),
          GestureDetector(
            onTap: () => setState(() {
              previousSearch.removeAt(index);
            }),
            child: SvgPicture.asset(
                "assets/img/module_review_screen/close_icon.svg",
                height: 18.0,
                width: 18.0),
          )
        ],
      ),
    );
  }
}
