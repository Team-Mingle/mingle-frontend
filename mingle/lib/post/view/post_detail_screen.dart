import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mingle/common/component/anonymous_textfield.dart';
import 'package:mingle/common/component/report_modal.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/view/image_detail_screen.dart';
import 'package:mingle/post/components/comment_card.dart';
import 'package:mingle/post/components/indicator_widget.dart';
import 'package:mingle/post/components/like_and_comment_numbers_card.dart';
import 'package:mingle/post/models/add_comment_model.dart';
import 'package:mingle/post/models/comment_model.dart';
import 'package:mingle/post/models/post_detail_model.dart';
import 'package:mingle/post/models/post_model.dart';
import 'package:mingle/post/provider/post_provider.dart';
import 'package:mingle/post/repository/comment_repository.dart';
import 'package:mingle/post/repository/post_repository.dart';
import 'package:mingle/post/view/edit_post_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

class PostDetailScreen extends ConsumerStatefulWidget {
  final int postId;
  final String? boardType;
  final Function refreshList;
  final ProviderFamily<PostModel?, int>? postDetailProvider;
  final PostStateNotifier? notifierProvider;
  final PostStateNotifier? allNotifierProvider;
  const PostDetailScreen(
      {super.key,
      required this.postId,
      required this.refreshList,
      this.boardType,
      this.postDetailProvider,
      this.notifierProvider,
      this.allNotifierProvider});

  @override
  ConsumerState<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends ConsumerState<PostDetailScreen> {
  int? parentCommentId;
  int? mentionId;
  final ScrollController scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final PostDetailModel fakePost = PostDetailModel(
      postId: 0,
      title: "",
      content: "",
      nickname: "",
      createdAt: "",
      memberRole: "",
      status: "",
      boardType: "",
      categoryType: "",
      likeCount: 0,
      commentCount: 0,
      viewCount: 0,
      scrapCount: 0,
      postImgUrl: [],
      fileAttached: false,
      blinded: false,
      myPost: false,
      liked: false,
      scraped: false,
      reported: false);

  final List<CommentModel> fakeComments = List.generate(
      5,
      (index) => CommentModel(
          commentId: 0,
          nickname: "",
          content: "",
          likeCount: 0,
          createdAt: "a b",
          coCommentsList: [],
          liked: false,
          myComment: false,
          commentFromAuthor: false,
          commentDeleted: false,
          commentReported: false,
          admin: false));
  late Future<List<CommentModel>> commentFuture =
      ref.watch(postRepositoryProvider).getPostcomments(postId: widget.postId);
  late Future<PostDetailModel> postFuture;
  bool isReported = false;

  List<CommentModel>? comments;
  late FToast fToast;
  @override
  void dispose() {
    scrollController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    if (widget.notifierProvider != null) {
      widget.notifierProvider!.getDetail(postId: widget.postId);
    } else {
      // getPost();
    }

    getComments().then((data) {
      setState(() {
        comments = data;
      });
    });
  }

  getComments() async {
    return ref
        .read(postRepositoryProvider)
        .getPostcomments(postId: widget.postId);
  }

  getPost() {
    setState(() {
      postFuture = ref
          .watch(postRepositoryProvider)
          .getPostDetails(postId: widget.postId);
    });
  }

  void setParentCommentIdAndMentionId(int? parentId, int? mentId) {
    setState(() {
      parentCommentId = parentId;
      mentionId = mentId;
    });
    if (parentId != null && mentId != null) focusNode.requestFocus();
  }

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
    final postedComment = await commentRepository.postComment(addCommentModel);
    final postedCommentId = postedComment['commentId'];
    // setState(() {
    //   commentFuture = ref
    //       .watch(postRepositoryProvider)
    //       .getPostcomments(postId: widget.postId);
    // });
    // widget.refreshList();
    await refreshComments();
    await Future.delayed(const Duration(seconds: 1));
    // print(
    //     "context is ${GlobalObjectKey(postedCommentId.toString()).currentContext}");
    // Scrollable.ensureVisible(const GlobalObjectKey("14932").currentContext!);
  }

