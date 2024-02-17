import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final int memberId;
  final String hashedEmail;
  final String nickName;
  final String univName;

  UserModel({
    required this.memberId,
    required this.hashedEmail,
    required this.nickName,
    required this.univName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  UserModel copyWith(
      {int? memberId,
      String? hashedEmail,
      String? nickName,
      String? univName}) {
    return UserModel(
        memberId: memberId ?? this.memberId,
        hashedEmail: hashedEmail ?? this.hashedEmail,
        nickName: nickName ?? this.nickName,
        univName: univName ?? this.univName);
  }
}

// "memberId": 0,
//   "hashedEmail": "string",
//   "nickName": "string",
//   "univName": "string",
//   "accessToken": "string",
//   "refreshToken": "string"