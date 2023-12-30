import 'package:json_annotation/json_annotation.dart';

part 'course_time_model.g.dart';

@JsonSerializable()
class CourseTimeModel {
  final String dayOfWeek;
  final String startTime;
  final String endTime;

  CourseTimeModel(
      {required this.dayOfWeek,
      required this.startTime,
      required this.endTime});

  factory CourseTimeModel.fromJson(Map<String, dynamic> json) =>
      _$CourseTimeModelFromJson(json);
}


// "dayOfWeek": "MONDAY",
//           "startTime": "HH:mm:SS",
//           "endTime": "HH:mm:SS"