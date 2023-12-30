import 'package:json_annotation/json_annotation.dart';
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
}
