import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/dio/dio.dart';
import 'package:mingle/post/models/add_comment_model.dart';
import 'package:retrofit/retrofit.dart';

part 'comment_repository.g.dart';

final commentRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  final commentRepository =
      CommentRepository(dio, baseUrl: "https://$baseUrl/comment");
  return commentRepository;
});

@RestApi()
abstract class CommentRepository {
  factory CommentRepository(Dio dio, {String baseUrl}) = _CommentRepository;

  @POST('')
  @Headers({'accessToken': 'true'})
  Future<dynamic> postComment(@Body() AddCommentModel addCommentModel);

  @PATCH('/like/{commentId}')
  @Headers({'accessToken': 'true'})
  Future<dynamic> likeComment({@Path() required int commentId});

  @DELETE('/like/delete/{commentId}')
  @Headers({'accessToken': 'true'})
  Future<dynamic> unlikeComment({@Path() required int commentId});

  @DELETE('/delete/{commentId}')
  @Headers({'accessToken': 'true'})
  Future<dynamic> deleteComment({@Path() required int commentId});

  // @GET('/{boardType}/{categoryType}')
  // @Headers({'accessToken': 'true'})
  // Future<CursorPagination<PostModel>> paginate(
  //     {@Path() required String boardType,
  //     @Path() required String categoryType});

  // @POST('/{boardType}')
  // @Headers({'accessToken': 'true'})
  // @MultiPart()
  // Future<dynamic> addPost({
  //   @Path() required String boardType,
  //   // @Body() required FormData addPostModel,
  //   @Part(name: "title") required String title,
  //   @Part(name: "content") required String content,
  //   @Part(name: "categoryType") required String categoryType,
  //   @Part(name: "isAnonymous") required bool isAnonymous,
  //   @Part(name: "multipartFile") List<MultipartFile>? multipartFile,
  // });

  // @GET('/{postId}')
  // @Headers({'accessToken': 'true'})
  // Future<PostDetailModel> getPostDetails({@Path() required int postId});

  // @GET('/{postId}/comment')
  // @Headers({'accessToken': 'true'})
  // Future<List<CommentModel>> getPostcomments({@Path() required int postId});
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
