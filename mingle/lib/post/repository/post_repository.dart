import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/common/model/cursor_pagination_model.dart';
import 'package:mingle/common/model/pagination_params.dart';
import 'package:mingle/dio/dio.dart';
import 'package:mingle/post/models/category_model.dart';
import 'package:mingle/post/models/comment_model.dart';
import 'package:mingle/post/models/post_detail_model.dart';
import 'package:mingle/post/models/post_model.dart';
import 'package:retrofit/retrofit.dart';

part 'post_repository.g.dart';

final postRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  final postRepository = PostRepository(dio, baseUrl: "https://$baseUrl/post");
  return postRepository;
});

@RestApi()
abstract class PostRepository {
  factory PostRepository(Dio dio, {String baseUrl}) = _PostRepository;

  @GET('/{boardType}/{categoryType}')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<PostModel>> paginate({
    @Path() required String boardType,
    @Path() required String categoryType,
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

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
    @Part(name: "multipartFile") List<MultipartFile>? multipartFile,
  });

  @GET('/{postId}')
  @Headers({'accessToken': 'true'})
  Future<PostDetailModel> getPostDetails({@Path() required int postId});

  @GET('/{postId}/comment')
  @Headers({'accessToken': 'true'})
  Future<List<CommentModel>> getPostcomments({@Path() required int postId});

  @POST('/like/{postId}')
  @Headers({'accessToken': 'true'})
  Future<dynamic> likePost({@Path() required int postId});

  @DELETE('/like/delete/{postId}')
  @Headers({'accessToken': 'true'})
  Future<dynamic> unlikePost({@Path() required int postId});

  @GET('/category')
  @Headers({'accessToken': 'true'})
  Future<List<CategoryModel>> fetchCategories();

  @GET('/search')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<PostModel>> search(
      {@Query("keyword") required String keyword});

  @DELETE('/delete/{postId}')
  @Headers({'accessToken': 'true'})
  Future<dynamic> deletePost({@Path() required int postId});

  @PATCH('/{postId}')
  @Headers({'accessToken': 'true'})
  @MultiPart()
  Future<dynamic> editPost({
    @Path() required int postId,
    // @Body() required FormData addPostModel,
    @Part(name: "title") required String title,
    @Part(name: "content") required String content,
    @Part(name: "categoryType") required String categoryType,
    @Part(name: "anonymous") required bool isAnonymous,
    @Part(name: "multipartFile") List<MultipartFile>? multipartFile,
  });

  @GET('/{boardType}/recent')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<PostModel>> paginateRecent({
    @Path() required String boardType,
  });

  @GET('/best')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<PostModel>> paginateBest();

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
