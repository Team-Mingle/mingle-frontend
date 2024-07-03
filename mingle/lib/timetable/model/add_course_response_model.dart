import 'package:json_annotation/json_annotation.dart';

part 'add_course_response_model.g.dart';

@JsonSerializable()
class AddCourseResponseModel {
  final bool updated;
  final String rgb;

  AddCourseResponseModel({required this.updated, required this.rgb});

  factory AddCourseResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AddCourseResponseModelFromJson(json);
}
