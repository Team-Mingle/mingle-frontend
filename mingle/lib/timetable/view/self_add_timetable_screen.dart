import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/timetable/components/add_course_time_dropdowns.dart';
import 'package:mingle/timetable/model/class_model.dart';

class AddDirectTimeTableScreen extends StatefulWidget {
  final Function addClass;
  final Function refresh;
  const AddDirectTimeTableScreen({
    Key? key,
    required this.addClass,
    required this.refresh,
  }) : super(key: key);

  @override
  State<AddDirectTimeTableScreen> createState() =>
      _AddDirectTimeTableScreenState();
}

class _AddDirectTimeTableScreenState extends State<AddDirectTimeTableScreen> {
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
    timeDropdownWidgets.add(
      AddTimeDropdownsWidget(
        index: 0,
        onDayChange: onDayChange,
        onStartTimeChange: onStartTimeChange,
        onEndTimeChange: onEndTimeChange,
      ),
    );
    days.add("");
    startTimes.add("");
    endTimes.add("");
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
              "강의 직접 추가하기",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
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
                widget.addClass(classModel);
                widget.refresh();
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
                        fontSize: 14,
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
                        moduleName = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "강의명을 입력하세요",
                      hintStyle: const TextStyle(
                        color: GRAYSCALE_GRAY_03,
                        fontSize: 16,
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
                        fontSize: 14,
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
                          fontSize: 14,
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
                        fontSize: 14,
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
                        moduleCode = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "과목 코드를 입력하세요",
                      hintStyle: const TextStyle(
                        color: GRAYSCALE_GRAY_03,
                        fontSize: 16,
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
                        fontSize: 14,
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
                        fontSize: 16,
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
                        fontSize: 14,
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
                        profName = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "교수명을 입력하세요",
                      hintStyle: const TextStyle(
                        color: GRAYSCALE_GRAY_03,
                        fontSize: 16,
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
