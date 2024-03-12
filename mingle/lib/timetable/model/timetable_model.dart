import 'package:json_annotation/json_annotation.dart';
import 'package:mingle/timetable/model/course_preview_model.dart';

part 'timetable_model.g.dart';

@JsonSerializable()
class TimetableModel {
  final String name;
  final String semester;
  final List<CoursePreviewModel> coursePreviewResponseList;

  TimetableModel(
      {required this.name,
      required this.semester,
      required this.coursePreviewResponseList});

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