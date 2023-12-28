import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel {
  final int commentId;
  final String nickname;
  String content;
  int likeCount;
  final String createdAt;
  @JsonKey(fromJson: CommentModel.convertToCommentModel)
  final List<CommentModel>? coCommentsList;
  bool liked;
  final bool myComment;
  final bool commentFromAuthor;
  final bool commentDeleted;
  final bool commentReported;
  final bool admin;

  CommentModel(
      {required this.commentId,
      required this.nickname,
      required this.content,
      required this.likeCount,
      required this.createdAt,
      required this.coCommentsList,
      required this.liked,
      required this.myComment,
      required this.commentFromAuthor,
      required this.commentDeleted,
      required this.commentReported,
      required this.admin});

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  static List<CommentModel> convertToCommentModel(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return [];
    }
    print(jsonList);
    List<CommentModel> result = [];
    for (dynamic json in jsonList) {
      print(json);
      result.add(CommentModel.fromJson(json));
    }
    return result;
  }
  // "commentId": 0,
  //   "nickname": "string",
  //   "content": "string",
  //   "likeCount": 0,
  //   "createdAt": "string",
  //   "coCommentsList": [
  //     {
  //       "commentId": 0,
  //       "nickname": "string",
  //       "content": "string",
  //       "likeCount": 0,
  //       "createdAt": "string",
  //       "parentCommentId": 0,
  //       "mention": "string",
  //       "liked": true,
  //       "myComment": true,
  //       "commentFromAuthor": true,
  //       "commentDeleted": true,
  //       "commentReported": true,
  //       "admin": true
  //     }
  //   ],
  //   "liked": true,
  //   "myComment": true,
  //   "commentFromAuthor": true,
  //   "commentDeleted": true,
  //   "commentReported": true,
  //   "admin": true
}
