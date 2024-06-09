import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mingle/backoffice/model/temp_signup_request_list_model.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/common/model/cursor_pagination_model.dart';
import 'package:mingle/dio/dio.dart';
import 'package:mingle/post/models/post_model.dart';
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
  Future<void> rejectTempSignup(
      {@Query("memberId") required int memberId,
      @Body() required RejectReasonDto rejectReasonDto});

  @POST('/authenticate-temp-sign-up')
  @Headers({'accessToken': 'true'})
  Future<void> authenticateTempSignup(
      {@Query("memberId") required int memberId});

  @GET('/temp-sign-up-apply-list')
  @Headers({'accessToken': 'true'})
  Future<TempSignupRequestListModel> getTempSignupRequestList();

  @GET('/post/univ/{universityId}/all')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<PostModel>> getAllUnivPosts(
      {@Path() required int universityId});

  @GET('/post/total/{countryId}/all')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<PostModel>> getAllTotalPosts(
      {@Path() required String countryId});
}

@JsonSerializable()
class RejectReasonDto {
  final String rejectReason;

  RejectReasonDto({required this.rejectReason});

  Map<String, dynamic> toJson() => _$RejectReasonDtoToJson(this);
}
