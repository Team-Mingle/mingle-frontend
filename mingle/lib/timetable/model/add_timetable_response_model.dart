import 'package:json_annotation/json_annotation.dart';

part 'add_timetable_response_model.g.dart';

@JsonSerializable()
class AddTimetableResponseModel {
  final int id;
  final String name;
  final String semester;

  AddTimetableResponseModel({
    required this.id,
    required this.name,
    required this.semester,
  });

  factory AddTimetableResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AddTimetableResponseModelFromJson(json);
}