  refreshComments() async {
    await getComments().then((data) {
      setState(() {
        comments = data;
      });
    });
    if (widget.notifierProvider != null) {
      widget.notifierProvider!.getDetail(postId: widget.postId);
      widget.allNotifierProvider!.getDetail(postId: widget.postId);
    }
  }

  void refreshPost() async {
    print("refreshing this post");
    if (widget.notifierProvider != null) {
      print("getting details");
      setState(() {
        widget.notifierProvider!.getDetail(postId: widget.postId);
        widget.allNotifierProvider!.getDetail(postId: widget.postId);
      });
    } else {
      setState(() {
        // postFuture = ref
        //     .watch(postRepositoryProvider)
        //     .getPostDetails(postId: widget.postId);
      });
    }

    // widget.refreshList();
  }

  void likeOrUnlikePost() async {
    final resp = await ref
        .watch(postRepositoryProvider)
        .likeOrUnlikePost(postId: widget.postId);

    if (widget.notifierProvider != null) {
      widget.notifierProvider!.getDetail(postId: widget.postId);
      widget.allNotifierProvider!.getDetail(postId: widget.postId);
    }
  }

  void likeOrUnlikeComment(int commentId) async {
    final resp = await ref
        .watch(commentRepositoryProvider)
        .likeOrUnlikeComment(commentId: commentId);
    // setState(() {
    //   commentFuture = ref
    //       .watch(postRepositoryProvider)
    //       .getPostcomments(postId: widget.postId);
    // });
  }

  void scrapOrUnscrapPost() async {
    final resp = await ref
        .watch(postRepositoryProvider)
        .scrapOrUnscrapPost(postId: widget.postId);

    if (widget.notifierProvider != null) {
      widget.notifierProvider!.getDetail(postId: widget.postId);
      widget.allNotifierProvider!.getDetail(postId: widget.postId);
    }
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
    Navigator.of(context).pop();
    if (widget.notifierProvider != null) {
      widget.notifierProvider!.deletePost(postId: widget.postId);
    }

    final resp =
        ref.watch(postRepositoryProvider).deletePost(postId: widget.postId);

    // widget.refreshList();
  }

