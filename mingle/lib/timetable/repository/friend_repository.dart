import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/dio/dio.dart';
import 'package:mingle/timetable/model/code_model.dart';
import 'package:mingle/timetable/model/timetable_model.dart';
import 'package:retrofit/retrofit.dart';

part 'friend_repository.g.dart';

final friendRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  final friendRepository =
      FriendRepository(dio, baseUrl: "https://$baseUrl/friend");
  return friendRepository;
});

@RestApi()
abstract class FriendRepository {
  factory FriendRepository(Dio dio, {String baseUrl}) = _FriendRepository;

  @POST('/create')
  @Headers({'accessToken': 'true'})
  Future<dynamic> addFriend(@Body() AddFriendDto addFriendDto);

  @POST('/code')
  @Headers({'accessToken': 'true'})
  Future<CodeModel> generateCode(@Body() GenerateCodeDto generateCodeDto);

  @GET('/display-name')
  @Headers({'accessToken': 'true'})
  Future<String> getDefaultName();

  // @POST('/{timetableId}/course')
  // @Headers({'accessToken': 'true'})
  // Future<dynamic> addCourse(
  //     {@Path() required int timetableId,
  //     @Body() required AddClassDto addClassDto});

  // @PATCH('/{timetableId}/pin')
  // @Headers({'accessToken': 'true'})
  // Future<void> pinTimetable({
  //   @Path() required int timetableId,
  // });

  // @GET('/{timetableId}')
  // @Headers({'accessToken': 'true'})
  // Future<TimetableModel> getTimeTable({
  //   @Path() required int timetableId,
  // });

  // @DELETE('{timetableId}/course/{courseId}')
  // @Headers({'accessToken': 'true'})
  // Future<TimetableModel> deleteCourse(
  //     {@Path() required int timetableId, @Path() required int courseId});
}

class AddFriendDto {
  String friendCode;
  String myDisplayName;

  AddFriendDto({required this.friendCode, required this.myDisplayName});
}

@JsonSerializable()
class GenerateCodeDto {
  String myDisplayName;

  GenerateCodeDto({required this.myDisplayName});

  Map<String, dynamic> toJson() => _$GenerateCodeDtoToJson(this);
}
