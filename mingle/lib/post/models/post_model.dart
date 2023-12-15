import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel {
  final int postId;
  final String title;
  final String content;
  final String nickname;
  final String createdAt;
  final String boardType;
  final String categoryType;
  final String memberRole;
  final int likeCount;
  final int commentCount;
  final int viewCount;
  final bool fileAttached;
  final bool blinded;

  PostModel(
      {required this.postId,
      required this.title,
      required this.content,
      required this.nickname,
      required this.createdAt,
      required this.boardType,
      required this.categoryType,
      required this.memberRole,
      required this.likeCount,
      required this.commentCount,
      required this.viewCount,
      required this.fileAttached,
      required this.blinded});

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}

// "postId": 0,
//     "title": "string",
//     "content": "string",
//     "nickname": "string",
//     "createdAt": "string",
//     "boardType": "TOTAL",
//     "categoryType": "FREE",
//     "memberRole": "USER",
//     "likeCount": 0,
//     "commentCount": 0,
//     "viewCount": 0,
//     "fileAttached": true,
//     "blinded": true