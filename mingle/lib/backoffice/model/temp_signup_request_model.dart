import 'package:json_annotation/json_annotation.dart';

part 'temp_signup_request_model.g.dart';

@JsonSerializable()
class TempSignupRequestModel {
  final String photoUrl;
  final String nickname;
  final String? studentId;
  final String universityName;
  final String? email;

  TempSignupRequestModel({
    required this.photoUrl,
    required this.nickname,
    required this.studentId,
    required this.universityName,
    required this.email,
  });

  factory TempSignupRequestModel.fromJson(Map<String, dynamic> json) =>
      _$TempSignupRequestModelFromJson(json);
}
