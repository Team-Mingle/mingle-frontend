import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/material.dart';
import 'package:mingle/common/model/cursor_pagination_model.dart';
import 'package:mingle/post/models/add_post_model.dart';
import 'package:mingle/post/models/post_model.dart';
import 'package:retrofit/retrofit.dart';

part 'post_repository.g.dart';

@RestApi()
abstract class PostRepository {
  factory PostRepository(Dio dio, {String baseUrl}) = _PostRepository;

  @GET('/{boardType}/{categoryType}')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<PostModel>> paginate(
      {@Path() required String boardType,
      @Path() required String categoryType});

  @POST('/{boardType}')
  @Headers({'accessToken': 'true'})
  @MultiPart()
  Future<dynamic> addPost({
    @Path() required String boardType,
    // @Body() required FormData addPostModel,
    @Part(name: "title") required String title,
    @Part(name: "content") required String content,
    @Part(name: "categoryType") required String categoryType,
    @Part(name: "isAnonymous") required bool isAnonymous,
    // @Part(name: "multipartFile") List<MultipartFile>? multipartFile,
  });

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
