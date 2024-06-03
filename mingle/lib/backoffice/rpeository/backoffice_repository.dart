import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/common/model/cursor_pagination_model.dart';
import 'package:mingle/common/model/pagination_params.dart';
import 'package:mingle/dio/dio.dart';
import 'package:mingle/module/model/course_detail_model.dart';
import 'package:mingle/module/model/course_model.dart';
import 'package:mingle/post/models/category_model.dart';
import 'package:mingle/post/models/comment_model.dart';
import 'package:mingle/post/models/post_detail_model.dart';
import 'package:mingle/post/models/post_model.dart';
import 'package:mingle/timetable/repository/timetable_repository.dart';
import 'package:retrofit/retrofit.dart';

part 'backoffice_repository.g.dart';

final backofficeRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  final backofficeRepository =
      BackofficeRepository(dio, baseUrl: "https://$baseUrl/backoffice");
  return backofficeRepository;
});

@RestApi()
abstract class BackofficeRepository {
  factory BackofficeRepository(Dio dio, {String baseUrl}) =
      _BackofficeRepository;

  @POST('/reject-temp-sign-up')
  @Headers({'accessToken': 'true'})
  Future<void> rejectTempSignup({@Query("memberId") required String memberId});

  @POST('/authenticate-temp-sign-up')
  @Headers({'accessToken': 'true'})
  Future<void> authenticateTempSignup(
      {@Query("memberId") required String memberId});
}
