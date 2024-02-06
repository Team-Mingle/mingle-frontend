import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/post/models/banner_model.dart';
import 'package:mingle/post/repository/banner_repository.dart';

final bannerProvider = FutureProvider<List<BannerModel>>((ref) async {
  final repository = ref.read(bannerRepositoryProvider);
  try {
    final banners = await repository.getBanners();
    return banners;
  } catch (e) {
    throw Exception("Failed to fetch banner: $e");
  }
});