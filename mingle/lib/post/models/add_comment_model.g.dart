// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCommentModel _$AddCommentModelFromJson(Map<String, dynamic> json) =>
    AddCommentModel(
      postId: (json['postId'] as num).toInt(),
      parentCommentId: (json['parentCommentId'] as num?)?.toInt(),
      mentionId: (json['mentionId'] as num?)?.toInt(),
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
