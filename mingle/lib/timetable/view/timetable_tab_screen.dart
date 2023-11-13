import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/module/view/add_module_review_screen.dart';
import 'package:mingle/module/view/first_onboarding_screen.dart';
import 'package:mingle/module/view/module_review_main_screen.dart';
import 'package:mingle/module/view/module_search_screen.dart';
import 'package:mingle/user/view/home_screen/search_screen.dart';
import 'package:mingle/user/view/my_page_screen/my_page_screen.dart';
import 'package:mingle/timetable/view/add_timetable_screen.dart';
import 'package:mingle/timetable/components/shared_timetable_dropdown.dart';
import 'package:mingle/timetable/components/timetable_grid.dart';
import 'package:mingle/timetable/view/timetable_list_screen.dart';

class TimeTableHomeScreen extends StatefulWidget {
  final int flag = 1;

  const TimeTableHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TimeTableHomeScreen> createState() => _TimeTableHomeScreenState();
}

class _TimeTableHomeScreenState extends State<TimeTableHomeScreen> {
  bool _isFriendListExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR_GRAY,
      appBar: AppBar(
        toolbarHeight: 56.0,
        backgroundColor: BACKGROUND_COLOR_GRAY,
        elevation: 0, // Remove shadow
        leading: Ink(
          width: 44.0,
          height: 48.0,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_) => const MyTimeTableListScreen()),
              );
            },
            child: Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/img/common/ic_list.svg',
                width: 24,
                height: 24,
              ),
            ),
          ),
        ),
        title: const Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  "2022년 2학기",
                  style: TextStyle(
                    color: GRAYSCALE_GRAY_04,
                    fontSize: 12,
                    fontFamily: 'Pretendard Variable',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "시간표 이름",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Pretendard Variable',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
            Spacer(),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/img/common/ic_add.svg',
                width: 24,
                height: 24,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddTimeTableScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/img/common/ic_share.svg',
                width: 24,
                height: 24,
              ),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/img/common/ic_setting.svg',
                width: 24,
                height: 24,
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (widget.flag == 0) // flag 값이 0인 경우
                    const SizedBox(height: 321),
                  if (widget.flag == 0)
                    const Text(
                      '아직 시간표를 만들지 않았어요.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  if (widget.flag == 0) const SizedBox(height: 8),
                  if (widget.flag == 0)
                    GestureDetector(
                      onTap: () {
                        print('새 시간표 추가하기');
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "새 시간표 추가하기",
                            style: TextStyle(
                              fontFamily: "Pretendard Variable",
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: PRIMARY_COLOR_ORANGE_01,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SvgPicture.asset(
                            'assets/img/home_screen/ic_navigation_right_orange.svg',
                            width: 16,
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                  if (widget.flag == 0) const SizedBox(height: 284),
                  if (widget.flag == 1) // flag 값이 1인 경우
                    const Hero(
                      tag: "timetable",
                      child: TimeTableGrid(),
                    ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isFriendListExpanded = !_isFriendListExpanded;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: GRAYSCALE_GRAY_02,
                            width: 1,
                          ),
                        ),
                        child: ExpansionPanelList(
                          elevation: 0,
                          expansionCallback: (int panelIndex, bool isExpanded) {
                            setState(() {
                              _isFriendListExpanded = !_isFriendListExpanded;
                            });
                          },
                          children: [
                            ExpansionPanel(
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) {
                                return const Row(
                                  children: [
                                    Text(
                                      "친구 목록",
                                      style: TextStyle(
                                        fontFamily: "Pretendard Variable",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                );
                              },
                              body: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16.0,
                                  horizontal: 14.5,
                                ),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Friend 1"),
                                    Text("Friend 2"),
                                    Text("Friend 3"),
                                  ],
                                ),
                              ),
                              isExpanded: _isFriendListExpanded,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const ModuleReviewMainScreen()),
                      );
                    },
                    child: Container(
                      width: (MediaQuery.of(context).size.width - 40.0),
                      height: 56,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: GRAYSCALE_GRAY_02,
                            width: 1), // Add this line for the border
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "강의평가 홈 바로가기",
                            style: TextStyle(
                              fontFamily: "Pretendard Variable",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SvgPicture.asset(
                            'assets/img/timetable_screen/link.svg',
                            width: 24,
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 84),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
