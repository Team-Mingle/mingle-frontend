// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_timetable_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddTimetableResponseModel _$AddTimetableResponseModelFromJson(
        Map<String, dynamic> json) =>
    AddTimetableResponseModel(
      id: json['id'] as int,
      name: json['name'] as String,
      semester: json['semester'] as String,
    );

Map<String, dynamic> _$AddTimetableResponseModelToJson(
        AddTimetableResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'semester': instance.semester,
    };
