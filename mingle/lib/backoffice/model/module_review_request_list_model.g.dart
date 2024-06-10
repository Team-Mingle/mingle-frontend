// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_review_request_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModuleReviewRequestListModel _$ModuleReviewRequestListModelFromJson(
        Map<String, dynamic> json) =>
    ModuleReviewRequestListModel(
      freshmanCouponApplyList:
          (json['freshmanCouponApplyList'] as List<dynamic>)
              .map((e) =>
                  ModuleReviewRequestModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$ModuleReviewRequestListModelToJson(
        ModuleReviewRequestListModel instance) =>
    <String, dynamic>{
      'freshmanCouponApplyList': instance.freshmanCouponApplyList,
    };
