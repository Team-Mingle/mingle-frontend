import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/model/cursor_pagination_model.dart';
import 'package:mingle/post/models/post_model.dart';
import 'package:mingle/post/provider/post_provider.dart';
import 'package:mingle/post/view/post_detail_screen.dart';
import 'package:mingle/second_hand_market/model/second_hand_market_post_model.dart';
import 'package:mingle/second_hand_market/provider/second_hand_market_post_provider.dart';
import 'package:mingle/second_hand_market/view/second_hand_post_detail_screen.dart';

enum CardType { home, square, lawn, market, selling }

class ItemPostPreviewCard extends ConsumerStatefulWidget {
  // final List<Map<String, String>> postList;

  // final Future<List<PostModel>> postFuture;
  String emptyMessage;
  final CursorPaginationBase data;
  final CardType cardType;
  final SecondHandPostStateNotifier? notifierProvider;
  final ProviderFamily<SecondHandMarketPostModel?, int>? postDetailProvider;

  ItemPostPreviewCard({
    // required this.postList,
    required this.cardType,
    Key? key,
    required this.data,
    this.notifierProvider,
    this.postDetailProvider,
    this.emptyMessage = "아직 올라온 상품이 없어요!",
    // required this.postFuture,
  }) : super(key: key);

  @override
  ConsumerState<ItemPostPreviewCard> createState() =>
      _GeneralPostPreviewCardState();
}

