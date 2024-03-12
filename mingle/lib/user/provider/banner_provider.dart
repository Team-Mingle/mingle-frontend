import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/user/model/banner_model.dart';
import 'package:mingle/user/repository/banner_repository.dart';

final bannerProvider = FutureProvider<List<BannerModel>>((ref) async {
  final repository = ref.read(bannerRepositoryProvider);
  try {
    final banners = await repository.getBanners();
    debugPrint("Banners fetched from API: $banners");
    return banners;
  } catch (e) {
    throw Exception("Failed to fetch banners: $e");
  }
});
