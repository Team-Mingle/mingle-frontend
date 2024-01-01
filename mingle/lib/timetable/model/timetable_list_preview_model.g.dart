// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable_list_preview_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimetableListPreviewModel _$TimetableListPreviewModelFromJson(
        Map<String, dynamic> json) =>
    TimetableListPreviewModel(
      timetableId: json['timetableId'] as int,
      semester: json['semester'] as String,
      name: json['name'] as String,
      orderNumber: json['orderNumber'] as int,
      isPinned: json['isPinned'] as bool,
    );

Map<String, dynamic> _$TimetableListPreviewModelToJson(
        TimetableListPreviewModel instance) =>
    <String, dynamic>{
      'timetableId': instance.timetableId,
      'semester': instance.semester,
      'name': instance.name,
      'orderNumber': instance.orderNumber,
      'isPinned': instance.isPinned,
    };
