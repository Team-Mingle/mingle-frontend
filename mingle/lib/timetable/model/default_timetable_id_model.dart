import 'package:json_annotation/json_annotation.dart';

part 'default_timetable_id_model.g.dart';

@JsonSerializable()
class DefaultTimetableIdModel {
  final int defaultTimetableId;
  DefaultTimetableIdModel({required this.defaultTimetableId});

  factory DefaultTimetableIdModel.fromJson(Map<String, dynamic> json) =>
      _$DefaultTimetableIdModelFromJson(json);
}
