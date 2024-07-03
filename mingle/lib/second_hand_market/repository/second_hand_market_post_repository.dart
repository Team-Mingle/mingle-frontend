import 'dart:io';

import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/common/model/cursor_pagination_model.dart';
import 'package:mingle/common/model/pagination_params.dart';
import 'package:mingle/dio/dio.dart';
import 'package:mingle/post/models/category_model.dart';
import 'package:mingle/post/models/comment_model.dart';
import 'package:mingle/post/models/post_detail_model.dart';
import 'package:mingle/post/models/post_model.dart';
import 'package:mingle/second_hand_market/model/second_hand_market_post_comment_model.dart';
import 'package:mingle/second_hand_market/model/second_hand_market_post_detail_model.dart';
import 'package:mingle/second_hand_market/model/second_hand_market_post_model.dart';
import 'package:retrofit/retrofit.dart';

part 'second_hand_market_post_repository.g.dart';

final secondHandPostRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  final secondHandPostRepository =
      SecondHandPostRepository(dio, baseUrl: "https://$baseUrl/item");
  return secondHandPostRepository;
});

@RestApi()
abstract class SecondHandPostRepository {
  factory SecondHandPostRepository(Dio dio, {String baseUrl}) =
      _SecondHandPostRepository;

  @GET('')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<SecondHandMarketPostModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  @POST('')
  @Headers({'accessToken': 'true'})
  @MultiPart()
  Future<dynamic> addSecondHandMarketPost({
    @Part(name: "title") required String title,
    @Part(name: "price") required int price,
    @Part(name: "currencyType") required String currencyType,
    @Part(name: "content") required String content,
    @Part(name: "location") required String location,
    @Part(name: "chatUrl") required String chatUrl,
    @Part(name: "isAnonymous") required bool isAnonymous,
    @Part(name: "multipartFile") List<File>? multipartFile,
  });

  @GET('/{itemId}')
  @Headers({'accessToken': 'true'})
  Future<SecondHandMarketPostDetailModel> getSecondHandMarketPostDetail(
      {@Path() required int itemId});

  @DELETE('/{itemId}')
  @Headers({'accessToken': 'true'})
  Future<void> deleteSecondHandMarketPost({@Path() required int itemId});

  @PATCH('/{itemId}')
  @Headers({'accessToken': 'true'})
  @MultiPart()
  Future<SecondHandMarketPostDetailModel> editSecondHandMarketPost({
    @Path() required int itemId,
    // @Body() required FormData addPostModel,
    @Part(name: "title") required String title,
    @Part(name: "price") required String price,
    @Part(name: "currencyType") required String currencyType,
    @Part(name: "content") required String content,
    @Part(name: "location") required String location,
    @Part(name: "chatUrl") required String chatUrl,
    @Part(name: "isAnonymous") required String isAnonymous,
    @Part(name: "imageUrlsToDelete") List<MultipartFile>? imageUrlsToDelete,
    @Part(name: "imagesToAdd") List<MultipartFile>? imagesToAdd,
  });

  @GET('/{itemId}/comment')
  @Headers({'accessToken': 'true'})
  Future<List<CommentModel>> getSecondHandMarketPostComments(
      {@Path() required int itemId});

  @PATCH('/comment/like/{commentId}')
  @Headers({'accessToken': 'true'})
  Future<void> likeSecondHandMarketPostComment(
      {@Path() required int commentId});

  @POST('/{itemId}/comment')
  @Headers({'accessToken': 'true'})
  Future<dynamic> addSecondHandMarketPostComment(
      {@Path() required int itemId,
      @Body() required AddSecondHandMarketCommentModel commentModel});

  @DELETE('/comment/{commentId}')
  @Headers({'accessToken': 'true'})
  Future<void> deleteSecondHandMarketPostComment(
      {@Path() required int commentId});

  @PATCH('/{itemId}/status/{itemStatusType}')
  @Headers({'accessToken': 'true'})
  Future<void> editItemStatus(
      {@Path() required int itemId, @Path() required String itemStatusType});

  @PATCH('/{itemId}/blind')
  @Headers({'accessToken': 'true'})
  Future<void> blindOrUnblindSecondHandMarketPost(
      {@Path() required int itemId});

  @PATCH('/like/{itemId}')
  @Headers({'accessToken': 'true'})
  Future<void> likeSecondHandMarketPost({@Path() required int itemId});

  @GET('/search')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<SecondHandMarketPostModel>> search(
      {@Query("keyword") required String keyword});

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
class AddSecondHandMarketCommentModel {
  final int itemId;
  final int? parentCommentId;
  final int? mentionId;
  final String content;
  final bool isAnonymous;

  AddSecondHandMarketCommentModel(
      {required this.itemId,
      required this.parentCommentId,
      required this.mentionId,
      required this.content,
      required this.isAnonymous});

  Map<String, dynamic> toJson() =>
      _$AddSecondHandMarketCommentModelToJson(this);
}
