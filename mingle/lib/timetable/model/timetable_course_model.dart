import 'package:json_annotation/json_annotation.dart';
import 'package:mingle/common/component/showup_animation.dart';
import 'package:mingle/module/model/course_detail_model.dart';
import 'package:mingle/common/model/course_time_model.dart';

part 'timetable_course_model.g.dart';

@JsonSerializable()
class TimetableCourseModel extends CourseDetailModel {
  final int courseTimetableId;

  TimetableCourseModel(
      {required this.courseTimetableId,
      required super.id,
      required super.name,
      required super.courseCode,
      required super.semester,
      required super.professor,
      required super.subclass,
      required super.courseTimeDtoList,
      required super.rgb,
      required super.courseType,
      required super.prerequisite,
      required super.memo,
      required super.venue});

  factory TimetableCourseModel.fromCourseDeatilModel(
      CourseDetailModel courseDetailModel) {
    return TimetableCourseModel(
        courseCode: courseDetailModel.courseCode,
        courseTimeDtoList: courseDetailModel.courseTimeDtoList,
        courseType: courseDetailModel.courseType,
        id: courseDetailModel.id,
        memo: courseDetailModel.memo,
        name: courseDetailModel.name,
        prerequisite: courseDetailModel.prerequisite,
        professor: courseDetailModel.professor,
        rgb: courseDetailModel.rgb,
        semester: courseDetailModel.semester,
        subclass: courseDetailModel.subclass,
        venue: courseDetailModel.venue,
        courseTimetableId: 0);
  }

  factory TimetableCourseModel.fromJson(Map<String, dynamic> json) =>
      _$TimetableCourseModelFromJson(json);
}
