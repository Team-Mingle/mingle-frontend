import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/model/cursor_pagination_model.dart';
import 'package:mingle/post/components/indicator_widget.dart';
import 'package:mingle/post/models/post_model.dart';
import 'package:mingle/post/provider/post_provider.dart';
import 'package:mingle/post/view/post_detail_screen.dart';
import 'package:mingle/second_hand_market/view/second_hand_post_detail_screen.dart';

enum CardType { home, square, lawn }

class GeneralPostPreviewCard extends ConsumerStatefulWidget {
  // final List<Map<String, String>> postList;

  // final Future<List<PostModel>> postFuture;
  String emptyMessage;
  final String boardType;
  final CursorPaginationBase data;
  final CardType cardType;
  final dynamic notifierProvider;
  final dynamic allNotifierProvider;
  final ProviderFamily<PostModel?, int>? postDetailProvider;

  GeneralPostPreviewCard(
      {
      // required this.postList,
      required this.boardType,
      required this.cardType,
      Key? key,
      required this.data,
      this.notifierProvider,
      this.allNotifierProvider,
      this.postDetailProvider,
      this.emptyMessage = "아직 올라온 게시물이 없어요!"
      // required this.postFuture,
      })
      : super(key: key);

  @override
  ConsumerState<GeneralPostPreviewCard> createState() =>
      _GeneralPostPreviewCardState();
}

