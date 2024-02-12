// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../user/model/banner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerModel _$BannerModelFromJson(Map<String, dynamic> json) => BannerModel(
      id: json['id'] as int,
      imgUrl: json['imgUrl'] as String,
      linkUrl: json['linkUrl'] as String,
    );

Map<String, dynamic> _$BannerModelToJson(BannerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imgUrl': instance.imgUrl,
      'linkUrl': instance.linkUrl,
    };
