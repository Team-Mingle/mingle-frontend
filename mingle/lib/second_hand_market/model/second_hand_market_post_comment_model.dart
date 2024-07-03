import 'package:json_annotation/json_annotation.dart';

part 'second_hand_market_post_comment_model.g.dart';

@JsonSerializable()
class SecondHandMarketPostCommentModel {
  final int commentId;
  final String nickname;
  final String content;
  final int likeCount;
  final String createdAt;
  final List<SecondHandMarketPostCommentModel> coCommentsList;
  final bool myComment;
  final bool commentFromAuthor;
  final bool commentDeleted;
  final bool commentReported;
  final bool admin;
  final bool liked;

  SecondHandMarketPostCommentModel(
      {required this.commentId,
      required this.nickname,
      required this.content,
      required this.likeCount,
      required this.createdAt,
      required this.coCommentsList,
      required this.myComment,
      required this.commentFromAuthor,
      required this.commentDeleted,
      required this.commentReported,
      required this.admin,
      required this.liked});

  factory SecondHandMarketPostCommentModel.fromJson(
          Map<String, dynamic> json) =>
      _$SecondHandMarketPostCommentModelFromJson(json);
}



// "commentId": 0,
//     "nickname": "string",
//     "content": "string",
//     "likeCount": 0,
//     "createdAt": "string",
//     "coCommentsList": [
//       {

//     ],
//     "myComment": true,
//     "commentFromAuthor": true,
//     "commentDeleted": true,
//     "commentReported": true,
//     "admin": true,
//     "liked": true