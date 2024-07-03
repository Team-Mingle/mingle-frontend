// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimetableListModel _$TimetableListModelFromJson(Map<String, dynamic> json) =>
    TimetableListModel(
      timetablePreviewResponseMap:
          (json['timetablePreviewResponseMap'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((e) =>
                    TimetablePreviewModel.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
    );

Map<String, dynamic> _$TimetableListModelToJson(TimetableListModel instance) =>
    <String, dynamic>{
      'timetablePreviewResponseMap': instance.timetablePreviewResponseMap,
    };
