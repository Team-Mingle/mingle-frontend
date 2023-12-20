// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostDetailModel _$PostDetailModelFromJson(Map<String, dynamic> json) =>
    PostDetailModel(
      postId: json['postId'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      nickname: json['nickname'] as String,
      createdAt: json['createdAt'] as String,
      memberRole: json['memberRole'] as String,
      status: json['status'] as String,
      boardType: json['boardType'] as String,
      categoryType: json['categoryType'] as String,
      likeCount: json['likeCount'] as int,
      commentCount: json['commentCount'] as int,
      viewCount: json['viewCount'] as int,
      scrapCount: json['scrapCount'] as int,
      postImgUrl: (json['postImgUrl'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      fileAttached: json['fileAttached'] as bool,
      blinded: json['blinded'] as bool,
      myPost: json['myPost'] as bool,
      liked: json['liked'] as bool,
      scraped: json['scraped'] as bool,
    );

Map<String, dynamic> _$PostDetailModelToJson(PostDetailModel instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'title': instance.title,
      'content': instance.content,
      'nickname': instance.nickname,
      'createdAt': instance.createdAt,
      'memberRole': instance.memberRole,
      'status': instance.status,
      'boardType': instance.boardType,
      'categoryType': instance.categoryType,
      'likeCount': instance.likeCount,
      'commentCount': instance.commentCount,
      'viewCount': instance.viewCount,
      'scrapCount': instance.scrapCount,
      'postImgUrl': instance.postImgUrl,
      'fileAttached': instance.fileAttached,
      'blinded': instance.blinded,
      'myPost': instance.myPost,
      'liked': instance.liked,
      'scraped': instance.scraped,
    };
