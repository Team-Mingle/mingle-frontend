// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseModel _$CourseModelFromJson(Map<String, dynamic> json) => CourseModel(
      id: json['id'] as int,
      name: json['name'] as String,
      courseCode: json['courseCode'] as String,
      semester: json['semester'] as String?,
      courseTimeDtoList: (json['courseTimeDtoList'] as List<dynamic>)
          .map((e) => CourseTimeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      professor: json['professor'] as String,
      subclass: json['subclass'] as String,
    );

Map<String, dynamic> _$CourseModelToJson(CourseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'courseCode': instance.courseCode,
      'semester': instance.semester,
      'courseTimeDtoList': instance.courseTimeDtoList,
      'professor': instance.professor,
      'subclass': instance.subclass,
    };