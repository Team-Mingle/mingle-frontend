import 'dart:io';

import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/common/model/cursor_pagination_model.dart';
import 'package:mingle/common/model/pagination_params.dart';
import 'package:mingle/dio/dio.dart';
import 'package:mingle/post/models/category_model.dart';
import 'package:mingle/post/models/comment_model.dart';
import 'package:mingle/post/models/post_detail_model.dart';
import 'package:mingle/post/models/post_model.dart';
import 'package:mingle/second_hand_market/model/second_hand_market_post_model.dart';
import 'package:mingle/user/view/my_page_screen/change_nickname_screen.dart';
import 'package:retrofit/retrofit.dart';

part 'member_repository.g.dart';

final memberRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  final memberRepository =
      MemberRepository(dio, baseUrl: "https://$baseUrl/member");
  return memberRepository;
});

@RestApi()
abstract class MemberRepository {
  factory MemberRepository(Dio dio, {String baseUrl}) = _MemberRepository;

  @POST('/logout')
  @Headers({'accessToken': 'true'})
  Future<void> logout();

  @PATCH('/nickname')
  @Headers({'accessToken': 'true'})
  Future<void> changeNickname({@Body() required ChangeNicknameDto newNickname});

  @PATCH('/freshman-sign-up')
  @Headers({'accessToken': 'true'})
  Future<void> convertEmail({@Body() required ConvertEmailDto convertEmailDto});

  @GET('/{boardType}/scraps')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<PostModel>> getScrappedPosts({
    @Path() required String boardType,
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  @GET('/{boardType}/posts')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<PostModel>> getMyPosts({
    @Path() required String boardType,
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  @GET('/{boardType}/likes')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<PostModel>> getMyLikedPosts({
    @Path() required String boardType,
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  @GET('/{boardType}/comments')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<PostModel>> getMyCommentedPosts({
    @Path() required String boardType,
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  @GET('/item-likes/{itemStatus}')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<SecondHandMarketPostModel>>
      getMyLikedSecondHandPosts({
    @Path() required String itemStatus,
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  @GET('/items/{itemStatus}')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<SecondHandMarketPostModel>> getMySecondHandPosts({
    @Path() required String itemStatus,
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  @DELETE('/withdrawal')
  @Headers({'accessToken': 'true'})
  Future<void> withdraw({@Body() required WithdrawModel withdrawModel});

  // factory RestaurantRepository(Dio dio, {String baseUrl}) =
  //     _RestaurantRepository;

  // @GET('/')
  // @Headers({'accessToken': 'true'})
  // Future<CursorPagination<RestaurantModel>> paginate({
  //   @Queries() PaginationParams? paginationParams = const PaginationParams(),
  // });

  // @GET('/{id}')
  // @Headers({
  //   'accessToken': 'true',
  // })
  // Future<RestaurantDetailModel> getRestaurantDetail({
  //   @Path() required String id,
  // });
}

@JsonSerializable()
class WithdrawModel {
  final String email;
  final String pwd;

  WithdrawModel({required this.email, required this.pwd});

  factory WithdrawModel.fromJson(Map<String, dynamic> json) =>
      _$WithdrawModelFromJson(json);
}

@JsonSerializable()
class ChangeNicknameDto {
  final String newNickname;

  ChangeNicknameDto({required this.newNickname});

  Map<String, dynamic> toJson() => _$ChangeNicknameDtoToJson(this);
}

@JsonSerializable()
class ConvertEmailDto {
  final String email;

  ConvertEmailDto({required this.email});

  Map<String, dynamic> toJson() => _$ConvertEmailDtoToJson(this);
}
