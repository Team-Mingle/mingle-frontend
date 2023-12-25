import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/component/like_animation.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/post/models/comment_model.dart';
import 'package:mingle/post/repository/comment_repository.dart';

class CommentDetails extends ConsumerStatefulWidget {
  final CommentModel comment;
  final Function setParentAndMentionId;
  final int? parentCommentId;
  final Function likeOrUnlikeComment;
  final Function refreshComments;
  const CommentDetails(
      {super.key,
      required this.comment,
      this.parentCommentId,
      required this.setParentAndMentionId,
      required this.likeOrUnlikeComment,
      required this.refreshComments});

  @override
  ConsumerState<CommentDetails> createState() => _CommentDetailsState();
}

class _CommentDetailsState extends ConsumerState<CommentDetails> {
  @override
  Widget build(BuildContext context) {
    String createdDate = widget.comment.createdAt.split(" ")[0];
    String createdTime = widget.comment.createdAt.split(" ")[1];

    void deleteComment() async {
      final resp = await ref
          .watch(commentRepositoryProvider)
          .deleteComment(commentId: widget.comment.commentId);
      widget.refreshComments();
    }

    return Column(mainAxisSize: MainAxisSize.min, children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.comment.content,
            style: const TextStyle(fontSize: 13.0),
          ),
          const SizedBox(
            width: 12.0,
          ),
          const Spacer(),
          // Flexible(fit: FlexFit.loose, child: Container()),
          GestureDetector(
              onTap: () => showCupertinoModalPopup<void>(
                    context: context,
                    builder: (BuildContext context) => CupertinoActionSheet(
                      cancelButton: CupertinoActionSheetAction(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('취소하기'),
                      ),
                      actions: <CupertinoActionSheetAction>[
                        widget.comment.myComment
                            ? CupertinoActionSheetAction(
                                onPressed: () {
                                  deleteComment();
                                  Navigator.pop(context);
                                },
                                isDestructiveAction: true,
                                child: const Text('삭제하기'),
                              )
                            : CupertinoActionSheetAction(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                isDestructiveAction: true,
                                child: const Text('신고하기'),
                              ),
                      ],
                    ),
                  ),
              child: SvgPicture.asset(
                  "assets/img/post_screen/triple_dot_icon.svg")),
          const SizedBox(
            width: 4.0,
          )
        ],
      ),
      const SizedBox(
        height: 10.0,
      ),
      Row(
        children: [
          const Text(
            "익명", // TODO: render accordingly
            style: TextStyle(color: GRAYSCALE_GRAY_04, fontSize: 12.0),
          ),
          const SizedBox(
            width: 4.0,
          ),
          const Text(
            "•",
            style: TextStyle(color: GRAYSCALE_GRAY_02, fontSize: 12.0),
          ),
          const SizedBox(
            width: 4.0,
          ),
          Text(
            // "07/17",
            createdDate,
            style: const TextStyle(color: GRAYSCALE_GRAY_03, fontSize: 12.0),
          ),
          const SizedBox(
            width: 4.0,
          ),
          Text(
            // "13:03",
            createdTime,
            style: const TextStyle(color: GRAYSCALE_GRAY_03, fontSize: 12.0),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              // widget.likeOrUnlikeComment(
              //     widget.comment.commentId, widget.comment.liked);
              if (widget.comment.liked) {
                setState(() {
                  widget.comment.likeCount -= 1;
                  widget.comment.liked = false;
                });
              } else {
                setState(() {
                  widget.comment.likeCount += 1;
                  widget.comment.liked = true;
                });
              }
            },
            child: LikeAnimation(
              isAnimating: widget.comment.liked,
              child: SvgPicture.asset(
                widget.comment.liked
                    ? "assets/img/post_screen/thumbs_up_selected_icon.svg"
                    : "assets/img/post_screen/thumbs_up_icon.svg",
                width: 12.8,
                height: 12.0,
              ),
            ),
          ),
          const SizedBox(
            width: 6.0,
          ),
          Text(
            // "0",
            widget.comment.likeCount.toString(),
            style: const TextStyle(color: GRAYSCALE_GRAY_03, fontSize: 12.0),
          ),
          const SizedBox(
            width: 22.0,
          ),
          GestureDetector(
            onTap: () => widget.setParentAndMentionId(
                widget.parentCommentId, widget.comment.commentId),
            child: SvgPicture.asset(
              "assets/img/post_screen/reply_icon.svg",
              width: 16.0,
              height: 16.0,
            ),
          ),
          const SizedBox(
            width: 4.0,
          )
        ],
      ),
      // const CommentReplyCard()
    ]);
  }
}
