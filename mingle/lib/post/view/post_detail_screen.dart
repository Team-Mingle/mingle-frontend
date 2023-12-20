import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/component/anonymous_textfield.dart';
import 'package:mingle/common/component/like_animation.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/common/view/image_detail_screen.dart';
import 'package:mingle/post/components/comment_card.dart';
import 'package:mingle/post/models/add_comment_model.dart';
import 'package:mingle/post/models/comment_model.dart';
import 'package:mingle/post/models/post_detail_model.dart';
import 'package:mingle/post/models/post_model.dart';
import 'package:mingle/post/repository/comment_repository.dart';
import 'package:mingle/post/repository/post_repository.dart';
import 'package:mingle/post/view/edit_post_screen.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';

class PostDetailScreen extends ConsumerStatefulWidget {
  final int postId;
  final Function refreshList;
  const PostDetailScreen(
      {super.key, required this.postId, required this.refreshList});

  @override
  ConsumerState<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends ConsumerState<PostDetailScreen> {
  int? parentCommentId;
  int? mentionId;
  late Future<List<CommentModel>> commentFuture;
  late Future<PostDetailModel> postFuture;

  @override
  void initState() {
    super.initState();
  }

  void setParentCommentIdAndMentionId(int? parentId, int? mentId) {
    setState(() {
      parentCommentId = parentId;
      mentionId = mentId;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("id is $parentCommentId");
    commentFuture = ref
        .watch(postRepositoryProvider)
        .getPostcomments(postId: widget.postId);
    // postFuture =
    //     ref.watch(postRepositoryProvider).getPostDetails(postId: widget.postId);
    void handleCommentSubmit(String comment, bool isAnonymous) async {
      AddCommentModel addCommentModel = AddCommentModel(
          postId: widget.postId,
          parentCommentId: parentCommentId,
          mentionId: mentionId,
          content: comment,
          isAnonymous: isAnonymous);
      // print(addCommentModel.postId);
      // print(addCommentModel.parentCommentId);
      // print(addCommentModel.mentionId);
      // print(addCommentModel.content);
      // print(addCommentModel.isAnonymous);

      final commentRepository = ref.watch(commentRepositoryProvider);
      await commentRepository.postComment(addCommentModel);
      setState(() {
        commentFuture = ref
            .watch(postRepositoryProvider)
            .getPostcomments(postId: widget.postId);
      });
      widget.refreshList();
    }

    void refreshPost() async {
      setState(() {
        postFuture = ref
            .watch(postRepositoryProvider)
            .getPostDetails(postId: widget.postId);
      });
      widget.refreshList();
    }

    void likePost() async {
      final resp = await ref
          .watch(postRepositoryProvider)
          .likePost(postId: widget.postId);
      setState(() {
        postFuture = ref
            .watch(postRepositoryProvider)
            .getPostDetails(postId: widget.postId);
      });
      widget.refreshList();
    }

    void likeOrUnlikeComment(int commentId, bool isCommentLiked) async {
      print(commentId);
      if (isCommentLiked) {
        final resp = await ref
            .watch(commentRepositoryProvider)
            .unlikeComment(commentId: commentId);
      } else {
        final resp = await ref
            .watch(commentRepositoryProvider)
            .likeComment(commentId: commentId);
      }
      // setState(() {
      //   commentFuture = ref
      //       .watch(postRepositoryProvider)
      //       .getPostcomments(postId: widget.postId);
      // });
    }

    // void unlikePost() async {
    //   final resp = await ref
    //       .watch(postRepositoryProvider)
    //       .unlikePost(postId: widget.postId);
    //   setState(() {
    //     postFuture = ref
    //         .watch(postRepositoryProvider)
    //         .getPostDetails(postId: widget.postId);
    //   });
    // }

    // void setMentionId(int id) {
    //   setState(() {
    //     mentionId = id;
    //   });
    // }

    void deletePost() async {
      final resp = await ref
          .watch(postRepositoryProvider)
          .deletePost(postId: widget.postId);
      widget.refreshList();
      Navigator.of(context).pop();
    }

    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
        future: ref
            .watch(postRepositoryProvider)
            .getPostDetails(postId: widget.postId),
        // postDetailFuture(postId),
        builder: (context, AsyncSnapshot<PostDetailModel> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          PostDetailModel post = snapshot.data!;
          print(post.postImgUrl);
          String createdDate = post.createdAt.split(" ")[0];
          String createdTime = post.createdAt.split(" ")[1];
          return Scaffold(
            body: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: SizedBox(
                  height: 10.0,
                  width: 10.0,
                  child: InkWell(
                    child: Image.asset(
                        "assets/img/signup_screen/previous_screen_icon.png"),
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ),
                titleSpacing: 0,
                title: const Text(
                  "게시판 이름",
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: GRAYSCALE_GRAY_03),
                ),
                centerTitle: false,
                actions: [
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
                        actions: post.myPost
                            ? <CupertinoActionSheetAction>[
                                CupertinoActionSheetAction(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (_) => EditPostScreen(
                                            refreshPost: refreshPost,
                                            postId: widget.postId,
                                            boardType: post.boardType,
                                            title: post.title,
                                            content: post.content,
                                            categoryType: post.categoryType,
                                            categoryName: PostDetailModel
                                                .convertCategoryTypeToCategoryName(
                                                    post.categoryType),
                                            isAnonymous: post.nickname == "익명",
                                            postImgUrl: post.postImgUrl)));
                                  },
                                  isDestructiveAction: false,
                                  child: const Text('수정하기'),
                                ),
                                CupertinoActionSheetAction(
                                  onPressed: () {
                                    deletePost();
                                    Navigator.pop(context);
                                  },
                                  isDestructiveAction: true,
                                  child: const Text('삭제하기'),
                                )
                              ]
                            : <CupertinoActionSheetAction>[
                                CupertinoActionSheetAction(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  isDestructiveAction: true,
                                  child: const Text('신고하기'),
                                )
                              ],
                      ),
                    ),
                    child: SvgPicture.asset(
                        "assets/img/post_screen/triple_dot_icon.svg"),
                  ),
                  const SizedBox(
                    width: 18.0,
                  )
                ],
              ),
              body: CustomScrollView(slivers: [
                SliverList(
                    delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          post.title,
                          style: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 24.0,
                        ),
                        Text(
                          post.content,
                          style: const TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w400),
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 16.0,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  post.postImgUrl.length,
                                  (index) => Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) {
                                              return ImageDetailScreen(
                                                image: Image(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                    post.postImgUrl[index],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        child: SizedBox(
                                          height: 130.0,
                                          width: 130.0,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                post.postImgUrl[index],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            index < post.postImgUrl.length - 1
                                                ? 4.0
                                                : 0.0,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Row(
                          children: [
                            const Text(
                              "익명", // TODO:render accordingly
                              style: TextStyle(
                                  color: GRAYSCALE_GRAY_04, fontSize: 12.0),
                            ),
                            const SizedBox(
                              width: 4.0,
                            ),
                            const Text(
                              "•",
                              style: TextStyle(
                                  color: GRAYSCALE_GRAY_02, fontSize: 12.0),
                            ),
                            const SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              // "07/17",
                              createdDate,
                              style: const TextStyle(
                                  color: GRAYSCALE_GRAY_03, fontSize: 12.0),
                            ),
                            const SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              // "13:03",
                              createdTime,
                              style: const TextStyle(
                                  color: GRAYSCALE_GRAY_03, fontSize: 12.0),
                            ),
                            const SizedBox(
                              width: 6.0,
                            ),
                            const Text(
                              "조회",
                              style: TextStyle(
                                  color: GRAYSCALE_GRAY_03, fontSize: 12.0),
                            ),
                            const SizedBox(
                              width: 2.0,
                            ),
                            Text(
                              // "26",
                              post.viewCount.toString(),
                              style: const TextStyle(
                                  color: GRAYSCALE_GRAY_03, fontSize: 12.0),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const Divider(
                        thickness: 1.0,
                        height: 0.0,
                        color: GRAYSCALE_GRAY_01,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 23.0),
                        child: SizedBox(
                          height: 40.0,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "좋아요",
                                  style: TextStyle(color: GRAYSCALE_GRAY_04),
                                ),
                                const SizedBox(
                                  width: 4.0,
                                ),
                                Text(
                                  // "0",
                                  post.likeCount.toString(),
                                  style: const TextStyle(
                                      color: GRAYSCALE_GRAY_ORANGE_02,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  width: 16.0,
                                ),
                                const Text(
                                  "댓글",
                                  style: TextStyle(color: GRAYSCALE_GRAY_04),
                                ),
                                const SizedBox(
                                  width: 4.0,
                                ),
                                Text(
                                  // "0",
                                  post.commentCount.toString(),
                                  style: const TextStyle(
                                      color: GRAYSCALE_GRAY_ORANGE_02,
                                      fontWeight: FontWeight.w600),
                                ),
                                Expanded(child: Container()),
                                GestureDetector(
                                  // onTap: post.liked == null
                                  //     ? likePost
                                  //     : unlikePost,
                                  onTap: () {
                                    if (post.liked) {
                                      setState(() {
                                        post.likeCount--;
                                        post.liked = false;
                                      });
                                    } else {
                                      setState(() {
                                        post.likeCount++;
                                        post.liked = true;
                                      });
                                    }
                                  },
                                  child: LikeAnimation(
                                    isAnimating: post.liked,
                                    child: SvgPicture.asset(post.liked
                                        ? "assets/img/post_screen/thumbs_up_selected_icon.svg"
                                        : "assets/img/post_screen/thumbs_up_icon.svg"),
                                  ),
                                ),
                                const SizedBox(
                                  width: 34.0,
                                ),
                                SvgPicture.asset(
                                    "assets/img/post_screen/scrap_icon.svg"),
                              ]),
                        ),
                      ),
                      const Divider(
                        height: 0.0,
                        thickness: 2.0,
                        color: GRAYSCALE_GRAY_01,
                      ),
                      Container(
                        color: GRAYSCALE_GRAY_01_5,
                        height: 56.0,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 12.0,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "•",
                                    style: TextStyle(
                                        color: GRAYSCALE_GRAY_03,
                                        fontSize: 11.0),
                                  ),
                                  Text("운영규칙을 위반하는 댓글은 삭제될 수 있습니다.",
                                      style: TextStyle(
                                          color: GRAYSCALE_GRAY_03,
                                          fontSize: 11.0))
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "•",
                                    style: TextStyle(
                                        color: GRAYSCALE_GRAY_03,
                                        fontSize: 11.0),
                                  ),
                                  Text("악의적인 글 혹은 댓글은 오른쪽 상단 버튼을 통해 신고가 가능합니다.",
                                      style: TextStyle(
                                          color: GRAYSCALE_GRAY_03,
                                          fontSize: 11.0))
                                ],
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      FutureBuilder(
                          future: commentFuture,
                          builder: (context,
                              AsyncSnapshot<List<CommentModel>> snapshot) {
                            if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            }
                            List<CommentModel> comments = snapshot.data!;
                            return Column(
                              children: List.generate(
                                comments.length,
                                (index) => Column(
                                  children: [
                                    index > 0
                                        ? const Divider(
                                            height: 24.0,
                                            thickness: 0.0,
                                          )
                                        : Container(),
                                    CommentCard(
                                        likeOrUnlikeComment:
                                            likeOrUnlikeComment,
                                        comment: comments[index],
                                        setParentAndMentionId:
                                            setParentCommentIdAndMentionId)
                                  ],
                                ),
                              ),
                            );
                          })
                    ],
                  )
                ]))
              ]),
              bottomNavigationBar: Container(
                  height: parentCommentId != null ? 56.0 + 32.0 : 56.0),
            ),
            bottomSheet: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                parentCommentId != null
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        color: SECONDARY_COLOR_ORANGE_03,
                        height: 32.0,
                        width: double.infinity,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "대댓글 쓰는 중..",
                                style: TextStyle(
                                    color: GRAYSCALE_GRAY_04,
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () =>
                                    setParentCommentIdAndMentionId(null, null),
                                child: SvgPicture.asset(
                                  "assets/img/post_screen/cross_icon.svg",
                                  height: 11.0,
                                  width: 11.0,
                                ),
                              )
                            ]),
                      )
                    : Container(),
                AnonymousTextfield(
                  handleSubmit: handleCommentSubmit,
                ),
              ],
            ),
          );
        },
      )),
    );
  }
}
