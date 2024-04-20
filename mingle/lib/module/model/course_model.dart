import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/common/const/utils.dart';
import 'package:mingle/common/model/course_time_model.dart';

part 'course_model.g.dart';

@JsonSerializable()
class CourseModel {
  final int id;
  final String name;
  final String courseCode;
  final String? semester;
  final String professor;
  final String? subclass;
  final List<CourseTimeModel> courseTimeDtoList;
  final String? rgb;

  CourseModel(
      {required this.id,
      required this.name,
      required this.courseCode,
      this.semester,
      required this.professor,
      this.subclass,
      required this.courseTimeDtoList,
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

  double convertStartTimeToOffset(String startTime) {
    var splitted = startTime.split(":");
    int hour = int.parse(splitted[0]);
    int minutes = int.parse(splitted[1]);
    double offset = (hour - 8 + (minutes / 60)) * TIMETABLE_GRID_HEIGHT;
    return offset;
  }

  double calculateHeight(String startTime, String endTime) {
    var startSplitted = startTime.split(":");
    int startHour = int.parse(startSplitted[0]);
    int startMinutes = int.parse(startSplitted[1]);
    var endSplitted = endTime.split(":");
    int endHour = int.parse(endSplitted[0]);
    int endMinutes = int.parse(endSplitted[1]);
    double height =
        (endHour + (endMinutes / 60) - startHour - (startMinutes / 60)) *
            TIMETABLE_GRID_HEIGHT;
    return height;
  }

  List<Widget> generateClasses(void Function() onTap) {
    List<Widget> classes = [];
    for (int i = 0; i < courseTimeDtoList.length; i++) {
      String startTime = courseTimeDtoList[i].startTime!;
      String endTime = courseTimeDtoList[i].endTime!;
      double topOffset = convertStartTimeToOffset(startTime);
      double leftOffset = convertDayToInt(courseTimeDtoList[i].dayOfWeek!) *
          TIMETABLE_GRID_WIDTH;
      double height = calculateHeight(startTime, endTime);
      classes.add(
        Positioned(
          top: topOffset,
          left: leftOffset,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              height: height,
              width: TIMETABLE_GRID_WIDTH,
              color: convertRGBtoColor(),
              child: Text(courseCode),
            ),
          ),
        ),
      );
    }
    return classes;
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
      result.add("${convertDayToKorDay(time.dayOfWeek!)} ${time.startTime}");
    }
    return result.join("/");
  }
}
