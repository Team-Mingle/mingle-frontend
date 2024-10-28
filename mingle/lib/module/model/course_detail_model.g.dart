// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseDetailModel _$CourseDetailModelFromJson(Map<String, dynamic> json) =>
    CourseDetailModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      courseCode: json['courseCode'] as String,
      semester: json['semester'] as String?,
      courseTimeDtoList: (json['courseTimeDtoList'] as List<dynamic>)
          .map((e) => CourseTimeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      venue: json['venue'] as String?,
      professor: json['professor'] as String,
      subclass: json['subclass'] as String?,
      memo: json['memo'] as String?,
      prerequisite: json['prerequisite'] as String?,
      rgb: json['rgb'] as String?,
      courseType: json['courseType'] as String?,
    );

Map<String, dynamic> _$CourseDetailModelToJson(CourseDetailModel instance) =>
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
    };
