import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/dio/dio.dart';
import 'package:mingle/module/model/course_evaluation_model.dart';
import 'package:mingle/point_shop/model/coupon_model.dart';
import 'package:mingle/point_shop/model/point_model.dart';
import 'package:mingle/point_shop/model/shop_coupon_list_model.dart';
import 'package:retrofit/retrofit.dart';

part 'point_repository.g.dart';

final pointRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  final pointRepository =
      PointRepository(dio, baseUrl: "https://$baseUrl/point");
  return pointRepository;
});

@RestApi()
abstract class PointRepository {
  factory PointRepository(Dio dio, {String baseUrl}) = _PointRepository;

  @GET('')
  @Headers({'accessToken': 'true'})
  Future<PointModel> getRemainingPoints();
}