class _GeneralPostPreviewCardState extends ConsumerState<ItemPostPreviewCard> {
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
      case CardType.market:
        return 1;
      case CardType.selling:
        return 1;
    }
  }

  void refreshList() {
    widget.notifierProvider!.paginate();
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
      return const Center(
        child: CircularProgressIndicator(
          color: PRIMARY_COLOR_ORANGE_02,
        ),
      );
    }

    if (widget.data is CursorPaginationError) {
      CursorPaginationError error = widget.data as CursorPaginationError;
      return Center(
        child: Text(error.message),
      );
    }

    final postList = widget.data as CursorPagination;
    print(postList.data.length);

    return CupertinoTheme(
      data: const CupertinoThemeData(
          primaryColor: PRIMARY_COLOR_ORANGE_02, applyThemeToAll: true),
      child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
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
                            .paginate(forceRefetch: true));
                    // await widget.notifierProvider!.paginate(forceRefetch: true);
                  },
                ),
                postList.data.isEmpty
                    ? SliverFillRemaining(
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
                            SecondHandMarketPostModel post =
                                postList.data[index];

                            return Column(
                              children: [
                                // 첫번째 줄에만 padding
                                if (index == 0)
                                  SizedBox(
                                    height: (() {
                                      switch (widget.cardType) {
                                        case CardType.home:
                                          return 20.0;
                                        case CardType.selling:
                                          return 24.0;
                                        default:
                                          return 16.0;
                                      }
                                    })(),
                                  ),
                                InkWell(
                                  onTap: () {
                                    print('Item $index tapped');
                                    if (widget.cardType == CardType.market ||
                                        widget.cardType == CardType.selling) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              SecondHandPostDetailScreen(
                                                  itemId: post.id,
                                                  refreshList: refreshList,
                                                  postDetailProvider:
                                                      widget.postDetailProvider,
                                                  notifierProvider:
                                                      widget.notifierProvider),
                                        ),
                                      );
                                    } else {
                                      // Navigator.of(context).push(
                                      //   MaterialPageRoute(
                                      //     builder: (_) => const PostDetailScreen(),
                                      //   ),
                                      // );
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start, // 사진 위쪽 정렬
                                      children: [
                                        if (widget.cardType ==
                                                CardType.market ||
                                            widget.cardType == CardType.selling)
                                          Stack(
                                            children: [
                                              Container(
                                                width: 96, // 이미지의 가로 크기 조절
                                                height: 96, // 이미지의 세로 크기 조절
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      post.imgThumbnailUrl,
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(
                                                    8.0), // 여기서 borderRadius를 설정합니다.
                                                child: Container(
                                                  height: 96.0,
                                                  width: 96.0,
                                                  color: (post.status ==
                                                              "예약중" ||
                                                          post.status == "판매완료")
                                                      ? Colors.black
                                                          .withOpacity(0.6)
                                                      : Colors.transparent,
                                                  child: Center(
                                                    child: Text(
                                                      post.status == "예약중"
                                                          ? "예약중"
                                                          : post.status ==
                                                                  "판매완료"
                                                              ? "판매완료"
                                                              : "",
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        if (widget.cardType ==
                                                CardType.market ||
                                            widget.cardType == CardType.selling)
                                          const SizedBox(
                                            width: 16.0,
                                          ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      post.title,
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            "Pretendard",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            GRAYSCALE_BLACK_GRAY,
                                                      ),
                                                      textAlign: TextAlign.left,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  if (widget.cardType ==
                                                          CardType.market ||
                                                      widget.cardType ==
                                                          CardType.selling)
                                                    SvgPicture.asset(
                                                      widget.cardType ==
                                                              CardType.market
                                                          ? (post.isLiked
                                                              ? 'assets/img/second_hand_market_screen/heart_icon_filled.svg'
                                                              : 'assets/img/second_hand_market_screen/heart_icon.svg')
                                                          : widget.cardType ==
                                                                  CardType
                                                                      .selling
                                                              ? 'assets/img/post_screen/triple_dot_icon.svg'
                                                              : '', // 다른 경우에 대한 처리 (비어있는 문자열로 설정)
                                                      width: 20,
                                                      height: 20,
                                                    ),
                                                  const SizedBox(
                                                    width: 4.0,
                                                  )
                                                ],
                                              ),
                                              if (widget.cardType ==
                                                      CardType.market ||
                                                  widget.cardType ==
                                                      CardType.selling)
                                                const SizedBox(height: 6.0),
                                              Text(
                                                widget.cardType ==
                                                        CardType.market
                                                    ? '${post.price ?? ''} ${post.currency ?? ''}'
                                                    : post.content ?? '',
                                                style: const TextStyle(
                                                  fontFamily:
                                                      "Pretendard",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: GRAYSCALE_GRAY_05,
                                                ),
                                                textAlign: TextAlign.left,
                                                maxLines: getMaxLines(),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(
                                                height: (widget.cardType ==
                                                            CardType.market ||
                                                        widget.cardType ==
                                                            CardType.selling)
                                                    ? 43.0
                                                    : 6.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        post.nickname ?? '',
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
                                                        post.createdAt ?? '',
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
                                                        widget.cardType ==
                                                                CardType.market
                                                            ? 'assets/img/second_hand_market_screen/heart_icon.svg'
                                                            : 'assets/img/common/ic_like.svg',
                                                        width: 16,
                                                        height: 16,
                                                      ),
                                                      Text(
                                                        post.likeCount
                                                                .toString() ??
                                                            '',
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
                                                                .toString() ??
                                                            '',
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
                                if (widget.cardType == CardType.selling)
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          String selectedOption =
                                              '판매중'; // 기본 선택 항목

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
                                                      selectedOption =
                                                          '판매중'; // 선택한 항목 설정
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
                                                      selectedOption =
                                                          '예약중'; // 선택한 항목 설정
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
                                                      selectedOption =
                                                          '판매완료'; // 선택한 항목 설정
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
                                    child: const SizedBox(
                                      height: 40.0,
                                      child: Center(
                                        child: Text(
                                          '판매상태 변경',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'Pretendard',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                if (widget.cardType == CardType.selling)
                                  buildDivider(2.0),
                                if (index == postList.data.length - 1)
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                // ),
              ])

          // FutureBuilder(
          //     future: postFuture,
          //     builder: (context, snapshot) {
          //       if (!snapshot.hasData) {
          //         return const Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       }
          //       List<PostModel> postList = snapshot.data!;
          //       return
          //     }),
          ),
    );
  }
}