class _GeneralPostPreviewCardState
    extends ConsumerState<GeneralPostPreviewCard> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    // 현재 위치가 현재 길이보다 조금 덜되는 위치까지 왔다면 새로운 데이터를 추가요청
    if (scrollController.offset >
        scrollController.position.maxScrollExtent - 300) {
      widget.notifierProvider!.paginate(fetchMore: true);
    }
  }

  int getMaxLines() {
    switch (widget.cardType) {
      case CardType.home:
        return 1;
      case CardType.square:
        return 3;
      case CardType.lawn:
        return 3;
    }
  }

  void refreshList() {
    widget.notifierProvider!.paginate(normalRefetch: true);
    widget.allNotifierProvider!.paginate(normalRefetch: true);
  }

  Widget buildDivider(double height) {
    final verticalMargin = widget.cardType == CardType.home ? 10.0 : 8.0;
    final horizontalPadding = (widget.cardType == CardType.home ? 12.0 : 8.0);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: verticalMargin),
        height: height,
        color: GRAYSCALE_GRAY_01,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data is CursorPaginationLoading) {
      return Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(
            color: PRIMARY_COLOR_ORANGE_02,
          ),
        ),
      );
    }

    if (widget.data is CursorPaginationError) {
      CursorPaginationError error = widget.data as CursorPaginationError;
      return CustomScrollView(
          controller: scrollController,
          shrinkWrap: true,
          physics: widget.cardType == CardType.home
              ? const NeverScrollableScrollPhysics()
              : const AlwaysScrollableScrollPhysics(),

          // physics: const NeverScrollableScrollPhysics(),
          slivers: [
            CupertinoSliverRefreshControl(
              onRefresh: () async {
                await Future.delayed(const Duration(milliseconds: 1000), () {
                  print("refreshing");
                  widget.notifierProvider!.paginate(normalRefetch: true);
                });
                // await widget.notifierProvider!.paginate(forceRefetch: true);
              },
            ),
            const SliverFillRemaining(
              child: Center(
                child: Text('데이터를 가져오는데 실패했습니다'),
              ),
            )
          ]);
    }

    final postList = widget.data as CursorPagination;
    print("포스트 길이: ${postList.data.length} ${postList.data}");
    return CupertinoTheme(
      data: const CupertinoThemeData(
          primaryColor: PRIMARY_COLOR_ORANGE_02, applyThemeToAll: true),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: widget.cardType == CardType.home
                ? [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ]
                : [],
          ),
          child: CustomScrollView(
              controller: scrollController,
              shrinkWrap: true,
              physics: widget.cardType == CardType.home
                  ? const NeverScrollableScrollPhysics()
                  : const AlwaysScrollableScrollPhysics(),

              // physics: const NeverScrollableScrollPhysics(),
              slivers: [
                CupertinoSliverRefreshControl(
                  onRefresh: () async {
                    await Future.delayed(
                        const Duration(milliseconds: 1000),
                        () => widget.notifierProvider!
                            .paginate(normalRefetch: true));
                    // await widget.notifierProvider!.paginate(forceRefetch: true);
                  },
                ),
                postList.data.isEmpty
                    ? widget.cardType == CardType.home
                        ? SliverList(
                            delegate: SliverChildListDelegate([
                            SizedBox(
                              height: 70.0,
                              child: Center(
                                child: Text(widget.emptyMessage),
                              ),
                            )
                          ]))
                        : SliverFillRemaining(
                            child: Center(
                              child: Text(widget.emptyMessage),
                            ),
                          )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: postList.data.length + 1,
                          // ListView.builder(
                          // controller: scrollController,
                          // shrinkWrap: true,
                          // physics: const AlwaysScrollableScrollPhysics(),
                          // // physics: const NeverScrollableScrollPhysics(),
                          // itemCount: postList.data.length + 1,
                          (context, index) {
                            if (index == postList.data.length) {
                              return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  child: Center(
                                      child: postList
                                              is CursorPaginationFetchingMore
                                          ? const CircularProgressIndicator(
                                              color: PRIMARY_COLOR_ORANGE_02,
                                            )
                                          : Container())
                                  // const Text('마지막 데이터입니다 ㅠㅠ')),
                                  );
                            }
                            final post = postList.data[index];

                            return Column(
                              children: [
                                // 첫번째 줄에만 padding
                                if (index == 0)
                                  SizedBox(
                                    height: (() {
                                      switch (widget.cardType) {
                                        // case CardType.home:
                                        //   return 20.0;

                                        default:
                                          return 16.0;
                                      }
                                    })(),
                                  ),
                                InkWell(
                                  onTap: () {
                                    print('Item $index tapped');

                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => PostDetailScreen(
                                          boardType: widget.boardType,
                                          allNotifierProvider:
                                              widget.allNotifierProvider,
                                          postId: post.postId,
                                          refreshList: refreshList,
                                          postDetailProvider:
                                              widget.postDetailProvider,
                                          notifierProvider:
                                              widget.notifierProvider,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start, // 사진 위쪽 정렬
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  buildTypeIndicator(
                                                      post.categoryType),
                                                  Expanded(
                                                    child: Text(
                                                      post.title,
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            "Pretendard",
                                                        fontSize: 14.0,
                                                        letterSpacing: -0.01,
                                                        height: 1.4,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            GRAYSCALE_BLACK_GRAY,
                                                      ),
                                                      textAlign: TextAlign.left,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  if (post is PostModel &&
                                                      post.fileAttached)
                                                    SvgPicture.asset(
                                                        "assets/img/post_screen/has_picture_icon.svg"),
                                                ],
                                              ),
                                              SizedBox(
                                                height:
                                                    post.categoryType == "FREE"
                                                        ? 6.0
                                                        : 2.0,
                                              ),
                                              Text(
                                                post.content,
                                                style: const TextStyle(
                                                  fontFamily: "Pretendard",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: GRAYSCALE_GRAY_05,
                                                ),
                                                textAlign: TextAlign.left,
                                                maxLines: getMaxLines(),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                height: 6.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      buildRoleIndicator(
                                                        post.nickname,
                                                        post.memberRole,
                                                        11,
                                                      ),
                                                      const SizedBox(
                                                          width: 4.0),
                                                      SvgPicture.asset(
                                                        'assets/img/common/ic_dot.svg',
                                                        width: 2,
                                                        height: 2,
                                                      ),
                                                      const SizedBox(
                                                          width: 4.0),
                                                      Text(
                                                        PostModel
                                                            .convertUTCtoLocalPreview(
                                                                post.createdAt),
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              "Pretendard",
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              GRAYSCALE_GREY_ORANGE,
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/img/common/ic_like.svg',
                                                        width: 16,
                                                        height: 16,
                                                      ),
                                                      Text(
                                                        post.likeCount
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              "Pretendard",
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              GRAYSCALE_GRAY_ORANGE_02,
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      SvgPicture.asset(
                                                        'assets/img/common/ic_comment.svg',
                                                        width: 16,
                                                        height: 16,
                                                      ),
                                                      Text(
                                                        post.commentCount
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              "Pretendard",
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              GRAYSCALE_GRAY_ORANGE_02,
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                if (index != postList.data.length - 1)
                                  buildDivider(1.0),
                              ],
                            );
                          },
                        ),
                      ),
                // ),
              ])),
    );
  }
}
