import 'package:json_annotation/json_annotation.dart';

part 'coupon_model.g.dart';

@JsonSerializable()
class CouponModel {
  final String name;
  final String startDate;
  final String endDate;

  CouponModel(
      {required this.name, required this.startDate, required this.endDate});

  factory CouponModel.fromJson(Map<String, dynamic> json) =>
      _$CouponModelFromJson(json);
}




// {
//   "name": "string",
//   "startDate": "2024-04-27",
//   "endDate": "2024-04-27"
// }