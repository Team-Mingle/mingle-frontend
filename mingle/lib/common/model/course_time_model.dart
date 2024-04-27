import 'package:json_annotation/json_annotation.dart';

part 'course_time_model.g.dart';

@JsonSerializable()
class CourseTimeModel {
  final String? dayOfWeek;
  final String? startTime;
  final String? endTime;

  CourseTimeModel({this.dayOfWeek, this.startTime, this.endTime});

  factory CourseTimeModel.fromJson(Map<String, dynamic> json) =>
      _$CourseTimeModelFromJson(json);

  static String removeSecondsFromTime(String time) {
    return time.substring(0, 5);
  }
}


// "dayOfWeek": "MONDAY",
//           "startTime": "HH:mm:SS",
//           "endTime": "HH:mm:SS"