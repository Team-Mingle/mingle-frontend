import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/dio/dio.dart';
import 'package:mingle/module/model/course_evaluation_model.dart';
import 'package:mingle/point_shop/model/coupon_model.dart';
import 'package:mingle/point_shop/model/shop_coupon_list_model.dart';
import 'package:retrofit/retrofit.dart';

part 'point_shop_repository.g.dart';

final courseEvalutationRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  final courseEvaluationRepository =
      PointShopRepository(dio, baseUrl: "https://$baseUrl/coupon");
  return courseEvaluationRepository;
});

@RestApi()
abstract class PointShopRepository {
  factory PointShopRepository(Dio dio, {String baseUrl}) = _PointShopRepository;

  @POST('/create')
  @Headers({'accessToken': 'true'})
  Future<void> createCoupon({@Body() required CreateCouponDto createCouponDto});

  @GET('')
  @Headers({'accessToken': 'true'})
  Future<CouponModel?> getCoupon();

  @GET('/shop')
  @Headers({'accessToken': 'true'})
  Future<ShopCouponListModel> getShopCouponList();
}

@JsonSerializable()
class CreateCouponDto {
  final int couponProductId;
  CreateCouponDto({required this.couponProductId});

  Map<String, dynamic> toJson() => _$CreateCouponDtoToJson(this);
}
