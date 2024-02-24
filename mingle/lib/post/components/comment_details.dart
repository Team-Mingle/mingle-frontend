import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mingle/common/component/like_animation.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/post/components/indicator_widget.dart';
import 'package:mingle/post/models/comment_model.dart';
import 'package:mingle/post/repository/comment_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class CommentDetails extends ConsumerStatefulWidget {
  final CommentModel comment;
  final String? parentNickname;
  final Function setParentAndMentionId;
  final int? parentCommentId;
  final Function likeOrUnlikeComment;
  final Function refreshComments;
  const CommentDetails(
      {super.key,
      this.parentNickname,
      required this.comment,
      this.parentCommentId,
      required this.setParentAndMentionId,
      required this.likeOrUnlikeComment,
      required this.refreshComments});

  @override
  ConsumerState<CommentDetails> createState() => _CommentDetailsState();
}

class _CommentDetailsState extends ConsumerState<CommentDetails> {
  late FToast fToast;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

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
      const SizedBox(
        height: 6.0,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.parentNickname == null
              ? Expanded(
                  child: Text(
                    widget.comment.content,
                    style: const TextStyle(fontSize: 13.0),
                  ),
                )
              : Expanded(
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "@${widget.parentNickname}",
                        style: const TextStyle(
                            fontSize: 13.0, color: PRIMARY_COLOR_ORANGE_01)),
                    const TextSpan(text: " "),
                    LinkifySpan(
                      text: widget.comment.content,
                      style:
                          const TextStyle(fontSize: 13.0, color: Colors.black),
                      onOpen: (link) async {
                        if (!await launchUrl(Uri.parse(link.url))) {
                          fToast.showToast(
                            child: const Text("링크를 열 수 없습니다."),
                            gravity: ToastGravity.CENTER,
                            toastDuration: const Duration(seconds: 2),
                          );
                        }
                      },
                    )
                  ])),
                ),
          const SizedBox(
            width: 12.0,
          ),
          // const Spacer(),
          // Flexible(fit: FlexFit.loose, child: Container()),
          Padding(
            padding: const EdgeInsets.only(
              left: 4.0,
              right: 4.0,
              top: 1.0,
            ),
            child: GestureDetector(
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
          ),
        ],
      ),
      const SizedBox(
        height: 10.0,
      ),
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 3.0,
              bottom: 2.0,
            ),
            child: Row(
              children: [
                // buildRoleIndicator(widget.comment.nickname, widget.comment.memberRole, fontSize),
                Text(
                  widget.comment.nickname,
                  style: TextStyle(
                    color: widget.comment.commentFromAuthor
                        ? GRAYSCALE_GRAY_ORANGE_02
                        : GRAYSCALE_GRAY_03,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    height: 15 / 12,
                  ),
                ),
                const SizedBox(
                  width: 4.0,
                ),
                const Text(
                  "•",
                  style: TextStyle(
                    color: GRAYSCALE_GRAY_02,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    height: 15 / 12,
                  ),
                ),
                const SizedBox(
                  width: 4.0,
                ),
                Text(
                  createdDate,
                  style: const TextStyle(
                    color: GRAYSCALE_GRAY_03,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    height: 15 / 12,
                  ),
                ),
                const SizedBox(
                  width: 4.0,
                ),
                Text(
                  createdTime,
                  style: const TextStyle(
                    color: GRAYSCALE_GRAY_03,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    height: 15 / 12,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(
              top: 2.0,
              bottom: 2,
              left: 4,
              right: 2,
            ),
            child: GestureDetector(
              onTap: () {
                widget.likeOrUnlikeComment(widget.comment.commentId);
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
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 1,
                      bottom: 3,
                      left: 1.2,
                      right: 2,
                    ),
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
                    width: 4.0,
                  ),
                  Text(
                    widget.comment.likeCount.toString(),
                    style: const TextStyle(
                      color: GRAYSCALE_GRAY_03,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      height: 15 / 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 11.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 4.0,
              vertical: 2.0,
            ),
            child: GestureDetector(
              onTap: () => widget.setParentAndMentionId(
                  widget.parentCommentId, widget.comment.commentId),
              child: SvgPicture.asset(
                "assets/img/post_screen/reply_icon.svg",
                width: 16.0,
                height: 16.0,
              ),
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