  @override
  Widget build(BuildContext context) {
    // postFuture =
    //     ref.watch(postRepositoryProvider).getPostDetails(postId: widget.postId);

    if (widget.postDetailProvider == null) {
      return FutureBuilder(
        future:
            // postFuture,
            ref
                .watch(postRepositoryProvider)
                .getPostDetails(postId: widget.postId),
        // postDetailFuture(postId),
        builder: (context, AsyncSnapshot<PostDetailModel> snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.transparent,
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
                title: Text(
                  widget.boardType != null ? widget.boardType! : "",
                  style: const TextStyle(
                      fontSize: 14.0,
                      letterSpacing: -0.01,
                      height: 1.4,
                      fontWeight: FontWeight.w400,
                      color: GRAYSCALE_GRAY_03),
                ),
                centerTitle: false,
              ),
              backgroundColor: Colors.white,
              body: const Center(
                child: CircularProgressIndicator(
                  color: PRIMARY_COLOR_ORANGE_01,
                ),
              ),
            );
          }

          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.transparent,
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
                title: Text(
                  widget.boardType != null ? widget.boardType! : "",
                  style: const TextStyle(
                      fontSize: 14.0,
                      letterSpacing: -0.01,
                      height: 1.4,
                      fontWeight: FontWeight.w400,
                      color: GRAYSCALE_GRAY_03),
                ),
                centerTitle: false,
              ),
              backgroundColor: Colors.white,
              body: const Center(child: Text("다시 시도해주세요")),
            );
          }
          PostDetailModel post = snapshot.data!;

          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(child: renderContent(post)),
          );
        },
      );
    }

    final post = ref.watch(widget.postDetailProvider!(widget.postId));

    if (post == null) {
      return const Center(
        child: CircularProgressIndicator(
          color: PRIMARY_COLOR_ORANGE_01,
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: renderContent(post)),
    );
  }

  Widget renderContent(PostModel post) {
    print(PostModel.convertUTCtoLocalPreview(post.createdAt));
    print("post is detail model? ${post is PostDetailModel}");
    bool reported = post is PostDetailModel && post.reported;
    String createdAtLocal = PostModel.convertUTCtoLocal(post.createdAt);
    String createdDate = createdAtLocal.split(" ")[0];
    String createdTime = createdAtLocal.split(" ")[1];
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14.0,
                vertical: 14.0,
              ),
              child: InkWell(
                child: SvgPicture.asset(
                  'assets/img/common/ic_back.svg',
                  width: 12,
                  height: 12,
                ),
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
            titleSpacing: 0,
            title: Text(
              widget.boardType != null ? widget.boardType! : "",
              style: const TextStyle(
                fontSize: 14.0,
                letterSpacing: -0.01,
                height: 1.4,
                fontWeight: FontWeight.w400,
                color: GRAYSCALE_GRAY_03,
              ),
            ),
            centerTitle: false,
            actions: [
              GestureDetector(
                // onTap: () => Scrollable.ensureVisible(
                //     const GlobalObjectKey("14932").currentContext!),
                onTap: post is PostDetailModel
                    ? () => showCupertinoModalPopup<void>(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoActionSheet(
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
                                                isAnonymous:
                                                    post.nickname == "익명",
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
                                    reportModal("POST", post.postId, context,
                                        ref, fToast)
                                    // CupertinoActionSheetAction(
                                    //   onPressed: () {
                                    //     ;
                                    //     Navigator.pop(context);
                                    //   },
                                    //   isDestructiveAction: true,
                                    //   child: const Text('신고하기'),
                                    // )
                                  ],
                          ),
                        )
                    : () {},
                child: SvgPicture.asset(
                    "assets/img/post_screen/triple_dot_icon.svg"),
              ),
              const SizedBox(
                width: 18.0,
              )
            ],
          ),
          body: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: scrollController,
              slivers: [
                CupertinoSliverRefreshControl(
                  onRefresh: () async {
                    await Future.delayed(const Duration(seconds: 1), () {
                      refreshPost();
                      refreshComments();
                    });
                    //   refreshPost();
                    //   refreshComments();
                  },
                ),
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
                        Linkify(
                          onOpen: (link) async {
                            if (!await launchUrl(Uri.parse(link.url))) {
                              fToast.showToast(
                                child: const Text("링크를 열 수 없습니다."),
                                gravity: ToastGravity.CENTER,
                                toastDuration: const Duration(seconds: 2),
                              );
                            }
                          },
                          text: post.content,
                          style: const TextStyle(
                              fontSize: 14.0,
                              letterSpacing: -0.01,
                              height: 1.4,
                              fontWeight: FontWeight.w400),
                          linkStyle: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.blue),
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 16.0,
                            ),
                            if (post is PostDetailModel &&
                                post.postImgUrl.isNotEmpty)
                              renderImg(post.postImgUrl),
                          ],
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Row(
                          children: [
                            buildRoleIndicator(
                              post.nickname,
                              post.memberRole,
                              12,
                            ),
                            // Text(
                            //   post.nickname,
                            //   style: const TextStyle(
                            //       color: GRAYSCALE_GRAY_04, fontSize: 12.0),
                            // ),
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
                      post is PostDetailModel
                          ? LikeAndCommentNumbersCard(
                              post: post,
                              likeOrUnlikePost: likeOrUnlikePost,
                              scrapOrUnscrapPost: scrapOrUnscrapPost)
                          : Skeletonizer(
                              child: LikeAndCommentNumbersCard(
                              post: fakePost,
                              likeOrUnlikePost: () {},
                              scrapOrUnscrapPost: () {},
                            )),

                      const Divider(
                        height: 0.0,
                        thickness: 1.0,
                        color: GRAYSCALE_GRAY_01,
                      ),
                      Container(
                        color: GRAYSCALE_GRAY_01,
                        width: MediaQuery.of(context).size.width,
                        child: const Padding(
                          padding: EdgeInsets.only(
                            left: 10.0,
                            top: 5.0,
                            bottom: 5.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "• 운영규칙을 위반하는 댓글은 삭제될 수 있습니다. \n• 악의적인 글 혹은 댓글은 오른쪽 상단 버튼을 통해 신고가 가능합니다.",
                                style: TextStyle(
                                  fontFamily: "Pretendard",
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: GRAYSCALE_GRAY_03,
                                  // height: 28 / 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      comments == null
                          ? FutureBuilder(
                              future: Future.delayed(
                                  const Duration(milliseconds: 200),
                                  () => Skeletonizer(
                                      ignoreContainers: false,
                                      child: Column(
                                        children: List.generate(
                                            fakeComments.length,
                                            (index) => CommentCard(
                                                refreshComments:
                                                    refreshComments,
                                                comment: fakeComments[index],
                                                setParentAndMentionId: () {},
                                                likeOrUnlikeComment: () {})),
                                      ))),
                              builder: (context, snapshot) {
                                return Container();
                              })
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: comments!.isEmpty || reported
                                  ? [
                                      const Center(
                                          child: Text(
                                        "아직 모인 사람이 없어요.",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: GRAYSCALE_GRAY_02),
                                      ))
                                    ]
                                  : List.generate(
                                      comments!.length,
                                      (index) => Column(
                                        children: [
                                          index > 0
                                              ? const Divider(
                                                  height: 20.0,
                                                  thickness: 0.0,
                                                )
                                              : Container(),
                                          CommentCard(
                                              key: GlobalObjectKey(
                                                  comments![index]
                                                      .commentId
                                                      .toString()),
                                              refreshComments: refreshComments,
                                              likeOrUnlikeComment:
                                                  likeOrUnlikeComment,
                                              comment: comments![index],
                                              setParentAndMentionId:
                                                  setParentCommentIdAndMentionId)
                                        ],
                                      ),
                                    ),
                            ),
                      const SizedBox(
                        height: 12.0,
                      )
                      // FutureBuilder(
                      //     future: commentFuture,
                      //     builder:
                      //         (context, AsyncSnapshot<List<CommentModel>> snapshot) {
                      //       if (!snapshot.hasData) {
                      //   return Skeletonizer(
                      //       ignoreContainers: false,
                      //       child: Column(
                      //         children: List.generate(
                      //             fakeComments.length,
                      //             (index) => CommentCard(
                      //                 comment: fakeComments[index],
                      //                 setParentAndMentionId: () {},
                      //                 likeOrUnlikeComment: () {})),
                      //       ));
                      // }
                      //       List<CommentModel> comments = snapshot.data!;
                      //       return Column(
                      //         children: List.generate(
                      //           comments.length,
                      //           (index) => Column(
                      //             children: [
                      //               index > 0
                      //                   ? const Divider(
                      //                       height: 24.0,
                      //                       thickness: 0.0,
                      //                     )
                      //                   : Container(),
                      //               CommentCard(
                      //                   likeOrUnlikeComment: likeOrUnlikeComment,
                      //                   comment: comments[index],
                      //                   setParentAndMentionId:
                      //                       setParentCommentIdAndMentionId)
                      //             ],
                      //           ),
                      //         ),
                      //       );
                      //     })
                    ],
                  )
                ]))
              ]),
          bottomNavigationBar:
              Container(height: parentCommentId != null ? 56.0 + 32.0 : 56.0),
        ),
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
            scrollController: scrollController,
            focusNode: focusNode,
            isCommentReply: parentCommentId != null && mentionId != null,
          ),
        ],
      ),
    );
  }

  Widget renderImg(List<String> postImgUrl) {
    return SizedBox(
      // height: 280,
      child: Column(
        children: [
          sliderWidget(postImgUrl),
          // const SizedBox(
          //   height: 20.0,
          // ),
          sliderIndicator(postImgUrl)
        ],
      ),
    );
    // SingleChildScrollView(
    //   scrollDirection: Axis.horizontal,
    //   child: Row(
    //     children: List.generate(
    //       postImgUrl.length,
    //       (index) => Row(
    //         children: [
    //           GestureDetector(
    //             onTap: () => Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (_) {
    //                   return ImageDetailScreen(
    //                     images: postImgUrl,
    //                     // controller: CarouselController(),
    //                     onPageChange: () {},
    //                     // Image(
    //                     //   fit: BoxFit.contain,
    //                     //   image: NetworkImage(
    //                     //     postImgUrl[index],
    //                     //   ),
    //                     // ),
    //                   );
    //                 },
    //               ),
    //             ),
    //             child: SizedBox(
    //               height: 130.0,
    //               width: 130.0,
    //               child: ClipRRect(
    //                 borderRadius: BorderRadius.circular(8.0),
    //                 child: Image(
    //                   fit: BoxFit.fill,
    //                   image: NetworkImage(
    //                     postImgUrl[index],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //           SizedBox(
    //             width: index < postImgUrl.length - 1 ? 4.0 : 0.0,
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  Widget sliderWidget(List<String> item) {
    // print("img length = ${item.itemImgList.length}");
    // print("rebuilding");
    // print(_current);
    return CarouselSlider(
      carouselController: _controller,
      items: item.map(
        (imgLink) {
          return Builder(
            builder: (context) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                // height: 300.0,
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        return ImageDetailScreen(
                            onPageChange: (index) => setState(() {
                                  _current = index;
                                  _controller.jumpToPage(index);
                                }),
                            currentIndex: _current,
                            // controller: _controller,
                            images: item
                            // Image(

                            //   fit: BoxFit.fill,
                            //   image: NetworkImage(
                            //     imgLink,
                            //   ),
                            // ),
                            );
                      },
                    ),
                  ),
                  child: Center(
                    child: Hero(
                      tag: imgLink,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image(
                          fit: BoxFit.contain,
                          image: NetworkImage(
                            imgLink,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ).toList(),
      options: CarouselOptions(
        enableInfiniteScroll: false,
        height: 200,
        viewportFraction: 1.0,
        autoPlay: false,
        initialPage: _current,
        onPageChanged: (index, reason) {
          setState(() {
            _current = index;
          });
        },
      ),
    );
  }

  // 위젯 분리 필요
  Widget sliderIndicator(List<String> item) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: item.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: 6.0, // 선택된 인디케이터는 가로로 길게
              height: 6,
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle, // BoxShape을 rectangle로 변경
                // borderRadius: BorderRadius.circular(3.0),
                color: _current == entry.key
                    ? PRIMARY_COLOR_ORANGE_02
                    : GRAYSCALE_GRAY_02,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  //     FutureBuilder(
  //   future: ref
  //       .watch(postRepositoryProvider)
  //       .getPostDetails(postId: widget.postId),
  //   // postDetailFuture(postId),
  //   builder: (context, AsyncSnapshot<PostDetailModel> snapshot) {
  //     if (!snapshot.hasData) {
  //       return const Center(
  //         child: CircularProgressIndicator(),
  //       );
  //     }
  //     if (snapshot.hasError) {
  //       return const Center(
  //         child: Text("다시 시도 ㄱㄱ"),
  //       );
  //     }
  //     PostDetailModel post = snapshot.data!;
  //     print(post.postImgUrl);
  //     String createdDate = post.createdAt.split(" ")[0];
  //     String createdTime = post.createdAt.split(" ")[1];
  //     return
  // )),  }
// }
}
