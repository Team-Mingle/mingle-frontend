import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mingle/common/component/anonymous_textfield.dart';
import 'package:mingle/common/component/report_modal.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/view/image_detail_screen.dart';
import 'package:mingle/post/components/comment_card.dart';
import 'package:mingle/post/models/comment_model.dart';
import 'package:mingle/post/models/post_model.dart';
import 'package:mingle/second_hand_market/components/second_hand_market_post_like_and_comment_numbers_card.dart';
import 'package:mingle/second_hand_market/model/second_hand_market_post_comment_model.dart';
import 'package:mingle/second_hand_market/model/second_hand_market_post_detail_model.dart';
import 'package:mingle/second_hand_market/model/second_hand_market_post_model.dart';
import 'package:mingle/second_hand_market/provider/second_hand_market_post_provider.dart';
import 'package:mingle/second_hand_market/repository/second_hand_market_post_repository.dart';
import 'package:mingle/user/provider/member_provider.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';
import 'package:url_launcher/url_launcher.dart';

class SecondHandPostDetailScreen extends ConsumerStatefulWidget {
  final int itemId;
  final Function refreshList;
  final ProviderFamily<SecondHandMarketPostModel?, int>? postDetailProvider;
  final SecondHandPostStateNotifier? notifierProvider;
  const SecondHandPostDetailScreen({
    super.key,
    required this.itemId,
    required this.refreshList,
    this.postDetailProvider,
    this.notifierProvider,
  });

  @override
  ConsumerState<SecondHandPostDetailScreen> createState() =>
      _SecondHandPostDetailScreenState();
}

