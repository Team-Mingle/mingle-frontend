// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temp_signup_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TempSignupRequestModel _$TempSignupRequestModelFromJson(
        Map<String, dynamic> json) =>
    TempSignupRequestModel(
      memberId: (json['memberId'] as num).toInt(),
      photoUrl: json['photoUrl'] as String,
      nickname: json['nickname'] as String,
      studentId: json['studentId'] as String?,
      universityName: json['universityName'] as String,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$TempSignupRequestModelToJson(
        TempSignupRequestModel instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'photoUrl': instance.photoUrl,
      'nickname': instance.nickname,
      'studentId': instance.studentId,
      'universityName': instance.universityName,
      'email': instance.email,
    };
