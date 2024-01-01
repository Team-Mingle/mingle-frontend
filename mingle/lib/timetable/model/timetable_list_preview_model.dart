import 'package:json_annotation/json_annotation.dart';

part 'timetable_list_preview_model.g.dart';

@JsonSerializable()
class TimetableListPreviewModel {
  final int timetableId;
  final String semester;
  final String name;
  final int orderNumber;
  final bool isPinned;

  TimetableListPreviewModel({
    required this.timetableId,
    required this.semester,
    required this.name,
    required this.orderNumber,
    required this.isPinned,
  });

  factory TimetableListPreviewModel.fromJson(Map<String, dynamic> json) =>
      _$TimetableListPreviewModelFromJson(json);
}