class _SecondHandPostDetailScreenState
    extends ConsumerState<SecondHandPostDetailScreen> {
  // List imageList = [
  //   "https://cdn.pixabay.com/photo/2014/04/14/20/11/pink-324175_1280.jpg",
  //   "https://cdn.pixabay.com/photo/2014/02/27/16/10/flowers-276014_1280.jpg",
  //   "https://cdn.pixabay.com/photo/2012/03/01/00/55/flowers-19830_1280.jpg",
  //   "https://cdn.pixabay.com/photo/2015/06/19/20/13/sunset-815270_1280.jpg",
  //   "https://cdn.pixabay.com/photo/2016/01/08/05/24/sunflower-1127174_1280.jpg",
  // ];
  int _current = 0;
  bool _isReserved = false;
  final bool _isLiked = false;
  final CarouselController _controller = CarouselController();
  final EdgeInsets _contentPadding =
      const EdgeInsets.symmetric(horizontal: 20.0);
  final Divider _contentDivider = const Divider(
    height: 32.0,
    thickness: 0.0,
    color: GRAYSCALE_GRAY_01,
  );
  List<CommentModel>? comments;
  int? parentCommentId;
  int? mentionId;
  late Future<SecondHandMarketPostDetailModel> postFuture;
  String selectedOption = "";
  final ScrollController scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    if (widget.notifierProvider != null) {
      widget.notifierProvider!.getDetail(itemId: widget.itemId);
    }
    getComments().then((data) {
      setState(() {
        comments = data;
      });
    });
  }

  getComments() async {
    return ref
        .read(secondHandPostRepositoryProvider)
        .getSecondHandMarketPostComments(itemId: widget.itemId);
  }

  void setParentCommentIdAndMentionId(int? parentId, int? mentId) {
    setState(() {
      parentCommentId = parentId;
      mentionId = mentId;
    });
    focusNode.requestFocus();
  }

  void handleCommentSubmit(String comment, bool isAnonymous) async {
    AddSecondHandMarketCommentModel addCommentModel =
        AddSecondHandMarketCommentModel(
            itemId: widget.itemId,
            parentCommentId: parentCommentId,
            mentionId: mentionId,
            content: comment,
            isAnonymous: isAnonymous);

    final commentRepository = ref.watch(secondHandPostRepositoryProvider);
    await commentRepository.addSecondHandMarketPostComment(
        itemId: widget.itemId, commentModel: addCommentModel);
    refreshComments();
  }

  void refreshComments() {
    getComments().then((data) {
      setState(() {
        comments = data;
      });
    });
    if (widget.notifierProvider != null) {
      widget.notifierProvider!.getDetail(itemId: widget.itemId);
    }
  }

  void refreshPost() async {
    if (widget.notifierProvider != null) {
      widget.notifierProvider!.getDetail(itemId: widget.itemId);
    } else {
      setState(() {
        postFuture = ref
            .watch(secondHandPostRepositoryProvider)
            .getSecondHandMarketPostDetail(itemId: widget.itemId);
      });
    }

    // widget.refreshList();
  }

  void changeStatus(String status) async {
    String actualStatus = "";
    switch (status) {
      case "판매중":
        actualStatus = "SELLING";
      case "예약중":
        actualStatus = "RESERVED";
      case "판매완료":
        actualStatus = "SOLDOUT";
      default:
        actualStatus = "";
    }
    await ref
        .watch(secondHandPostRepositoryProvider)
        .editItemStatus(itemId: widget.itemId, itemStatusType: actualStatus);
    refreshPost();
    // await ref
    //     .watch(likedSellingSecondHandPostProvider.notifier)
    //     .paginate(normalRefetch: true);
    // await ref
    //     .watch(likedReservedSecondHandPostProvider.notifier)
    //     .paginate(normalRefetch: true);
    // await ref
    //     .watch(likedSoldoutSecondHandPostProvider.notifier)
    //     .paginate(normalRefetch: true);
    // await ref
    //     .watch(mySellingSecondHandPostProvider.notifier)
    //     .paginate(normalRefetch: true);
    // await ref
    //     .watch(myReservedSecondHandPostProvider.notifier)
    //     .paginate(normalRefetch: true);
    // await ref
    //     .watch(mySoldoutSecondHandPostProvider.notifier)
    //     .paginate(normalRefetch: true);
  }

  void likeOrUnlikePost() async {
    final resp = await ref
        .watch(secondHandPostRepositoryProvider)
        .likeSecondHandMarketPost(itemId: widget.itemId);

    if (widget.notifierProvider != null) {
      widget.notifierProvider!.getDetail(itemId: widget.itemId);
    }
  }

  void likeOrUnlikeComment(int commentId) async {
    final resp = await ref
        .watch(secondHandPostRepositoryProvider)
        .likeSecondHandMarketPostComment(commentId: commentId);
  }

  void deletePost() async {
    Navigator.of(context).pop();
    if (widget.notifierProvider != null) {
      widget.notifierProvider!.deletePost(postId: widget.itemId);
    }

    final resp = ref
        .watch(secondHandPostRepositoryProvider)
        .deleteSecondHandMarketPost(itemId: widget.itemId);

    // widget.refreshList();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.postDetailProvider == null) {
      return FutureBuilder(
        future: ref
            .watch(secondHandPostRepositoryProvider)
            .getSecondHandMarketPostDetail(itemId: widget.itemId),
        // postDetailFuture(postId),
        builder:
            (context, AsyncSnapshot<SecondHandMarketPostDetailModel> snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text("다시 시도 ㄱㄱ"),
              ),
            );
          }
          SecondHandMarketPostDetailModel item = snapshot.data!;

          // setState(() {
          //   selectedOption = item.status;
          // });
          return Scaffold(body: renderContent(item));
        },
      );
    }

    final item = ref.watch(widget.postDetailProvider!(widget.itemId));

    if (item == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    // setState(() {
    //   selectedOption = item.status;
    // });

    return Scaffold(body: renderContent(item));
  }

  Widget renderContent(SecondHandMarketPostModel item) {
    String selectedOption = item.status;
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: Colors.white,
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
              title: const Text(
                "장터",
                style: TextStyle(
                    fontSize: 14.0,
                    letterSpacing: -0.01,
                    height: 1.4,
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
                        actions: item is SecondHandMarketPostDetailModel &&
                                item.isMyPost
                            ? <CupertinoActionSheetAction>[
                                CupertinoActionSheetAction(
                                  onPressed: () {
                                    deletePost();
                                    Navigator.pop(context);
                                  },
                                  isDestructiveAction: true,
                                  child: const Text('삭제하기'),
                                ),
                                CupertinoActionSheetAction(
                                    onPressed: () {
                                      Navigator.of(context).pop();

                                      showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          // 기본 선택 항목

                                          return Container(
                                            height: 248,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0),
                                              child: Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 32.0,
                                                  ),
                                                  ListTile(
                                                    title: Center(
                                                      child: Text(
                                                        '판매중',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              selectedOption ==
                                                                      '판매중'
                                                                  ? FontWeight
                                                                      .bold
                                                                  : FontWeight
                                                                      .normal,
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                      setState(() {
                                                        selectedOption = '판매중';
                                                        _isReserved = false;
                                                      }); // 선택한 항목 설정
                                                      changeStatus(
                                                          selectedOption);
                                                      print("판매중");
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 20.0,
                                                  ),
                                                  ListTile(
                                                    title: Center(
                                                      child: Text(
                                                        '예약중',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              selectedOption ==
                                                                      '예약중'
                                                                  ? FontWeight
                                                                      .bold
                                                                  : FontWeight
                                                                      .normal,
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                      setState(() {
                                                        selectedOption = '예약중';
                                                        _isReserved = true;
                                                      }); // 선택한 항목 설정
                                                      changeStatus(
                                                          selectedOption);
                                                      print("예약중");
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 20.0,
                                                  ),
                                                  ListTile(
                                                    title: Center(
                                                      child: Text(
                                                        '판매완료',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              selectedOption ==
                                                                      '판매완료'
                                                                  ? FontWeight
                                                                      .bold
                                                                  : FontWeight
                                                                      .normal,
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                      setState(() {
                                                        selectedOption = '판매완료';
                                                        _isReserved = false;
                                                      }); // 선택한 항목 설정
                                                      changeStatus(
                                                          selectedOption);
                                                      print("판매완료");
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        backgroundColor: Colors.transparent,
                                      );
                                    },
                                    child: const Text("판매상태 변경하기"))
                              ]
                            : <CupertinoActionSheetAction>[
                                reportModal(
                                    "ITEM", item.id, context, ref, fToast)
                                // CupertinoActionSheetAction(
                                //   onPressed: () {
                                //     Navigator.pop(context);
                                //   },
                                //   isDestructiveAction: true,
                                //   child: const Text('신고하기'),
                                // ),
                              ]),
                  ),
                  child: SvgPicture.asset(
                      "assets/img/post_screen/triple_dot_icon.svg"),
                ),
                const SizedBox(
                  width: 18.0,
                ),
                const SizedBox(
                  width: 18.0,
                )
              ],
            ),
            body: CustomScrollView(controller: scrollController, slivers: [
              SliverList(
                  delegate: SliverChildListDelegate([
                Padding(
                  padding: _contentPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 8.0,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 320.0,
                        child: Stack(
                          children: [
                            sliderWidget(item),
                            sliderIndicator(item),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Text(
                        item.title,
                        style: const TextStyle(
                            fontSize: 20.0,
                            letterSpacing: -0.03,
                            height: 1.5,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        "${item.price.toString()} ${item.currency}",
                        style: const TextStyle(
                            fontSize: 16.0,
                            letterSpacing: -0.02,
                            height: 1.5,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                _contentDivider,
                Padding(
                  padding: _contentPadding,
                  child: Text(item.content),
                ),
                _contentDivider,
                Padding(
                  padding: _contentPadding,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "희망 거래장소/시간대",
                          style: TextStyle(
                              color: GRAYSCALE_GRAY_03,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        Text(item.location)
                      ]),
                ),
                _contentDivider,
                Padding(
                  padding: _contentPadding.copyWith(bottom: 8.0),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "오픈채팅방 링크",
                          style: TextStyle(
                              color: GRAYSCALE_GRAY_03,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        Expanded(
                          child: InkWell(
                              onTap: () async {
                                final Uri url = Uri.parse(item.chatUrl);

                                if (!await launchUrl(url)) {
                                  throw Exception('Could not launch $url');
                                }
                              },
                              child: Text(
                                item.chatUrl,
                                style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    overflow: TextOverflow.ellipsis),
                              )),
                        )
                      ]),
                ),
                const Divider(
                  height: 16.0,
                  thickness: 0.0,
                ),
                Padding(
                  padding: _contentPadding.copyWith(bottom: 8.0),
                  child: Row(
                    children: [
                      Text(
                        item.nickname,
                        style: const TextStyle(
                            color: GRAYSCALE_GRAY_04, fontSize: 12.0),
                      ),
                      const SizedBox(
                        width: 4.0,
                      ),
                      const Text(
                        "•",
                        style:
                            TextStyle(color: GRAYSCALE_GRAY_02, fontSize: 12.0),
                      ),
                      const SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        PostModel.convertUTCtoLocal(item.createdAt),
                        style: const TextStyle(
                            color: GRAYSCALE_GRAY_03, fontSize: 12.0),
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      const Text(
                        "조회",
                        style:
                            TextStyle(color: GRAYSCALE_GRAY_03, fontSize: 12.0),
                      ),
                      const SizedBox(
                        width: 2.0,
                      ),
                      Text(
                        item is SecondHandMarketPostDetailModel
                            ? item.viewCount.toString()
                            : "",
                        style: const TextStyle(
                            color: GRAYSCALE_GRAY_03, fontSize: 12.0),
                      )
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
                    SecondHandMarketPostLikeAndCommentNumbersCard(
                        post: item, likeOrUnlikePost: likeOrUnlikePost),
                    const Divider(
                      height: 0.0,
                      thickness: 2.0,
                      color: GRAYSCALE_GRAY_01,
                    ),
                    Container(
                      color: GRAYSCALE_GRAY_01_5,
                      // height: 56.0,
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
                                      color: GRAYSCALE_GRAY_03, fontSize: 11.0),
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
                                      color: GRAYSCALE_GRAY_03, fontSize: 11.0),
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
                    comments == null
                        ? const CircularProgressIndicator()
                        : Column(children: [
                            ...List.generate(
                              comments!.length,
                              (index) => Column(
                                children: [
                                  index > 0
                                      ? const Divider(
                                          height: 24.0,
                                          thickness: 0.0,
                                        )
                                      : Container(),
                                  CommentCard(
                                      refreshComments: refreshComments,
                                      likeOrUnlikeComment: likeOrUnlikeComment,
                                      comment: comments![index],
                                      setParentAndMentionId:
                                          setParentCommentIdAndMentionId)
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            )
                          ])
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
            ),
          ],
        ),
      ),
    );
  }

  Widget sliderWidget(SecondHandMarketPostModel item) {
    // print("img length = ${item.itemImgList.length}");
    // print("rebuilding");
    // print(_current);
    return CarouselSlider(
      carouselController: _controller,
      items: item.itemImgList.map(
        (imgLink) {
          return Builder(
            builder: (context) {
              return Stack(children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 320.0,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(8.0), // 여기서 borderRadius를 설정합니다.
                    child: Hero(
                      tag: imgLink,
                      child: Image(
                        fit: BoxFit.contain,
                        image: NetworkImage(
                          imgLink,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
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
                            images: item.itemImgList
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

                  // () {
                  //   setState(() {
                  //     _isReserved = !_isReserved;
                  //   });
                  // },
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(8.0), // 여기서 borderRadius를 설정합니다.
                    child: Container(
                      color: item.status == "예약중" || item.status == "판매완료"
                          ? Colors.black.withOpacity(0.6)
                          : Colors.transparent,
                      child: Center(
                        child: Text(
                          item.status == "예약중"
                              ? "예약중"
                              : item.status == "판매완료"
                                  ? "판매완료"
                                  : "",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              letterSpacing: -0.03,
                              height: 1.5,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                )
              ]);
            },
          );
        },
      ).toList(),
      options: CarouselOptions(
        enableInfiniteScroll: false,
        height: 320,
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
  Widget sliderIndicator(SecondHandMarketPostModel item) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: item.itemImgList.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: _current == entry.key ? 24.0 : 6.0, // 선택된 인디케이터는 가로로 길게
              height: 6,
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle, // BoxShape을 rectangle로 변경
                borderRadius: BorderRadius.circular(3.0),
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
}
