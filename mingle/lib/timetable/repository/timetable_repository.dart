import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/common/model/course_time_model.dart';
import 'package:mingle/dio/dio.dart';
import 'package:mingle/module/model/course_detail_model.dart';
import 'package:mingle/module/model/course_model.dart';
import 'package:mingle/timetable/model/add_course_response_model.dart';
import 'package:mingle/timetable/model/add_timetable_response_model.dart';
import 'package:mingle/timetable/model/default_timetable_id_model.dart';
import 'package:mingle/timetable/model/friend_timetable_list_model.dart';
import 'package:mingle/timetable/model/timetable_list_model.dart';
import 'package:mingle/timetable/model/timetable_model.dart';
import 'package:mingle/timetable/model/timetable_preview_model.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'timetable_repository.g.dart';

final timetableRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  final timetableRepository =
      TimetableRepository(dio, baseUrl: "https://$baseUrl/timetable");
  return timetableRepository;
});

@RestApi()
abstract class TimetableRepository {
  factory TimetableRepository(Dio dio, {String baseUrl}) = _TimetableRepository;

  @GET("")
  @Headers({'accessToken': 'true'})
  Future<TimetableListModel> getTimetables();

  @POST("")
  @Headers({'accessToken': 'true'})
  Future<AddTimetableResponseModel> addTimetable(
      {@Body() required AddTimetableDto addTimetableDto});

  @POST('/{timetableId}/course')
  @Headers({'accessToken': 'true'})
  Future<AddCourseResponseModel> addCourse(
      {@Path() required int timetableId,
      @Body() required AddClassDto addClassDto});

  @POST('/{timetableId}/course/personal')
  @Headers({'accessToken': 'true'})
  Future<CourseDetailModel> addPersonalCourse(
      {@Path() required int timetableId,
      @Body() required AddPersonalCourseDto addPersonalCourseDto});

  @PATCH('/{timetableId}/pin')
  @Headers({'accessToken': 'true'})
  Future<void> pinTimetable({
    @Path() required int timetableId,
  });

  @PATCH('/{timetableId}/name')
  @Headers({'accessToken': 'true'})
  Future<void> changeTimetableName(
      {@Path() required int timetableId,
      @Body() required ChangeTimetableNameDto changeTimetableNameDto});

  @PATCH('/{timetableCourseId}')
  @Headers({'accessToken': 'true'})
  Future<void> editTimetableCourse(
      {@Path() required int timetableCourseId,
      @Body() required EditTimetableCourseDto editTimetableCourseDto});

  @GET('/{timetableId}')
  @Headers({'accessToken': 'true'})
  Future<TimetableModel> getTimetable({
    @Path() required int timetableId,
  });

  @GET('/friend/{friendId}')
  @Headers({'accessToken': 'true'})
  Future<FriendTimetableListModel> getFriendTimetables({
    @Path() required int friendId,
  });

  @DELETE('/{timetableId}/course/{courseId}')
  @Headers({'accessToken': 'true'})
  Future<void> deleteCourse(
      {@Path() required int timetableId, @Path() required int courseId});

  @GET('/default')
  @Headers({'accessToken': 'true'})
  Future<DefaultTimetableIdModel> getDefaultTimetableId();

  @DELETE('/{timetableId}')
  @Headers({'accessToken': 'true'})
  Future<void> deleteTimetable({@Path() required int timetableId});
}

@JsonSerializable()
class AddClassDto {
  final int courseId;
  final bool overrideValidation;

  AddClassDto({required this.courseId, this.overrideValidation = false});

  Map<String, dynamic> toJson() => _$AddClassDtoToJson(this);
}

@JsonSerializable()
class ChangeTimetableNameDto {
  final String name;

  ChangeTimetableNameDto({required this.name});

  Map<String, dynamic> toJson() => _$ChangeTimetableNameDtoToJson(this);
}

@JsonSerializable()
class AddTimetableDto {
  final int year;
  final int semester;

  AddTimetableDto({required this.year, required this.semester});

  Map<String, dynamic> toJson() => _$AddTimetableDtoToJson(this);
}

@JsonSerializable()
class AddPersonalCourseDto {
  final String name;
  final List<CourseTimeModel> courseTimeDtoList;
  final String courseCode;
  final String venue;
  final String professor;
  final String memo;
  final String subclass;
  final bool overrideValidation;

  AddPersonalCourseDto(
      {required this.name,
      required this.courseTimeDtoList,
      required this.courseCode,
      required this.venue,
      required this.professor,
      required this.subclass,
      required this.memo,
      this.overrideValidation = false});

  Map<String, dynamic> toJson() => _$AddPersonalCourseDtoToJson(this);
}

@JsonSerializable()
class EditTimetableCourseDto {
  final String venue;
  final String professor;
  final String subclass;

  EditTimetableCourseDto(
      {required this.venue, required this.professor, required this.subclass});

  Map<String, dynamic> toJson() => _$EditTimetableCourseDtoToJson(this);
}


// {
//   "name": "string",
//   "courseTimeDtoList": [
//     {
//       "dayOfWeek": "MONDAY",
//       "startTime": "HH:mm:SS",
//       "endTime": "HH:mm:SS"
//     }
//   ],
//   "courseCode": "string",
//   "venue": "string",
//   "professor": "string",
//   "memo": "string",
//   "overrideValidation": true
// }