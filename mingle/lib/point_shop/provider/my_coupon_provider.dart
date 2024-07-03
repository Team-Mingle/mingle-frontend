import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/point_shop/model/coupon_model.dart';
import 'package:mingle/point_shop/model/point_model.dart';
import 'package:mingle/point_shop/repository/point_repository.dart';
import 'package:mingle/point_shop/repository/point_shop_repository.dart';

class MyCouponStateNotifier extends StateNotifier<CouponModel?> {
  final PointShopRepository pointShopRepository;
  MyCouponStateNotifier({required this.pointShopRepository}) : super(null) {
    getCoupon();
  }
  Future<void> getCoupon() async {
    try {
      CouponModel? coupon = await pointShopRepository.getCoupon();

      state = coupon;

      print(state);
    } on DioException catch (e) {
      state = null;
    }
  }
}

final myCouponProvider =
    StateNotifierProvider<MyCouponStateNotifier, CouponModel?>((ref) {
  final repository = ref.watch(pointShopRepositoryProvider);

  final notifier = MyCouponStateNotifier(pointShopRepository: repository);

  return notifier;
});
