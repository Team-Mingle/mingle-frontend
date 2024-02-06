import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/user/model/banner_model.dart';
import 'package:mingle/user/repository/banner_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final bannerProvider = FutureProvider<List<BannerModel>>((ref) async {
  final repository = ref.read(bannerRepositoryProvider);
  try {
    final cachedBanners = await getCachedBanners();
    if (cachedBanners != null) {
      debugPrint("Banners loaded from cache: $cachedBanners");
      return cachedBanners;
    }
    final banners = await repository.getBanners();

    await cacheBanners(banners);

    debugPrint("Banners fetched from API and cached: $banners");
    return banners;
  } catch (e) {
    throw Exception("Failed to fetch banner: $e");
  }
});

Future<List<BannerModel>?> getCachedBanners() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final cachedJson = prefs.getString('bannersCache');
    if (cachedJson != null) {
      final parsedBanners = (jsonDecode(cachedJson) as List)
          .map((json) => BannerModel.fromJson(json))
          .toList();
      return parsedBanners;
    }
    return null;
  } catch (e) {
    debugPrint("Error getting cached banners: $e");
    return null;
  }
}

Future<void> cacheBanners(List<BannerModel> banners) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = jsonEncode(banners);
    await prefs.setString('bannersCache', jsonData);
  } catch (e) {
    debugPrint("Error caching banners: $e");
  }
}
