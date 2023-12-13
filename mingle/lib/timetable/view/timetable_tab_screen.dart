import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/module/view/module_details_screen.dart';
import 'package:mingle/timetable/components/add_friend_dialog.dart';
import 'package:mingle/timetable/components/timetable_list_more_modal.dart';
import 'package:mingle/timetable/model/class_model.dart';
import 'package:mingle/timetable/view/add_timetable_screen.dart';
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
  List<Color> availableCoursePalette = [
    const Color(0xFFFBE9EF),
    const Color(0xFFDCF5DA),
    const Color(0xFFFFEBCD),
    const Color(0xFFE1F6F6),
    const Color(0xFFEFDDEF),
    const Color(0xFFD4E2F3),
    const Color(0xFFEBD6CB),
    const Color(0xFFBDD4C7),
    const Color(0xFFCECEE9),
    const Color(0xFFE7EFCE),
  ];

  List<Color> usedCoursePalette = [];
  List<ClassModel> addedClasses = [];
  // int daysLength = 7;
  List<Widget> timetable = List.generate(91, (index) {
    int row = index ~/ 7;
    int col = index % 7;
    double height = row == 0 ? 20.0 : 60.0;
    double width = col == 0 ? 21.0 : 47.0;

    return Container(
      height: height,
      width: width,
      color: Colors.white,
      child: Text("$row $col"),
    );
  });

  void MoreButtonModal() {
    Future.delayed(const Duration(milliseconds: 40)).then((_) {
      showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        isScrollControlled: false,
        context: context,
        builder: (BuildContext context) {
          return const TimetableMoreModalwidget();
        },
      );
    });
  }

  void addClass(ClassModel classModel) {
    print(classModel.days);
    print(classModel.startTimes);
    print(classModel.endTimes);
    print(classModel.moduleName);
    print(classModel.moduleCode);
    print(classModel.location);
    print(classModel.profName);
    List<List<int>> startTimesIndex = [];
    List<List<int>> endTimesIndex = [];
    List<int> colIndex = [];
    addedClasses.add(classModel);
    Color currentColor = availableCoursePalette[0];
    usedCoursePalette.add(currentColor);
    availableCoursePalette.removeAt(0);
    for (String startTime in classModel.startTimes) {
      startTimesIndex.add(classModel.convertTimeToIndex(startTime));
    }
    for (String endTime in classModel.endTimes) {
      endTimesIndex.add(classModel.convertTimeToIndex(endTime));
    }
    for (String day in classModel.days) {
      colIndex.add(classModel.convertDayToInt(day));
    }
    //Case 1: start hour and end hour equal
    //Case 2: end hour > start hour

    for (int i = 0; i < colIndex.length; i++) {
      List<int> startTimeIndex = startTimesIndex[i];
      List<int> endTimeIndex = endTimesIndex[i];
      int col = colIndex[i];
      int startHour = startTimeIndex[0];
      double startMinutes = startTimeIndex[1].toDouble();
      int endHour = endTimeIndex[0];
      double endMinutes = endTimeIndex[1].toDouble();
      if (startHour == endHour) {
        int index = (startHour * 7) + col;
        List<Widget> newTimetable = timetable;
        newTimetable[index] = SizedBox(
          width: double.infinity,
          height: 60.0,
          child: Column(children: [
            Container(
              height: startMinutes,
              color: Colors.white,
            ),
            Container(
              height: endMinutes - startMinutes,
              width: double.infinity,
              color: currentColor,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      classModel.moduleCode,
                      style: const TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      classModel.location,
                      style: const TextStyle(fontSize: 12.0),
                    )
                  ]),
            ),
            Container(
              height: 60 - endMinutes,
              color: Colors.white,
            )
          ]),
        );
        setState(() {
          timetable = newTimetable;
        });
      } else {
        for (int j = startHour;
            j <= (endMinutes > 0 ? endHour : endHour - 1);
            j++) {
          int index = (j * 7) + col;
          if (j == startHour) {
            setState(() {
              timetable[index] = SizedBox(
                width: double.infinity,
                height: 60.0,
                child: Column(children: [
                  Container(
                    height: startMinutes,
                    color: Colors.white,
                  ),
                  Container(
                    height: 60 - startMinutes,
                    color: currentColor,
                    child: startMinutes > 30
                        ? Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              classModel.moduleCode,
                              style: const TextStyle(
                                  fontSize: 12.0, fontWeight: FontWeight.w600),
                            ))
                        : Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    classModel.moduleCode,
                                    style: const TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    classModel.location,
                                    style: const TextStyle(fontSize: 12.0),
                                  )
                                ]),
                          ),
                  ),
                ]),
              );
            });
          } else if (j == endHour) {
            setState(() {
              timetable[index] = SizedBox(
                width: double.infinity,
                height: 60.0,
                child: Column(children: [
                  Container(
                    height: endMinutes,
                    color: currentColor,
                    child: endHour == startHour + 1 && startMinutes > 30
                        ? Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              classModel.location,
                              style: const TextStyle(fontSize: 12.0),
                            ))
                        : Container(),
                  ),
                  Container(
                    height: 60 - endMinutes,
                    color: Colors.white,
                  )
                ]),
              );
            });
          } else {
            setState(() {
              timetable[index] = Container(
                width: double.infinity,
                height: 60.0,
                color: currentColor,
                child: j == startHour + 1 && startMinutes > 30
                    ? Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          classModel.location,
                          style: const TextStyle(fontSize: 12.0),
                        ))
                    : Container(),
              );
            });
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> t = timetable;
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR_GRAY,
      appBar: AppBar(
        toolbarHeight: 56.0,
        backgroundColor: BACKGROUND_COLOR_GRAY,
        elevation: 0,
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
                  builder: (context) => AddTimeTableScreen(
                    timetable: t,
                    addClass: addClass,
                  ),
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
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const AddFriendDialog();
                },
              );
            },
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
            onPressed: () {
              MoreButtonModal();
            },
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
                    Hero(
                      tag: "timetable",
                      child: TimeTableGrid(
                        timetable: t,
                      ),
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
                            builder: (_) => const ModuleDetailsScreen()),
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
