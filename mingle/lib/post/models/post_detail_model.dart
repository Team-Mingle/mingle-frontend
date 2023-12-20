import 'package:json_annotation/json_annotation.dart';

part 'post_detail_model.g.dart';

@JsonSerializable()
class PostDetailModel {
  final int postId;
  final String title;
  final String content;
  final String nickname;
  final String createdAt;
  final String memberRole;
  final String status;
  final String boardType;
  final String categoryType;
  int likeCount;
  int commentCount;
  int viewCount;
  int scrapCount;
  final List<String> postImgUrl;
  final bool fileAttached;
  final bool blinded;
  final bool myPost;
  bool liked;
  bool scraped;

  PostDetailModel(
      {required this.postId,
      required this.title,
      required this.content,
      required this.nickname,
      required this.createdAt,
      required this.memberRole,
      required this.status,
      required this.boardType,
      required this.categoryType,
      required this.likeCount,
      required this.commentCount,
      required this.viewCount,
      required this.scrapCount,
      required this.postImgUrl,
      required this.fileAttached,
      required this.blinded,
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
