// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddPostModel _$AddPostModelFromJson(Map<String, dynamic> json) => AddPostModel(
      title: json['title'] as String,
      content: json['content'] as String,
      categoryType: json['categoryType'] as String,
      isAnonymous: json['isAnonymous'] as bool,
    );

Map<String, dynamic> _$AddPostModelToJson(AddPostModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'categoryType': instance.categoryType,
      'isAnonymous': instance.isAnonymous,
    };
