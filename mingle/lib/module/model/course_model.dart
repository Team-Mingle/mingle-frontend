import 'package:json_annotation/json_annotation.dart';
import 'package:mingle/common/model/course_time_model.dart';

part 'course_model.g.dart';

@JsonSerializable()
class CourseModel {
  final int id;
  final String name;
  final String courseCode;
  final String semester;
  final List<CourseTimeModel> courseTimeDtoList;
  final String venue;
  final String professor;
  final String subclass;
  final String memo;
  final String prerequisite;

  CourseModel(
      {required this.id,
      required this.name,
      required this.courseCode,
      required this.semester,
      required this.courseTimeDtoList,
      required this.venue,
      required this.professor,
      required this.subclass,
      required this.memo,
      required this.prerequisite});

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);
}
// "id": 0,
//   "name": "string",
//   "courseCode": "string",
//   "semester": "string",
//   "courseTimeDtoList": [
//     {
//       "dayOfWeek": "MONDAY",
//       "startTime": "HH:mm:SS",
//       "endTime": "HH:mm:SS"
//     }
//   ],
//   "venue": "string",
//   "professor": "string",
//   "subclass": "string",
//   "memo": "string",
//   "prerequisite": "string"