// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_review_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModuleReviewRequestModel _$ModuleReviewRequestModelFromJson(
        Map<String, dynamic> json) =>
    ModuleReviewRequestModel(
      memberId: (json['memberId'] as num).toInt(),
      photoUrl: json['photoUrl'] as String,
    );

Map<String, dynamic> _$ModuleReviewRequestModelToJson(
        ModuleReviewRequestModel instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'photoUrl': instance.photoUrl,
    };
