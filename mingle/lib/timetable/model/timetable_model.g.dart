// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimetableModel _$TimetableModelFromJson(Map<String, dynamic> json) =>
    TimetableModel(
      name: json['name'] as String,
      semester: json['semester'] as String,
      coursePreviewDtoList: (json['coursePreviewDtoList'] as List<dynamic>)
          .map((e) => TimetableCourseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isFull: json['isFull'] as bool? ?? false,
    );

Map<String, dynamic> _$TimetableModelToJson(TimetableModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'semester': instance.semester,
      'coursePreviewDtoList': instance.coursePreviewDtoList,
      'isFull': instance.isFull,
    };
