import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/dio/dio.dart';
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
  Future<void> addTimetable({@Body() required AddTimetableDto addTimetableDto});

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

  @PATCH('/{timetableId}/name')
  @Headers({'accessToken': 'true'})
  Future<void> changeTimetableName(
      {@Path() required int timetableId,
      @Body() required ChangeTimetableNameDto changeTimetableNameDto});

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
