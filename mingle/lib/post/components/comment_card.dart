import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/post/components/comment_details.dart';
import 'package:mingle/post/components/comment_reply_card.dart';
import 'package:mingle/post/models/comment_model.dart';

class CommentCard extends StatelessWidget {
  final CommentModel comment;
  final Function setParentAndMentionId;
  final Function likeOrUnlikeComment;
  const CommentCard(
      {super.key,
      required this.comment,
      required this.setParentAndMentionId,
      required this.likeOrUnlikeComment});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CommentDetails(
            comment: comment,
            parentCommentId: comment.commentId,
            setParentAndMentionId: setParentAndMentionId,
            likeOrUnlikeComment: likeOrUnlikeComment,
          ),
        ),
        Column(
          children: List.generate(
            comment.coCommentsList!.length,
            (index) => Column(
              children: [
                const SizedBox(
                  height: 12.0,
                ),
                CommentReplyCard(
                  likeOrUnlikeComment: likeOrUnlikeComment,
                  setParentAndMentionId: setParentAndMentionId,
                  parentCommentId: comment.commentId,
                  comment: comment.coCommentsList![index],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
