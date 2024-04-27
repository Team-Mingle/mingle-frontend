// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_coupon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopCouponModel _$ShopCouponModelFromJson(Map<String, dynamic> json) =>
    ShopCouponModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      cost: json['cost'] as int,
    );

Map<String, dynamic> _$ShopCouponModelToJson(ShopCouponModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'cost': instance.cost,
    };
