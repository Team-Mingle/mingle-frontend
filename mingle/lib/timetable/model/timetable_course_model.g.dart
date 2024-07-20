// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable_course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimetableCourseModel _$TimetableCourseModelFromJson(
        Map<String, dynamic> json) =>
    TimetableCourseModel(
      courseTimetableId: (json['courseTimetableId'] as num).toInt(),
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      courseCode: json['courseCode'] as String,
      semester: json['semester'] as String?,
      professor: json['professor'] as String? ?? "-",
      subclass: json['subclass'] as String?,
      courseTimeDtoList: (json['courseTimeDtoList'] as List<dynamic>)
          .map((e) => CourseTimeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      rgb: json['rgb'] as String?,
      courseType: json['courseType'] as String?,
      prerequisite: json['prerequisite'] as String?,
      memo: json['memo'] as String?,
      venue: json['venue'] as String?,
    );

Map<String, dynamic> _$TimetableCourseModelToJson(
        TimetableCourseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'courseCode': instance.courseCode,
      'semester': instance.semester,
      'professor': instance.professor,
      'subclass': instance.subclass,
      'courseTimeDtoList': instance.courseTimeDtoList,
      'rgb': instance.rgb,
      'courseType': instance.courseType,
      'venue': instance.venue,
      'memo': instance.memo,
      'prerequisite': instance.prerequisite,
      'courseTimetableId': instance.courseTimetableId,
    };
