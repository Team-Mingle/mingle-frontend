import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/common/model/course_time_model.dart';

part 'course_preview_model.g.dart';

@JsonSerializable()
class CoursePreviewModel {
  final int id;
  final String courseCode;
  final String semester;
  final String professor;
  final String subclass;
  final List<CourseTimeModel> courseTimeDtoList;

  CoursePreviewModel(
      {required this.id,
      required this.courseCode,
      required this.semester,
      required this.professor,
      required this.subclass,
      required this.courseTimeDtoList});

  factory CoursePreviewModel.fromJson(Map<String, dynamic> json) =>
      _$CoursePreviewModelFromJson(json);

  int convertDayToInt(String day) {
    switch (day) {
      case "MONDAY":
        return 0;
      case "TUESDAY":
        return 1;
      case "WEDNESDAY":
        return 2;
      case "THURSDAY":
        return 3;
      case "FRIDAY":
        return 4;
      case "SATURDAY":
        return 5;
      case "SUNDAY":
        return 6;
      default:
        return 0;
    }
  }

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

  List<Widget> generateClases() {
    List<Widget> classes = [];
    for (int i = 0; i < courseTimeDtoList.length; i++) {
      String startTime = courseTimeDtoList[i].startTime;
      String endTime = courseTimeDtoList[i].endTime;
      double topOffset = convertStartTimeToOffset(startTime);
      double leftOffset = convertDayToInt(courseTimeDtoList[i].dayOfWeek) *
          TIMETABLE_GRID_WIDTH;
      double height = calculateHeight(startTime, endTime);
      classes.add(
        Positioned(
          top: topOffset,
          left: leftOffset,
          child: GestureDetector(
            child: Container(
              height: height,
              width: TIMETABLE_GRID_WIDTH,
              color: Colors.yellow,
              child: Text(courseCode),
            ),
          ),
        ),
      );
    }
    return classes;
  }
}
