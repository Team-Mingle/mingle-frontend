// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'second_hand_market_post_comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SecondHandMarketPostCommentModel _$SecondHandMarketPostCommentModelFromJson(
        Map<String, dynamic> json) =>
    SecondHandMarketPostCommentModel(
      commentId: json['commentId'] as int,
      nickname: json['nickname'] as String,
      content: json['content'] as String,
      likeCount: json['likeCount'] as int,
      createdAt: json['createdAt'] as String,
      coCommentsList: (json['coCommentsList'] as List<dynamic>)
          .map((e) => SecondHandMarketPostCommentModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      myComment: json['myComment'] as bool,
      commentFromAuthor: json['commentFromAuthor'] as bool,
      commentDeleted: json['commentDeleted'] as bool,
      commentReported: json['commentReported'] as bool,
      admin: json['admin'] as bool,
      liked: json['liked'] as bool,
    );

Map<String, dynamic> _$SecondHandMarketPostCommentModelToJson(
        SecondHandMarketPostCommentModel instance) =>
    <String, dynamic>{
      'commentId': instance.commentId,
      'nickname': instance.nickname,
      'content': instance.content,
      'likeCount': instance.likeCount,
      'createdAt': instance.createdAt,
      'coCommentsList': instance.coCommentsList,
      'myComment': instance.myComment,
      'commentFromAuthor': instance.commentFromAuthor,
      'commentDeleted': instance.commentDeleted,
      'commentReported': instance.commentReported,
      'admin': instance.admin,
      'liked': instance.liked,
    };
