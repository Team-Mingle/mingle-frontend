import 'package:json_annotation/json_annotation.dart';
import 'package:mingle/backoffice/model/temp_signup_request_model.dart';

part 'temp_signup_request_list_model.g.dart';

@JsonSerializable()
class TempSignupRequestListModel {
  final List<TempSignupRequestModel> tempSignUpApplyList;

  TempSignupRequestListModel({required this.tempSignUpApplyList});

  factory TempSignupRequestListModel.fromJson(Map<String, dynamic> json) =>
      _$TempSignupRequestListModelFromJson(json);
}
