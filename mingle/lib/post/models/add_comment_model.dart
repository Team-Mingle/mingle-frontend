import 'package:json_annotation/json_annotation.dart';

part 'add_comment_model.g.dart';

@JsonSerializable()
class AddCommentModel {
  final int postId;
  final int? parentCommentId;
  final int? mentionId;
  final String content;
  final bool isAnonymous;

  AddCommentModel(
      {required this.postId,
      required this.parentCommentId,
      required this.mentionId,
      required this.content,
      required this.isAnonymous});

  Map<String, dynamic> toJson() => _$AddCommentModelToJson(this);
}

// "postId": 0,
  // "parentCommentId": 0,
  // "mentionId": 0,
  // "content": "string",
  // "isAnonymous": true