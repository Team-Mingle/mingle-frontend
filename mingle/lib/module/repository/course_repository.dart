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

part 'course_repository.g.dart';

final courseRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  final courseRepository =
      CourseRepository(dio, baseUrl: "https://$baseUrl/course");
  return courseRepository;
});

@RestApi()
abstract class CourseRepository {
  factory CourseRepository(Dio dio, {String baseUrl}) = _CourseRepository;

  @GET('/search')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<CourseDetailModel>> search(
      {@Query("keyword") required String keyword});

  @GET('/{courseId}')
  @Headers({'accessToken': 'true'})
  Future<CourseDetailModel> getCourseDetails({@Path() required int courseId});

  @PATCH('/{courseId}')
  @Headers({'accessToken': 'true'})
  Future<CourseDetailModel> editCourse(
      {@Path() required int courseId,
      @Body() required AddPersonalCourseDto addPersonalCourseDto});
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
