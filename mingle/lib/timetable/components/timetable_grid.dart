import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:mingle/common/const/colors.dart';

class TimeTableGrid extends StatefulWidget {
  final List<Widget> timetable;
  const TimeTableGrid({
    super.key,
    required this.timetable,
  });

  @override
  State<TimeTableGrid> createState() => _TimeTableGridState();
}

class _TimeTableGridState extends State<TimeTableGrid> {
  late LinkedScrollControllerGroup _controllers;
  late ScrollController _timeScroller;
  late ScrollController _tableScroller;
  List<String> days = ['월', '화', '수', '목', '금', '토', '일'];
  List<String> timeSlots = [
    '8',
    '9',
    '10',
    '11',
    '12',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8'
  ];

  @override
  void initState() {
    super.initState();
    _controllers = LinkedScrollControllerGroup();
    _timeScroller = _controllers.addAndGet();
    _tableScroller = _controllers.addAndGet();
  }

  @override
  void dispose() {
    _timeScroller.dispose();
    _tableScroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // List<String> days = ['월', '화', '수', '목', '금', '토', '일'];
    // List<String> timeSlots = [
    //   '9',
    //   '10',
    //   '11',
    //   '12',
    //   '1',
    //   '2',
    //   '3',
    //   '4',
    //   '5',
    //   '6'
    // ];
    // List<Widget> timetable = List.generate(70, (index) {
    //   int row = index ~/ (timeSlots.length);
    //   int col = index % (days.length);
    //   double height = row == 0 ? 20.0 : 60.0;
    //   double width = col == 0 ? 21.0 : 47.0;

    //   return Container(
    //     height: height,
    //     width: width,
    //     color: Colors.white,
    //     child: Text("$row $col"),
    //   );
    // });

    List<Widget> d = List.generate(
        7,
        (index) => Container(
              color: Colors.white,
              child: Center(
                  child: Text(
                days[index],
                style: const TextStyle(
                    fontSize: 12.0,
                    letterSpacing: -0.005,
                    height: 1.3,
                    color: GRAYSCALE_GRAY_04),
              )),
            ));
    List<Widget> t = List.generate(
        13,
        (index) => Container(
              color: Colors.white,
              child: Center(
                  child: Text(
                timeSlots[index],
                style: const TextStyle(
                    fontSize: 12.0,
                    letterSpacing: -0.005,
                    height: 1.3,
                    color: GRAYSCALE_GRAY_04),
              )),
            ));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.only(topLeft: Radius.circular(8.0)),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(8.0)),
                  border: Border(
                    right: BorderSide(color: GRAYSCALE_GRAY_02, width: 0.0),
                    top: BorderSide(color: GRAYSCALE_GRAY_02),
                    left: BorderSide(color: GRAYSCALE_GRAY_02),
                    bottom: BorderSide(color: GRAYSCALE_GRAY_02, width: 0.0),
                  ),
                ),
                height: 20.0,
                width: 22.0,
              ),
            ),
            Container(
              height: 20.0,
              width: 337.0,
              decoration: const BoxDecoration(
                color: GRAYSCALE_GRAY_01,
                borderRadius: BorderRadius.only(topRight: Radius.circular(8.0)),
                border: Border(
                  right: BorderSide(color: GRAYSCALE_GRAY_02),
                  top: BorderSide(color: GRAYSCALE_GRAY_02),
                  left: BorderSide(color: GRAYSCALE_GRAY_02),
                  bottom: BorderSide(color: GRAYSCALE_GRAY_02, width: 0.0),
                ),
              ),
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.only(topRight: Radius.circular(8.0)),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio: 47 / 20,
                  ),
                  children: d,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 436.0,
              width: 22.0,
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(8.0)),
                color: GRAYSCALE_GRAY_01,
                border: Border(
                    bottom: BorderSide(color: GRAYSCALE_GRAY_02),
                    top: BorderSide(color: GRAYSCALE_GRAY_02),
                    left: BorderSide(color: GRAYSCALE_GRAY_02),
                    right: BorderSide(color: GRAYSCALE_GRAY_02, width: 0.0)),
              ),
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.only(bottomLeft: Radius.circular(8.0)),
                child: GridView(
                  physics: const ClampingScrollPhysics(),
                  controller: _timeScroller,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio: 21 / 60,
                  ),
                  children: t,
                ),
              ),
            ),
            Container(
              width: 337, // 그리드의 전체 너비
              height: 436, // 그리드의 전체 높이
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(8),
                // borderRadius: BorderRadius.circular(8.0),
                borderRadius:
                    const BorderRadius.only(bottomRight: Radius.circular(8.0)),
                color: GRAYSCALE_GRAY_01,
                border: Border.all(
                  color: GRAYSCALE_GRAY_02,
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.only(bottomRight: Radius.circular(8.0)),
                child: GridView(
                  controller: _tableScroller,
                  physics: const ClampingScrollPhysics(),
                  // physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio: 47 / 60,
                  ),
                  children: widget.timetable,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
