import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/module/model/course_detail_model.dart';
import 'package:mingle/timetable/model/timetable_model.dart';
import 'package:mingle/timetable/provider/timetable_grid_height_divider_value_provider.dart';
import 'package:mingle/timetable/provider/timetable_grid_height_provider.dart';
import 'package:mingle/timetable/provider/timetable_grid_width_provider.dart';

class TimeTableScreenshotGrid extends ConsumerStatefulWidget {
  final TimetableModel timetable;
  final double height;
  final double width;

  const TimeTableScreenshotGrid(
      {super.key,
      required this.timetable,
      required this.height,
      required this.width});

  @override
  ConsumerState<TimeTableScreenshotGrid> createState() => _TimeTableGridState();
}

class _TimeTableGridState extends ConsumerState<TimeTableScreenshotGrid> {
  late ScrollController _timeScroller;
  late ScrollController _tableScroller;
  ScrollController? currentScroller;
  List<String> days = ['월', '화', '수', '목', '금', '토', '일'];
  List<String> timeSlots = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
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
    '8',
    '9',
    '10',
    '11',
    '12',
  ];
  bool isTimetableFull = false;
  List<Widget> addedClasses = [];

  @override
  void initState() {
    super.initState();
    int gridHeightDividerValue =
        widget.timetable.getGridTotalHeightDividerValue(isScreenshot: true);
    // ref.read(timetableGridHeightDividerValueProvider);
    double gridTotalWidth = widget.width;
    double gridTotalHeight = widget.height;
    const double timetableGridTopSquareHeight = 22.0;
    // 20 is actual height, 2 is top and bottom paddings
    const double timetableGridTopSquareWidth = 22.0;
    // 22 is actual width, 2 is left and right paddings
    final double gridWidth =
        ((gridTotalWidth - timetableGridTopSquareWidth) ~/ 7).toDouble();
    final double gridHeight =
        ((gridTotalHeight - timetableGridTopSquareHeight) ~/
                gridHeightDividerValue)
            .toDouble();

    int startHour = widget.timetable.getCourseStartHour() - 1;

    List<Widget> coursesToBeAdded = [];
    for (CourseDetailModel course in widget.timetable.coursePreviewDtoList) {
      coursesToBeAdded.addAll(course.generateClasses(() {}, ref,
          widget.timetable.getGridTotalHeightDividerValue(isScreenshot: true),
          isScreenshot: true,
          screenShotHeight: widget.height,
          screenShotWidth: widget.width));
    }
    setState(() {
      addedClasses = coursesToBeAdded;
    });
    print("startHour: $startHour");
    _timeScroller =
        ScrollController(initialScrollOffset: gridHeight * startHour);
    _tableScroller =
        ScrollController(initialScrollOffset: gridHeight * startHour);

    // _controllers = LinkedScrollControllerGroup();
    // _timeScroller = _controllers.addAndGet();

    // _tableScroller = _controllers.addAndGet();
    // _controllers.jumpTo(gridHeight * 2);
  }

  @override
  void dispose() {
    _timeScroller.dispose();
    _tableScroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.isAddHeight);

    // print(widget.gridTotalWidth);
    // print((widget.gridTotalWidth - 22) / 7);
    int gridHeightDividerValue =
        widget.timetable.getGridTotalHeightDividerValue(isScreenshot: true);
    // ref.read(timetableGridHeightDividerValueProvider);
    double gridTotalWidth = widget.width;
    double gridTotalHeight = widget.height;

    const double timetableGridTopSquareHeight = 20.0;
    const double timetableGridTopSquareWidth = 22.0;
    final double gridWidth =
        ((gridTotalWidth - timetableGridTopSquareWidth) ~/ 7).toDouble();
    final double gridHeight =
        ((gridTotalHeight - timetableGridTopSquareHeight) ~/
                gridHeightDividerValue)
            .toDouble();

    gridTotalWidth = gridWidth * 7;
    gridTotalHeight = gridHeight * gridHeightDividerValue + 2;

    List<List<Widget>> timetable = List.generate(7, (col) {
      return List.generate(
        24,
        (row) => AnimatedSize(
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 400),
          child: Container(
            // color: Colors.white,
            height: gridHeight,
            width: gridWidth,
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
          ),
        ),
      );
    });

    // print(gridWidth);
    // print(gridHeight);
    // print(gridTotalWidth);
    // print(gridTotalHeight);
    // print(kToolbarHeight);

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
        24,
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
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
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
                    width: timetableGridTopSquareWidth,
                  ),
                ),
                Container(
                  height: 20.0,
                  // width: 338.0,
                  width: gridTotalWidth + 2,
                  decoration: const BoxDecoration(
                    color: GRAYSCALE_GRAY_01,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(8.0)),
                    border: Border(
                      right: BorderSide(color: GRAYSCALE_GRAY_02),
                      top: BorderSide(color: GRAYSCALE_GRAY_02),
                      left: BorderSide(color: GRAYSCALE_GRAY_02),
                      // bottom: BorderSide(color: GRAYSCALE_GRAY_02, width: 0.0),
                    ),
                  ),
                  child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(8.0)),
                      child: Row(
                        children: List.generate(d.length, (index) {
                          return Container(
                            decoration: BoxDecoration(
                              border: Border(
                                right: index == d.length - 1
                                    ? BorderSide.none
                                    : const BorderSide(
                                        color: GRAYSCALE_GRAY_01),
                                // top: BorderSide(color: GRAYSCALE_GRAY_02),
                                // left: BorderSide(color: GRAYSCALE_GRAY_02),
                                // bottom: BorderSide(color: GRAYSCALE_GRAY_02, width: 0.0),
                              ),
                            ),
                            height: 20,
                            width: gridWidth,
                            child: Center(
                              child: d[index],
                            ),
                          );
                        }),
                      )

                      // GridView(
                      //   physics: const NeverScrollableScrollPhysics(),
                      //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      //     crossAxisCount: 7,
                      //     crossAxisSpacing: 1,
                      //     mainAxisSpacing: 1,
                      //     childAspectRatio: 47 / 20,
                      //   ),
                      //   children: d,
                      // ),
                      ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: gridTotalHeight,
                  width: timetableGridTopSquareWidth,
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
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(8.0)),
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _timeScroller,
                        child: Column(
                          children: List.generate(t.length, (index) {
                            return AnimatedSize(
                              curve: Curves.easeOut,
                              duration: const Duration(milliseconds: 400),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: index == 0
                                        ? BorderSide.none
                                        : const BorderSide(
                                            color: GRAYSCALE_GRAY_01),
                                    // top: BorderSide(color: GRAYSCALE_GRAY_02),
                                    // left: BorderSide(color: GRAYSCALE_GRAY_02),
                                    // bottom: BorderSide(color: GRAYSCALE_GRAY_02, width: 0.0),
                                  ),
                                ),
                                height: gridHeight,
                                width: timetableGridTopSquareWidth,
                                child: Center(
                                  child: t[index],
                                ),
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
                  width: gridTotalWidth + 2, // 그리드의 전체 너비
                  height: gridTotalHeight, // 그리드의 전체 높이
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(8),
                    // borderRadius: BorderRadius.circular(8.0),
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(8.0)),
                    color: GRAYSCALE_GRAY_01,
                    border: Border.all(
                      color: GRAYSCALE_GRAY_02,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(8.0)),
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _tableScroller,
                      child: Stack(children: [
                        Row(
                          children: [
                            ...timetable.map((e) => Column(
                                  children: e,
                                ))
                          ],
                        ),
                        ...addedClasses
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
        ),
      ],
    );
  }
}
