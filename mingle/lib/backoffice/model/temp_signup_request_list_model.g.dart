// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temp_signup_request_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TempSignupRequestListModel _$TempSignupRequestListModelFromJson(
        Map<String, dynamic> json) =>
    TempSignupRequestListModel(
      tempSignUpApplyList: (json['tempSignUpApplyList'] as List<dynamic>)
          .map(
              (e) => TempSignupRequestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TempSignupRequestListModelToJson(
        TempSignupRequestListModel instance) =>
    <String, dynamic>{
      'tempSignUpApplyList': instance.tempSignUpApplyList,
    };
