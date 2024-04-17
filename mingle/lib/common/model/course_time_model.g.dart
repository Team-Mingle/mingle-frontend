// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_time_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseTimeModel _$CourseTimeModelFromJson(Map<String, dynamic> json) =>
    CourseTimeModel(
      dayOfWeek: json['dayOfWeek'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
    );

Map<String, dynamic> _$CourseTimeModelToJson(CourseTimeModel instance) =>
    <String, dynamic>{
      'dayOfWeek': instance.dayOfWeek,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };
