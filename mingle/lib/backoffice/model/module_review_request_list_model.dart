import 'package:json_annotation/json_annotation.dart';
import 'package:mingle/backoffice/model/module_review_request_model.dart';

part 'module_review_request_list_model.g.dart';

@JsonSerializable()
class ModuleReviewRequestListModel {
  final List<ModuleReviewRequestModel> freshmanCouponApplyList;

  ModuleReviewRequestListModel({required this.freshmanCouponApplyList});

  factory ModuleReviewRequestListModel.fromJson(Map<String, dynamic> json) =>
      _$ModuleReviewRequestListModelFromJson(json);
}
