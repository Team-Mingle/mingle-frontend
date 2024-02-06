import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/dio/dio.dart';
import 'package:mingle/user/model/banner_model.dart';

import 'package:retrofit/retrofit.dart';

part 'banner_repository.g.dart';

final bannerRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  final bannerRepository =
      BannerRepository(dio, baseUrl: "https://$baseUrl/banner");
  return bannerRepository;
});

@RestApi()
abstract class BannerRepository {
  factory BannerRepository(Dio dio, {String baseUrl}) = _BannerRepository;

  @GET('')
  @Headers({'accessToken': 'true'})
  Future<List<BannerModel>> getBanners();
}
