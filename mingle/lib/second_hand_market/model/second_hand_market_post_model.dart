import 'package:json_annotation/json_annotation.dart';

part 'second_hand_market_post_model.g.dart';

@JsonSerializable()
class SecondHandMarketPostModel {
  final int id;
  final String title;
  final String content;
  final int price;
  final String nickname;
  final String createdAt;
  int likeCount;
  int commentCount;
  final String status;
  final String imgThumbnailUrl;
  final String location;
  final List<String> itemImgList;
  final String chatUrl;
  final String currency;
  bool isLiked;

  SecondHandMarketPostModel(
      {required this.id,
      required this.title,
      required this.content,
      required this.price,
      required this.nickname,
      required this.createdAt,
      required this.likeCount,
      required this.commentCount,
      required this.status,
      required this.imgThumbnailUrl,
      required this.location,
      required this.itemImgList,
      required this.chatUrl,
      required this.currency,
      required this.isLiked});

  factory SecondHandMarketPostModel.fromJson(Map<String, dynamic> json) =>
      _$SecondHandMarketPostModelFromJson(json);
}



// "id": 0,
//       "title": "string",
//       "content": "string",
//       "price": 0,
//       "nickName": "string",
//       "createdAt": "string",
//       "likeCount": 0,
//       "commentCount": 0,
//       "status": "string",
//       "imgThumbnailUrl": "string",
//       "location": "string",
//       "itemImgList": [
//         "string"
//       ],
//       "chatUrl": "string",
//       "currency": "KRW",
//       "liked": true