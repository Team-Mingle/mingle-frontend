// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      commentId: json['commentId'] as int,
      nickname: json['nickname'] as String,
      content: json['content'] as String,
      likeCount: json['likeCount'] as int,
      createdAt: json['createdAt'] as String,
      coCommentsList:
          CommentModel.convertToCommentModel(json['coCommentsList'] as List?),
      liked: json['liked'] as bool,
      myComment: json['myComment'] as bool,
      commentFromAuthor: json['commentFromAuthor'] as bool,
      commentDeleted: json['commentDeleted'] as bool,
      commentReported: json['commentReported'] as bool,
      admin: json['admin'] as bool,
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'commentId': instance.commentId,
      'nickname': instance.nickname,
      'content': instance.content,
      'likeCount': instance.likeCount,
      'createdAt': instance.createdAt,
      'coCommentsList': instance.coCommentsList,
      'liked': instance.liked,
      'myComment': instance.myComment,
      'commentFromAuthor': instance.commentFromAuthor,
      'commentDeleted': instance.commentDeleted,
      'commentReported': instance.commentReported,
      'admin': instance.admin,
    };
