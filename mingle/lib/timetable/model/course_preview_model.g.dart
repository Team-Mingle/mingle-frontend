// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_preview_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoursePreviewModel _$CoursePreviewModelFromJson(Map<String, dynamic> json) =>
    CoursePreviewModel(
      id: json['id'] as int,
      courseCode: json['courseCode'] as String,
      semester: json['semester'] as String,
      professor: json['professor'] as String,
      subclass: json['subclass'] as String,
      courseTimeDtoList: (json['courseTimeDtoList'] as List<dynamic>)
          .map((e) => CourseTimeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CoursePreviewModelToJson(CoursePreviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'courseCode': instance.courseCode,
      'semester': instance.semester,
      'professor': instance.professor,
      'subclass': instance.subclass,
      'courseTimeDtoList': instance.courseTimeDtoList,
    };
