import 'package:json_annotation/json_annotation.dart';
import 'package:mingle/point_shop/model/shop_coupon_model.dart';

part 'shop_coupon_list_model.g.dart';

@JsonSerializable()
class ShopCouponListModel {
  final List<ShopCouponModel> couponProductResponse;

  ShopCouponListModel({required this.couponProductResponse});

  factory ShopCouponListModel.fromJson(Map<String, dynamic> json) =>
      _$ShopCouponListModelFromJson(json);
}
