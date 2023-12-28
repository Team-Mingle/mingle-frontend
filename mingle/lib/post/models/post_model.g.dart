// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      postId: json['postId'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      nickname: json['nickname'] as String,
      createdAt: json['createdAt'] as String,
      boardType: json['boardType'] as String,
      categoryType: json['categoryType'] as String,
      memberRole: json['memberRole'] as String,
      likeCount: json['likeCount'] as int,
      commentCount: json['commentCount'] as int,
      viewCount: json['viewCount'] as int,
      fileAttached: json['fileAttached'] as bool,
      blinded: json['blinded'] as bool,
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'postId': instance.postId,
      'title': instance.title,
      'content': instance.content,
      'nickname': instance.nickname,
      'createdAt': instance.createdAt,
      'boardType': instance.boardType,
      'categoryType': instance.categoryType,
      'memberRole': instance.memberRole,
      'likeCount': instance.likeCount,
      'commentCount': instance.commentCount,
      'viewCount': instance.viewCount,
      'fileAttached': instance.fileAttached,
      'blinded': instance.blinded,
    };
