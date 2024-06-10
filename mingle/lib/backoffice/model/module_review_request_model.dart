import 'package:json_annotation/json_annotation.dart';

part 'module_review_request_model.g.dart';

@JsonSerializable()
class ModuleReviewRequestModel {
  final int memberId;
  final String photoUrl;

  ModuleReviewRequestModel({
    required this.memberId,
    required this.photoUrl,
  });

  factory ModuleReviewRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ModuleReviewRequestModelFromJson(json);
}
