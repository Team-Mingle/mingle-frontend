import 'package:json_annotation/json_annotation.dart';
import 'package:mingle/module/model/course_model.dart';

part 'timetable_model.g.dart';

@JsonSerializable()
class TimetableModel {
  final String name;
  final String semester;
  final List<CourseModel> coursePreviewDtoList;

  TimetableModel(
      {required this.name,
      required this.semester,
      required this.coursePreviewDtoList});

  factory TimetableModel.fromJson(Map<String, dynamic> json) =>
      _$TimetableModelFromJson(json);
}

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