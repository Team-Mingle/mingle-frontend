import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/dio/dio.dart';
import 'package:mingle/timetable/model/timetable_model.dart';
import 'package:retrofit/retrofit.dart';

part 'timetable_repository.g.dart';

final postRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  final timetableRepository =
      TimetableRepository(dio, baseUrl: "https://$baseUrl/timetable");
  return timetableRepository;
});

@RestApi()
abstract class TimetableRepository {
  factory TimetableRepository(Dio dio, {String baseUrl}) = _TimetableRepository;

  @POST('/{timetableId}/course')
  @Headers({'accessToken': 'true'})
  Future<dynamic> addCourse(
      {@Path() required int timetableId,
      @Body() required AddClassDto addClassDto});

  @PATCH('/{timetableId}/pin')
  @Headers({'accessToken': 'true'})
  Future<void> pinTimetable({
    @Path() required int timetableId,
  });

  @GET('/{timetableId}')
  @Headers({'accessToken': 'true'})
  Future<TimetableModel> getTimeTable({
    @Path() required int timetableId,
  });

  @DELETE('{timetableId}/course/{courseId}')
  @Headers({'accessToken': 'true'})
  Future<TimetableModel> deleteCourse(
      {@Path() required int timetableId, @Path() required int courseId});
}

class AddClassDto {
  final int courseId;
  final bool overrideValidation;

  AddClassDto({required this.courseId, required this.overrideValidation});
}
