import 'package:json_annotation/json_annotation.dart';

part 'timetable_preview_model.g.dart';

@JsonSerializable()
class TimetablePreviewModel {
  final int timetableId;
  final String semester;
  final String name;
  final int orderNumber;
  final bool isPinned;

  TimetablePreviewModel({
    required this.timetableId,
    required this.semester,
    required this.name,
    required this.orderNumber,
    required this.isPinned,
  });

  factory TimetablePreviewModel.fromJson(Map<String, dynamic> json) =>
      _$TimetablePreviewModelFromJson(json);
}


// "timetableId": 1,
//         "semester": "SECOND_SEMESTER_2023",
//         "name": "시간표 1",
//         "orderNumber": 1,
//         "isPinned": true