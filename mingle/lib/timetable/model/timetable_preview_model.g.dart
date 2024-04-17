// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable_preview_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimetablePreviewModel _$TimetablePreviewModelFromJson(
        Map<String, dynamic> json) =>
    TimetablePreviewModel(
      timetableId: json['timetableId'] as int,
      semester: json['semester'] as String,
      name: json['name'] as String,
      orderNumber: json['orderNumber'] as int,
      isPinned: json['isPinned'] as bool,
    );

Map<String, dynamic> _$TimetablePreviewModelToJson(
        TimetablePreviewModel instance) =>
    <String, dynamic>{
      'timetableId': instance.timetableId,
      'semester': instance.semester,
      'name': instance.name,
      'orderNumber': instance.orderNumber,
      'isPinned': instance.isPinned,
    };
