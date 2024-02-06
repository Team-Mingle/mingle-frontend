import 'package:json_annotation/json_annotation.dart';

part '../provider/banner_model.g.dart';

@JsonSerializable()
class BannerModel {
  final int id;
  final String imgUrl;
  final String linkUrl;

  BannerModel({
    required this.id,
    required this.imgUrl,
    required this.linkUrl,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);
}
