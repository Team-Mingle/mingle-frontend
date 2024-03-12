import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/dio/dio.dart';
import 'package:mingle/module/model/course_evaluation_model.dart';
import 'package:retrofit/retrofit.dart';

part 'course_evaluation_repository.g.dart';

final courseEvalutationRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  final courseEvaluationRepository = CourseEvaluationRepository(dio,
      baseUrl: "https://$baseUrl/course-evaluation");
  return courseEvaluationRepository;
});

@RestApi()
abstract class CourseEvaluationRepository {
  factory CourseEvaluationRepository(Dio dio, {String baseUrl}) =
      _CourseEvaluationRepository;

  @GET('/{courseId}')
  @Headers({'accessToken': 'true'})
  Future<CourseEvaluationResponseDto> getCourseEvaluations(
      {@Path() required int courseId});

  @POST('/create')
  @Headers({'accessToken': 'true'})
  Future<void> addCourseEvaluation(
      {@Body() required AddCourseEvaluationDto addCourseEvaluationDto});

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
class CourseEvaluationResponseDto {
  final List<CourseEvaluationModel> courseEvaluationList;

  CourseEvaluationResponseDto({required this.courseEvaluationList});

  factory CourseEvaluationResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CourseEvaluationResponseDtoFromJson(json);
}

@JsonSerializable()
class AddCourseEvaluationDto {
  final int courseId;
  final int year;
  final int semester;
  final String comment;
  final String rating;

  AddCourseEvaluationDto({
    required this.courseId,
    required this.year,
    required this.semester,
    required this.comment,
    required this.rating,
  });

  Map<String, dynamic> toJson() => _$AddCourseEvaluationDtoToJson(this);
}
