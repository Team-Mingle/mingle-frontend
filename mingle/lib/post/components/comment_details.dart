import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mingle/common/component/like_animation.dart';
import 'package:mingle/common/component/report_modal.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/post/components/indicator_widget.dart';
import 'package:mingle/post/models/comment_model.dart';
import 'package:mingle/post/models/post_model.dart';
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
    String createdAtLocal =
        PostModel.convertUTCtoLocal(widget.comment.createdAt);
    String createdDate = createdAtLocal.split(" ")[0];
    String createdTime = createdAtLocal.split(" ")[1];

    void deleteComment() async {
      final resp = await ref
          .watch(commentRepositoryProvider)
          .deleteComment(commentId: widget.comment.commentId);
      widget.refreshComments();
    }

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 6.0,
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(children: [
                    if (widget.parentNickname != null)
                      TextSpan(
                        text: "@${widget.parentNickname} ",
                        style: const TextStyle(
                            fontSize: 13.0,
                            height: 1.4,
                            color: PRIMARY_COLOR_ORANGE_01),
                      ),
                    LinkifySpan(
                      text: widget.comment.content,
                      onOpen: (link) async {
                        if (!await launchUrl(Uri.parse(link.url))) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('링크를 열 수 없습니다.')),
                          );
                        }
                      },
                      style: const TextStyle(
                          fontSize: 13.0, height: 1.4, color: Colors.black),
                      linkStyle: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                    )
                  ]),
                ),
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
                          builder: (BuildContext context) =>
                              CupertinoActionSheet(
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
                                  : reportModal(
                                      "COMMENT",
                                      widget.comment.commentId,
                                      context,
                                      ref,
                                      fToast)
                              // CupertinoActionSheetAction(
                              //     onPressed: () {
                              //       Navigator.pop(context);
                              //     },
                              //     isDestructiveAction: true,
                              //     child: const Text('신고하기'),
                              //   ),
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
                        letterSpacing: -0.005,
                        height: 1.3,
                        fontWeight: FontWeight.w400,
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
                        letterSpacing: -0.005,
                        height: 1.3,
                        fontWeight: FontWeight.w400,
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
                        letterSpacing: -0.005,
                        height: 1.3,
                        fontWeight: FontWeight.w400,
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
                        letterSpacing: -0.005,
                        height: 1.3,
                        fontWeight: FontWeight.w400,
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
                          letterSpacing: -0.005,
                          height: 1.3,
                          fontWeight: FontWeight.w400,
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
