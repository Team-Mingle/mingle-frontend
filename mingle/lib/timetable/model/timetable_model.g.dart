// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimetableModel _$TimetableModelFromJson(Map<String, dynamic> json) =>
    TimetableModel(
      name: json['name'] as String,
      semester: json['semester'] as String,
      coursePreviewResponseList: (json['coursePreviewResponseList']
              as List<dynamic>)
          .map((e) => CoursePreviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TimetableModelToJson(TimetableModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'semester': instance.semester,
      'coursePreviewResponseList': instance.coursePreviewResponseList,
    };
