// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'second_hand_market_post_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SecondHandMarketPostDetailModel _$SecondHandMarketPostDetailModelFromJson(
        Map<String, dynamic> json) =>
    SecondHandMarketPostDetailModel(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      price: json['price'] as int,
      nickname: json['nickname'] as String,
      createdAt: json['createdAt'] as String,
      likeCount: json['likeCount'] as int,
      commentCount: json['commentCount'] as int,
      status: json['status'] as String,
      imgThumbnailUrl: json['imgThumbnailUrl'] as String,
      location: json['location'] as String,
      itemImgList: (json['itemImgList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      chatUrl: json['chatUrl'] as String,
      currency: json['currency'] as String,
      isLiked: json['isLiked'] as bool,
      viewCount: json['viewCount'] as int,
      isFileAttached: json['isFileAttached'] as bool,
      isAnonymous: json['isAnonymous'] as bool,
      isMyPost: json['isMyPost'] as bool,
      isReported: json['isReported'] as bool,
      isBlinded: json['isBlinded'] as bool,
      isAdmin: json['isAdmin'] as bool,
    );

Map<String, dynamic> _$SecondHandMarketPostDetailModelToJson(
        SecondHandMarketPostDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'price': instance.price,
      'nickname': instance.nickname,
      'createdAt': instance.createdAt,
      'likeCount': instance.likeCount,
      'commentCount': instance.commentCount,
      'status': instance.status,
      'imgThumbnailUrl': instance.imgThumbnailUrl,
      'location': instance.location,
      'itemImgList': instance.itemImgList,
      'chatUrl': instance.chatUrl,
      'currency': instance.currency,
      'isLiked': instance.isLiked,
      'viewCount': instance.viewCount,
      'isFileAttached': instance.isFileAttached,
      'isAnonymous': instance.isAnonymous,
      'isMyPost': instance.isMyPost,
      'isReported': instance.isReported,
      'isBlinded': instance.isBlinded,
      'isAdmin': instance.isAdmin,
    };
