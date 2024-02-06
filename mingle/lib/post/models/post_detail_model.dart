import 'package:json_annotation/json_annotation.dart';
import 'package:mingle/post/models/post_model.dart';

part 'post_detail_model.g.dart';

@JsonSerializable()
class PostDetailModel extends PostModel {
  int scrapCount;
  final List<String> postImgUrl;
  final String status;
  final bool myPost;
  bool liked;
  bool scraped;

  PostDetailModel(
      {required super.postId,
      required super.title,
      required super.content,
      required super.nickname,
      required super.createdAt,
      required super.memberRole,
      required this.status,
      required super.boardType,
      required super.categoryType,
      required super.likeCount,
      required super.commentCount,
      required super.viewCount,
      required this.scrapCount,
      required this.postImgUrl,
      required super.fileAttached,
      required super.blinded,
      required this.myPost,
      required this.liked,
      required this.scraped});

  factory PostDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PostDetailModelFromJson(json);

  static convertCategoryTypeToCategoryName(String categoryType) {
    switch (categoryType) {
      case "FREE":
        return "자유";
      case "QNA":
        return "질문";
      case "KSA":
        return "학생회";
      case "MINGLE":
        return "밍슬소식";
    }
  }

  // "postId": 0,
  // "title": "string",
  // "content": "string",
  // "nickname": "string",
  // "createdAt": "string",
  // "memberRole": "USER",
  // "status": "ACTIVE",
  // "likeCount": 0,
  // "commentCount": 0,
  // "viewCount": 0,
  // "scrapCount": 0,
  // "postImgUrl": [
  //   "string"
  // ],
  // "fileAttached": true,
  // "blinded": true,
  // "myPost": true,
  // "liked": true,
  // "scraped": true
}
