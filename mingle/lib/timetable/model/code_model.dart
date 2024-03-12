import 'package:json_annotation/json_annotation.dart';

part 'code_model.g.dart';

@JsonSerializable()
class CodeModel {
  final String code;

  CodeModel({required this.code});

  factory CodeModel.fromJson(Map<String, dynamic> json) =>
      _$CodeModelFromJson(json);
}
