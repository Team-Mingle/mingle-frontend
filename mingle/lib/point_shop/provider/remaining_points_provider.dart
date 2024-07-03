import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/point_shop/model/point_model.dart';
import 'package:mingle/point_shop/repository/point_repository.dart';

class RemainingPointsStateNotifier extends StateNotifier<int> {
  final PointRepository pointRepository;
  RemainingPointsStateNotifier({required this.pointRepository}) : super(0) {
    fetchRemainingPoints();
  }
  Future<void> fetchRemainingPoints() async {
    try {
      PointModel remainingPoints = await pointRepository.getRemainingPoints();

      state = remainingPoints.remainPointAmount;

      print(state);
    } on DioException catch (e) {
      state = 0;
    }
  }
}

final remainingPointsProvider =
    StateNotifierProvider<RemainingPointsStateNotifier, int>((ref) {
  final repository = ref.watch(pointRepositoryProvider);

  final notifier = RemainingPointsStateNotifier(pointRepository: repository);

  return notifier;
});
