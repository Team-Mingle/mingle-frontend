import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/utils.dart';
import 'package:mingle/common/model/course_time_model.dart';
import 'package:mingle/module/model/course_detail_model.dart';
import 'package:mingle/module/model/course_model.dart';
import 'package:mingle/timetable/components/add_course_time_dropdowns.dart';
import 'package:mingle/timetable/model/class_model.dart';

class EditSelfAddedCourseScreen extends StatefulWidget {
  final Function? addClass;
  final Function? addClassesAtAddTimeTableScreen;
  final CourseModel course;
  const EditSelfAddedCourseScreen({
    Key? key,
    this.addClass,
    this.addClassesAtAddTimeTableScreen,
    required this.course,
  }) : super(key: key);

  @override
  State<EditSelfAddedCourseScreen> createState() =>
      _EditSelfAddedCourseScreenState();
}

class _EditSelfAddedCourseScreenState extends State<EditSelfAddedCourseScreen> {
  List<Widget> timeDropdownWidgets = [];
  String moduleName = "";
  List<String> days = [];
  List<String> startTimes = [];
  List<String> endTimes = [];
  String moduleCode = "";
  String location = "";
  String profName = "";

  @override
  void initState() {
    for (int i = 0; i < widget.course.courseTimeDtoList.length; i++) {
      CourseTimeModel timeModel = widget.course.courseTimeDtoList[i];
      String initialDay = "${convertDayToKorDay(timeModel.dayOfWeek!)}요일";
      String initialStartTime =
          CourseTimeModel.removeSecondsFromTime(timeModel.startTime!);
      String initialEndTime =
          CourseTimeModel.removeSecondsFromTime(timeModel.endTime!);
      days.add(initialDay);
      startTimes.add(initialStartTime);
      endTimes.add(initialEndTime);
      timeDropdownWidgets.add(AddTimeDropdownsWidget(
        onDayChange: onDayChange,
        onStartTimeChange: onStartTimeChange,
        onEndTimeChange: onEndTimeChange,
        index: i,
        initialDay: initialDay,
        initialStartTime: initialStartTime,
        initialEndTime: initialEndTime,
      ));
    }
    moduleName = widget.course.name;
    moduleCode = widget.course.courseCode;
    // location = widget.course.venue;
    profName = widget.course.professor;

    super.initState();
  }

  void addTimeDropdownWidget() {
    if (timeDropdownWidgets.length < 5) {
      // 최대 5번까지 추가
      setState(() {
        timeDropdownWidgets.add(AddTimeDropdownsWidget(
          index: timeDropdownWidgets.length,
          onDayChange: onDayChange,
          onStartTimeChange: onStartTimeChange,
          onEndTimeChange: onEndTimeChange,
        ));
        days.add("");
        startTimes.add("");
        endTimes.add("");
      });
    }
  }

  void onDayChange(value, index) {
    setState(() {
      days[index] = value;
    });
  }

  void onStartTimeChange(value, index) {
    setState(() {
      startTimes[index] = value;
    });
  }

  void onEndTimeChange(value, index) {
    setState(() {
      endTimes[index] = value;
    });
    print(days);
    print(startTimes);
    print(endTimes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 8.0),
            InkWell(
              child: SizedBox(
                width: 40.0,
                height: 48.0,
                child: Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/img/post_screen/cross_icon.svg',
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Spacer(),
            const Text(
              "강의 수정하기",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                letterSpacing: -0.02,
                height: 1.5,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            InkWell(
              child: const Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: Text(
                  "완료하기",
                  style: TextStyle(
                    color: PRIMARY_COLOR_ORANGE_01,
                    fontSize: 14.0,
                    letterSpacing: -0.01,
                    height: 1.4,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              onTap: () {
                ClassModel classModel = ClassModel(
                    days: days,
                    startTimes: startTimes,
                    endTimes: endTimes,
                    moduleCode: moduleCode,
                    moduleName: moduleName,
                    location: location,
                    profName: profName);
                // widget.addClass(classModel);
                // widget.addClassesAtAddTimeTableScreen(classModel);
                Navigator.pop(context);
              },
            ),
          ],
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const Row(
                  children: [
                    Text(
                      '강의명*',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        letterSpacing: -0.01,
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextFormField(
                    initialValue: moduleName,
                    onChanged: (value) {
                      setState(() {
                        moduleName = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "강의명을 입력하세요",
                      hintStyle: const TextStyle(
                        color: GRAYSCALE_GRAY_03,
                        fontSize: 16.0,
                        letterSpacing: -0.02,
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 14.0,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: GRAYSCALE_GRAY_02),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: GRAYSCALE_GRAY_02),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const Row(
                  children: [
                    Text(
                      '강의 시간*',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        letterSpacing: -0.01,
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4.0,
                ),
                const Row(
                  children: [
                    Text(
                      '요일에 따라 강의 시간대가 다를 경우 시간대를 추가하세요.',
                      style: TextStyle(
                        color: GRAYSCALE_GRAY_03,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                ...List.generate(2 * timeDropdownWidgets.length - 1, (index) {
                  if (index % 2 == 0) {
                    return timeDropdownWidgets[index ~/ 2];
                  } else {
                    return const SizedBox(
                      height: 20.0,
                    );
                  }
                }),
                // ...timeDropdownWidgets,
                const SizedBox(
                  height: 12.0,
                ),
                OutlinedButton(
                  onPressed: () {
                    addTimeDropdownWidget();
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 48),
                    side: const BorderSide(
                      width: 1,
                      color: PRIMARY_COLOR_ORANGE_02,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        '추가하기',
                        style: TextStyle(
                          color: PRIMARY_COLOR_ORANGE_02,
                          fontSize: 14.0,
                          letterSpacing: -0.01,
                          height: 1.4,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/img/common/ic_plus_orange.svg',
                        width: 24,
                        height: 24,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const Row(
                  children: [
                    Text(
                      '과목 코드',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        letterSpacing: -0.01,
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextFormField(
                    initialValue: moduleCode,
                    onChanged: (value) {
                      setState(() {
                        moduleCode = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "과목 코드를 입력하세요",
                      hintStyle: const TextStyle(
                        color: GRAYSCALE_GRAY_03,
                        fontSize: 16.0,
                        letterSpacing: -0.02,
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 14.0,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: GRAYSCALE_GRAY_02),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: GRAYSCALE_GRAY_02),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const Row(
                  children: [
                    Text(
                      '강의 장소',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        letterSpacing: -0.01,
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        location = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "강의 장소를 입력하세요",
                      hintStyle: const TextStyle(
                        color: GRAYSCALE_GRAY_03,
                        fontSize: 16.0,
                        letterSpacing: -0.02,
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 14.0,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: GRAYSCALE_GRAY_02),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: GRAYSCALE_GRAY_02),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const Row(
                  children: [
                    Text(
                      '교수명',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        letterSpacing: -0.01,
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextFormField(
                    initialValue: profName,
                    onChanged: (value) {
                      setState(() {
                        profName = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "교수명을 입력하세요",
                      hintStyle: const TextStyle(
                        color: GRAYSCALE_GRAY_03,
                        fontSize: 16.0,
                        letterSpacing: -0.02,
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 14.0,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: GRAYSCALE_GRAY_02),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: GRAYSCALE_GRAY_02),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}