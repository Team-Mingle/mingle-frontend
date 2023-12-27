// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCommentModel _$AddCommentModelFromJson(Map<String, dynamic> json) =>
    AddCommentModel(
      postId: json['postId'] as int,
      parentCommentId: json['parentCommentId'] as int?,
      mentionId: json['mentionId'] as int?,
      content: json['content'] as String,
      isAnonymous: json['isAnonymous'] as bool,
    );

Map<String, dynamic> _$AddCommentModelToJson(AddCommentModel instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'parentCommentId': instance.parentCommentId,
      'mentionId': instance.mentionId,
      'content': instance.content,
      'isAnonymous': instance.isAnonymous,
    };
