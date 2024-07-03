// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'second_hand_market_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SecondHandMarketPostModel _$SecondHandMarketPostModelFromJson(
        Map<String, dynamic> json) =>
    SecondHandMarketPostModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      content: json['content'] as String,
      price: (json['price'] as num).toInt(),
      nickname: json['nickname'] as String,
      createdAt: json['createdAt'] as String,
      likeCount: (json['likeCount'] as num).toInt(),
      commentCount: (json['commentCount'] as num).toInt(),
      status: json['status'] as String,
      imgThumbnailUrl: json['imgThumbnailUrl'] as String,
      location: json['location'] as String,
      itemImgList: (json['itemImgList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      chatUrl: json['chatUrl'] as String,
      currency: json['currency'] as String,
      isLiked: json['isLiked'] as bool,
    );

Map<String, dynamic> _$SecondHandMarketPostModelToJson(
        SecondHandMarketPostModel instance) =>
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
    };
