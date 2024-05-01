import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/module/model/course_model.dart';

class TimeTableGrid extends StatefulWidget {
  final List<Widget> addedClasses;
  final bool isFull;
  final double gridTotalHeight;
  const TimeTableGrid(
      {super.key,
      required this.addedClasses,
      this.isFull = false,
      this.gridTotalHeight = TIMETABLE_TOTAL_HEIGHT});

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
  List<List<Widget>> timetable = List.generate(7, (col) {
    return List.generate(
        13,
        (row) => Container(
              // color: Colors.white,
              height: 61,
              width: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  // bottom: BorderSide(color: GRAYSCALE_GRAY_02),
                  top: row == 0
                      ? BorderSide.none
                      : const BorderSide(color: GRAYSCALE_GRAY_01),
                  right: col == 6
                      ? BorderSide.none
                      : const BorderSide(color: GRAYSCALE_GRAY_01),
                  // right: BorderSide(color: GRAYSCALE_GRAY_02, width: 0.0)
                ),
              ),
              // child: Text("$row $col"),
            ));
  });

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
                    // right: BorderSide(color: GRAYSCALE_GRAY_02, width: 0.0),
                    top: BorderSide(color: GRAYSCALE_GRAY_02),
                    left: BorderSide(color: GRAYSCALE_GRAY_02),
                    // bottom: BorderSide(color: GRAYSCALE_GRAY_02, width: 0.0),
                  ),
                ),
                height: 20.0,
                width: 22.0,
              ),
            ),
            Container(
              height: 20.0,
              width: 338.0,
              decoration: const BoxDecoration(
                color: GRAYSCALE_GRAY_01,
                borderRadius: BorderRadius.only(topRight: Radius.circular(8.0)),
                border: Border(
                  right: BorderSide(color: GRAYSCALE_GRAY_02),
                  top: BorderSide(color: GRAYSCALE_GRAY_02),
                  left: BorderSide(color: GRAYSCALE_GRAY_02),
                  // bottom: BorderSide(color: GRAYSCALE_GRAY_02, width: 0.0),
                ),
              ),
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.only(topRight: Radius.circular(8.0)),
                child: GridView(
                  physics: const NeverScrollableScrollPhysics(),
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
              height: widget.isFull
                  ? widget.gridTotalHeight + 100
                  : widget.gridTotalHeight,
              width: 22.0,
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(8.0)),
                color: GRAYSCALE_GRAY_01,
                border: Border(
                  bottom: BorderSide(color: GRAYSCALE_GRAY_02),
                  top: BorderSide(color: GRAYSCALE_GRAY_02),
                  left: BorderSide(color: GRAYSCALE_GRAY_02),
                  // right: BorderSide(color: GRAYSCALE_GRAY_02, width: 0.0)
                ),
              ),
              child: ClipRRect(
                  borderRadius:
                      const BorderRadius.only(bottomLeft: Radius.circular(8.0)),
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    controller: _timeScroller,
                    child: Column(
                      children: List.generate(t.length, (index) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: index == 0
                                  ? BorderSide.none
                                  : const BorderSide(color: GRAYSCALE_GRAY_01),
                              // top: BorderSide(color: GRAYSCALE_GRAY_02),
                              // left: BorderSide(color: GRAYSCALE_GRAY_02),
                              // bottom: BorderSide(color: GRAYSCALE_GRAY_02, width: 0.0),
                            ),
                          ),
                          height: TIMETABLE_GRID_HEIGHT,
                          width: 22.0,
                          child: Center(
                            child: t[index],
                          ),
                        );
                      }),
                    ),
                  )

                  // GridView(
                  //   padding: EdgeInsets.zero,
                  //   shrinkWrap: true,
                  //   physics: const ClampingScrollPhysics(),
                  //   controller: _timeScroller,
                  //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: 1,
                  //     crossAxisSpacing: 1,
                  //     mainAxisSpacing: 1,
                  //     childAspectRatio: 21 / 60,
                  //   ),
                  //   children: t,
                  // ),
                  ),
            ),
            Container(
              width: 338, // 그리드의 전체 너비
              height: widget.isFull
                  ? widget.gridTotalHeight + 100
                  : widget.gridTotalHeight, // 그리드의 전체 높이
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
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  controller: _tableScroller,
                  child: Stack(children: [
                    Row(
                      children: [
                        ...timetable.map((e) => Column(
                              children: e,
                            ))
                      ],
                    ),
                    ...widget.addedClasses
                    // Positioned(
                    //     top: 366.0,
                    //     left: 48.0,
                    //     child: Container(
                    //       color: Colors.black,
                    //       height: 122.0,
                    //       width: 48.0,
                    //     ))
                  ]),
                ),

                //     Stack(children: [
                //   GridView(
                //     controller: _tableScroller,
                //     physics: const ClampingScrollPhysics(),
                //     // physics: const NeverScrollableScrollPhysics(),
                //     gridDelegate:
                //         const SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 7,
                //       crossAxisSpacing: 1,
                //       mainAxisSpacing: 1,
                //       childAspectRatio: 47 / 60,
                //     ),
                //     children: widget.timetable,
                //   ),
                //   Positioned(
                //       top: 60.0,
                //       left: 47.0,
                //       child: Container(
                //         color: Colors.black,
                //         height: 120.0,
                //         width: 47.0,
                //       ))
                // ]),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
