import 'package:json_annotation/json_annotation.dart';
import 'package:mingle/common/model/course_time_model.dart';
import 'package:mingle/module/model/course_model.dart';

part 'course_detail_model.g.dart';

@JsonSerializable()
class CourseDetailModel extends CourseModel {
  final String? venue;
  final String? memo;
  final String? prerequisite;

  CourseDetailModel(
      {required super.id,
      required super.name,
      required super.courseCode,
      required super.semester,
      required super.courseTimeDtoList,
      required this.venue,
      required super.professor,
      required super.subclass,
      required this.memo,
      required this.prerequisite,
      required super.rgb});

  factory CourseDetailModel.fromJson(Map<String, dynamic> json) =>
      _$CourseDetailModelFromJson(json);
}

// "id": 1167,
//   "name": "QUANTITATIVE SKILLS FOR CHEMICAL AND LIFE SCIENCES",
//   "courseCode": "ABCT1001 - LEC001",
//   "semester": null,
//   "courseTimeDtoList": [
//     {
//       "dayOfWeek": "TUESDAY",
//       "startTime": "14:30:00",
//       "endTime": "16:20:00"
//     }
//   ],
//   "venue": "N003",
//   "professor": "DONG, Nai ping, daniel mok",
//   "subclass": "2002",
//   "memo": null,
//   "prerequisite": null

// "id": 1167,
//       "name": "QUANTITATIVE SKILLS FOR CHEMICAL AND LIFE SCIENCES",
//       "courseCode": "ABCT1001 - LEC001",
//       "semester": null,
//       "professor": "DONG, Nai ping, daniel mok",
//       "subclass": "2002",
//       "courseTimeDtoList": [
//         {
//           "dayOfWeek": "TUESDAY",
//           "startTime": "14:30:00",
//           "endTime": "16:20:00"
//         }
//       ],
//       "rgb": "251, 233, 239"