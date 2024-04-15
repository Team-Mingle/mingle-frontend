import 'package:flutter/material.dart';
import 'package:mingle/common/const/data.dart';

class ClassModel {
  final List<String> days;
  final List<String> startTimes;
  final List<String> endTimes;
  final String moduleCode;
  final String moduleName;
  final String location;
  final String profName;

  ClassModel(
      {required this.days,
      required this.startTimes,
      required this.endTimes,
      required this.moduleCode,
      required this.moduleName,
      required this.location,
      required this.profName});

  int convertDayToInt(String day) {
    switch (day) {
      case "월요일":
        return 0;
      case "화요일":
        return 1;
      case "수요일":
        return 2;
      case "목요일":
        return 3;
      case "금요일":
        return 4;
      case "토요일":
        return 5;
      case "일요일":
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
    for (int i = 0; i < days.length; i++) {
      String startTime = startTimes[i];
      String endTime = endTimes[i];
      double topOffset = convertStartTimeToOffset(startTime);
      double leftOffset = convertDayToInt(days[i]) * TIMETABLE_GRID_WIDTH;
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
              child: Text(moduleCode),
            ),
          ),
        ),
      );
    }
    return classes;
  }
}
