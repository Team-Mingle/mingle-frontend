import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/common/const/utils.dart';
import 'package:mingle/common/model/course_time_model.dart';
import 'package:mingle/timetable/provider/pinned_timetable_provider.dart';
import 'package:mingle/timetable/provider/timetable_grid_height_divider_value_provider.dart';
import 'package:mingle/timetable/provider/timetable_grid_height_provider.dart';
import 'package:mingle/timetable/provider/timetable_grid_width_provider.dart';

part 'course_model.g.dart';

@JsonSerializable()
class CourseModel {
  final int id;
  final String name;
  final String courseCode;
  final String? semester;
  final String professor;
  final String subclass;
  final List<CourseTimeModel> courseTimeDtoList;
  final String? rgb;
  String? courseType;

  CourseModel(
      {required this.id,
      required this.name,
      required this.courseCode,
      this.semester,
      this.professor = "-",
      this.subclass = "-",
      required this.courseTimeDtoList,
      required this.courseType,
      this.rgb});

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);

  List<int> convertTimeToIndex(String startTime) {
    List<int> result = [];
    var splitted = startTime.split(":");
    int hour = int.parse(splitted[0]);
    int minutes = int.parse(splitted[1]);
    int hourIndex = hour - 8;
    result.add(hourIndex);
    result.add(minutes);
    return result;
  }

  double convertStartTimeToOffset(String startTime, gridHeight) {
    var splitted = startTime.split(":");
    int hour = int.parse(splitted[0]);
    int minutes = int.parse(splitted[1]);
    double offset = (max(0, hour - 1) + (minutes / 60)) * gridHeight;
    return offset;
  }

  double calculateHeight(String startTime, String endTime, double gridHeight) {
    var startSplitted = startTime.split(":");
    int startHour = int.parse(startSplitted[0]);
    int startMinutes = int.parse(startSplitted[1]);
    var endSplitted = endTime.split(":");
    int endHour = int.parse(endSplitted[0]);
    int endMinutes = int.parse(endSplitted[1]);
    double height =
        (endHour + (endMinutes / 60) - startHour - (startMinutes / 60)) *
            gridHeight;
    return height;
  }

  List<Widget> generateClasses(
      void Function() onTap, WidgetRef ref, int gridTotalHeightDividerValue,
      {bool isFull = false,
      bool isScreenshot = false,
      double screenShotHeight = 0.0,
      double screenShotWidth = 0.0}) {
    List<Widget> classes = [];
    for (int i = 0; i < courseTimeDtoList.length; i++) {
      if (courseTimeDtoList[i].dayOfWeek == null ||
          courseTimeDtoList[i].startTime == null ||
          courseTimeDtoList[i].endTime == null) {
        continue;
      }
      double gridTotalWidth =
          isScreenshot ? screenShotWidth : ref.read(timetableGridWidthProvider);
      double gridTotalHeight = isScreenshot
          ? screenShotHeight
          : ref.read(timetableGridHeightProvider);
      if (isFull) {
        gridTotalHeight += 100;
      }
      // if (isScreenshot) {
      //   gridTotalHeight = screenShotHeight;
      //   gridTotalWidth = screenShotWidth;
      // }
      // int gridTotalHeightDividerValue =
      //     ref.read(pinnedTimetableProvider)!.getGridTotalHeightDividerValue();
      const double timetableGridTopSquareHeight = 20.0;
      // 20 is actual height, 2 is top and bottom paddings
      const double timetableGridTopSquareWidth = 22.0;

      // 22 is actual width, 2 is left and right paddings
      final double gridWidth =
          ((gridTotalWidth - timetableGridTopSquareWidth) ~/ 7).toDouble();
      final double gridHeight =
          ((gridTotalHeight - timetableGridTopSquareHeight) ~/
                  gridTotalHeightDividerValue)
              .toDouble();
      String startTime = courseTimeDtoList[i].startTime!;
      String endTime = courseTimeDtoList[i].endTime!;
      double topOffset = convertStartTimeToOffset(startTime, gridHeight);
      double leftOffset =
          convertDayToInt(courseTimeDtoList[i].dayOfWeek!) * gridWidth;

      double height = calculateHeight(startTime, endTime, gridHeight);
      classes.add(
        // Animated
        Positioned(
          // curve: Curves.easeOut,
          // duration: const Duration(milliseconds: 400),
          top: topOffset,
          left: leftOffset,
          height: height,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: convertRGBtoColor(),
                ),
                // height: height,
                width: gridWidth,
                child: Wrap(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          courseCode,
                          style: const TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis),
                          maxLines: 2,
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          name,
                          style: const TextStyle(
                              fontSize: 12.0, overflow: TextOverflow.ellipsis),
                          maxLines: 1,
                        )
                      ],
                    ),
                  ],
                )),
          ),
        ),
      );
    }
    return classes;
  }

  CourseModel copyWith(
      {int? id,
      String? name,
      String? courseCode,
      String? semester,
      String? professor,
      String? subclass,
      List<CourseTimeModel>? courseTimeDtoList,
      String? rgb,
      String? courseType}) {
    return CourseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      courseCode: courseCode ?? this.courseCode,
      semester: semester ?? this.semester,
      professor: professor ?? this.professor,
      subclass: subclass ?? this.subclass,
      courseTimeDtoList: courseTimeDtoList ?? this.courseTimeDtoList,
      rgb: rgb ?? this.rgb,
      courseType: courseType ?? this.courseType,
    );
  }

  Color convertRGBtoColor() {
    List<String> rgbList = rgb!.split(",");
    int r = int.parse(rgbList[0]);
    int g = int.parse(rgbList[1]);
    int b = int.parse(rgbList[2]);
    return Color.fromRGBO(r, g, b, 1);
  }

  String getStartTimes() {
    List<String> result = [];
    for (CourseTimeModel time in courseTimeDtoList) {
      if (time.dayOfWeek == null || time.startTime == null) {
        continue;
      }
      result.add(
          "${convertDayToKorDay(time.dayOfWeek!)} ${CourseTimeModel.removeSecondsFromTime(time.startTime!)}");
    }
    return result.join("/");
  }
}
