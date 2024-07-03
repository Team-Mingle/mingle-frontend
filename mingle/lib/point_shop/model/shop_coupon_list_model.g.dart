// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_coupon_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopCouponListModel _$ShopCouponListModelFromJson(Map<String, dynamic> json) =>
    ShopCouponListModel(
      couponProductResponse: (json['couponProductResponse'] as List<dynamic>)
          .map((e) => ShopCouponModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ShopCouponListModelToJson(
        ShopCouponListModel instance) =>
    <String, dynamic>{
      'couponProductResponse': instance.couponProductResponse,
    };
