import 'package:json_annotation/json_annotation.dart';

part 'shop_coupon_model.g.dart';

@JsonSerializable()
class ShopCouponModel {
  final int id;
  final String name;
  final String description;
  final int cost;

  ShopCouponModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.cost});

  factory ShopCouponModel.fromJson(Map<String, dynamic> json) =>
      _$ShopCouponModelFromJson(json);

  String getDuration() {
    return name.split(" ")[2];
  }
}

// "id": 0,
//       "name": "string",
//       "description": "string",
//       "cost": 0