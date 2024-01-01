import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/dio/dio.dart';
import 'package:mingle/post/repository/post_repository.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'timetable_repository.g.dart';

// final timetableRepositoryProvider = Provider((ref) {
//   final dio = ref.watch(dioProvider);
//   final timetableRepository = timetableRepository(dio, baseUrl: "https://$baseUrl");
//   return timetableRepository;
// });

@RestApi()
abstract class TimetablePreviewRepository {
  factory TimetablePreviewRepository(Dio dio, {String baseUrl}) = _TimetablePreviewRepository;

  // 'https://baseUrl/timetable/'
  @GET('/')
  Future<TimetableListPreviewModel> getTimetablePreview();
}
