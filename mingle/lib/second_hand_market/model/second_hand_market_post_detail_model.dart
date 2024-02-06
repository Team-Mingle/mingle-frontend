import 'package:json_annotation/json_annotation.dart';
import 'package:mingle/second_hand_market/model/second_hand_market_post_model.dart';

part 'second_hand_market_post_detail_model.g.dart';

@JsonSerializable()
class SecondHandMarketPostDetailModel extends SecondHandMarketPostModel {
  final int viewCount;
  final bool isFileAttached;
  final bool isAnonymous;
  final bool isMyPost;
  final bool isReported;
  final bool isBlinded;
  final bool isAdmin;

  SecondHandMarketPostDetailModel({
    required super.id,
    required super.title,
    required super.content,
    required super.price,
    required super.nickname,
    required super.createdAt,
    required super.likeCount,
    required super.commentCount,
    required super.status,
    required super.imgThumbnailUrl,
    required super.location,
    required super.itemImgList,
    required super.chatUrl,
    required super.currency,
    required super.isLiked,
    required this.viewCount,
    required this.isFileAttached,
    required this.isAnonymous,
    required this.isMyPost,
    required this.isReported,
    required this.isBlinded,
    required this.isAdmin,
  });

  factory SecondHandMarketPostDetailModel.fromJson(Map<String, dynamic> json) =>
      _$SecondHandMarketPostDetailModelFromJson(json);
}

//   "content": "string",

//   "viewCount": 0,

//   "isFileAttached": true,
//   "isAnonymous": true,
//   "isMyPost": true,
//   "isLiked": true,
//   "isReported": true,
//   "isBlinded": true,
//   "isAdmin": true,
