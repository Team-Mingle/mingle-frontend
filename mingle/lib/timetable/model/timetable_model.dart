import 'dart:math';

import 'package:json_annotation/json_annotation.dart';
import 'package:mingle/common/model/course_time_model.dart';
import 'package:mingle/module/model/course_detail_model.dart';
import 'package:mingle/module/model/course_model.dart';

part 'timetable_model.g.dart';

abstract class TimetableBase {}

@JsonSerializable()
class TimetableModel extends TimetableBase {
  String name;
  final String semester;
  List<CourseDetailModel> coursePreviewDtoList;
  bool isFull;

  TimetableModel(
      {required this.name,
      required this.semester,
      required this.coursePreviewDtoList,
      this.isFull = false});

  factory TimetableModel.fromJson(Map<String, dynamic> json) =>
      _$TimetableModelFromJson(json);

  int getCourseStartHour() {
    List<int> startingHours = [];
    for (CourseDetailModel courseDetailModel in coursePreviewDtoList) {
      for (CourseTimeModel courseTimeModel
          in courseDetailModel.courseTimeDtoList) {
        print(courseTimeModel.startTime);
        startingHours.add(courseTimeModel.getStartingHour());
      }
    }
    startingHours.sort((a, b) => a.compareTo(b));
    print(startingHours);
    return startingHours.isEmpty ? 10 : startingHours[0];
  }

  int getCourseEndHour() {
    List<int> finishingHours = [];
    for (CourseDetailModel courseDetailModel in coursePreviewDtoList) {
      for (CourseTimeModel courseTimeModel
          in courseDetailModel.courseTimeDtoList) {
        finishingHours.add(courseTimeModel.getFinishingHour());
      }
    }
    finishingHours.sort((a, b) => a.compareTo(b));
    return finishingHours.isEmpty
        ? 18
        : finishingHours[finishingHours.length - 1];
  }

  int getGridTotalHeightDividerValue({bool isScreenshot = false}) {
    if (isScreenshot) {
      return max(getCourseEndHour() - getCourseStartHour() + 1, 11);
    }
    return isFull
        ? max(getCourseEndHour() - getCourseStartHour() + 1, 11)
        : max(min(18 - getCourseStartHour() + 1, 11), 9);

    // min()
  }
}

class TimetableLoading extends TimetableBase {}

class TimetableError extends TimetableBase {}

// "name": "string",
//   "semester": "FIRST_SEMESTER_2019",
//   "coursePreviewResponseList": [
//     {
//       "id": 0,
//       "name": "string",
//       "courseCode": "string",
//       "semester": "string",
//       "professor": "string",
//       "subclass": "string",
//       "courseTimeDtoList": [
//         {
//           "dayOfWeek": "MONDAY",
//           "startTime": "HH:mm:SS",
//           "endTime": "HH:mm:SS"
//         }
//       ]
//     }
//   ]