// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      memberId: json['memberId'] as int,
      hashedEmail: json['hashedEmail'] as String,
      nickName: json['nickName'] as String,
      univName: json['univName'] as String,
      country: json['country'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'memberId': instance.memberId,
      'hashedEmail': instance.hashedEmail,
      'nickName': instance.nickName,
      'univName': instance.univName,
      'country': instance.country,
    };
