import 'package:json_annotation/json_annotation.dart';

part 'point_model.g.dart';

@JsonSerializable()
class PointModel {
  final int remainPointAmount;

  PointModel({required this.remainPointAmount});

  factory PointModel.fromJson(Map<String, dynamic> json) =>
      _$PointModelFromJson(json);
}
