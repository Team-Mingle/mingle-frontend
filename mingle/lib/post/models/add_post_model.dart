import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_post_model.g.dart';

@JsonSerializable()
class AddPostModel {
  final String title;
  final String content;
  final String categoryType;
  final bool isAnonymous;

  AddPostModel({
    required this.title,
    required this.content,
    required this.categoryType,
    required this.isAnonymous,
  });

  Map<String, dynamic> toJson() => _$AddPostModelToJson(this);
}
