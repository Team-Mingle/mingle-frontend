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
      coCommentsList: (json['coCommentsList'] as List<dynamic>?)
          ?.map((e) => CoCommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
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

CoCommentModel _$CoCommentModelFromJson(Map<String, dynamic> json) =>
    CoCommentModel(
      commentId: json['commentId'] as int,
      nickname: json['nickname'] as String,
      content: json['content'] as String,
      likeCount: json['likeCount'] as int,
      createdAt: json['createdAt'] as String,
      parentCommentId: json['parentCommentId'] as int,
      mention: json['mention'] as String,
      liked: json['liked'] as bool,
      myComment: json['myComment'] as bool,
      commentFromAuthor: json['commentFromAuthor'] as bool,
      commentDeleted: json['commentDeleted'] as bool,
      commentReported: json['commentReported'] as bool,
      admin: json['admin'] as bool,
    );

Map<String, dynamic> _$CoCommentModelToJson(CoCommentModel instance) =>
    <String, dynamic>{
      'commentId': instance.commentId,
      'nickname': instance.nickname,
      'content': instance.content,
      'likeCount': instance.likeCount,
      'createdAt': instance.createdAt,
      'parentCommentId': instance.parentCommentId,
      'mention': instance.mention,
      'liked': instance.liked,
      'myComment': instance.myComment,
      'commentFromAuthor': instance.commentFromAuthor,
      'commentDeleted': instance.commentDeleted,
      'commentReported': instance.commentReported,
      'admin': instance.admin,
    };
