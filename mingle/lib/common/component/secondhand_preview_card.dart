import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/model/cursor_pagination_model.dart';
import 'package:mingle/second_hand_market/model/second_hand_market_post_model.dart';
import 'package:mingle/second_hand_market/provider/second_hand_market_post_provider.dart';
import 'package:mingle/second_hand_market/view/second_hand_post_detail_screen.dart';

class SecondhandPreviewCard extends ConsumerStatefulWidget {
  final SecondHandPostStateNotifier? notifierProvider;
  final CursorPaginationBase data;
  final ProviderFamily<SecondHandMarketPostModel?, int>? postDetailProvider;
  final Function()? onMorePressed;

  const SecondhandPreviewCard({
    required this.data,
    this.notifierProvider,
    this.postDetailProvider,
    this.onMorePressed,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<SecondhandPreviewCard> createState() =>
      _SecondhandPreviewCardState();
}

class _SecondhandPreviewCardState extends ConsumerState<SecondhandPreviewCard> {
  void refreshList() {
    widget.notifierProvider!.paginate();
  }

  @override
  Widget build(BuildContext context) {
    // 데이터 로딩 및 에러 처리
    if (widget.data is CursorPaginationLoading) {
      return const Center(
          child: CircularProgressIndicator(color: PRIMARY_COLOR_ORANGE_02));
    }
    if (widget.data is CursorPaginationError) {
      return const Center(child: Text('데이터를 가져오는데 실패했습니다'));
    }

    final postList = widget.data as CursorPagination<SecondHandMarketPostModel>;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: postList.data.take(3).toList().asMap().entries.map((entry) {
            SecondHandMarketPostModel post = entry.value;
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => SecondHandPostDetailScreen(
                      itemId: post.id,
                      refreshList: refreshList,
                      postDetailProvider: widget.postDetailProvider,
                      notifierProvider: widget.notifierProvider),
                ));
              },
              child: SizedBox(
                width: (MediaQuery.of(context).size.width - 32) / 3,
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 2),
                          blurRadius: 6,
                          spreadRadius: 0,
                          color: Color.fromRGBO(0, 0, 0, 0.05)),
                      BoxShadow(
                          offset: Offset(1, 1),
                          blurRadius: 16,
                          spreadRadius: 0,
                          color: Color.fromRGBO(0, 0, 0, 0.04))
                    ],
                  ),
                  child: Card(
                    elevation: 0,
                    surfaceTintColor: Colors.transparent,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 88,
                          decoration: BoxDecoration(
                            //
                            // border: Border.all(),

                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                topRight: Radius.circular(8.0)),
                            image: DecorationImage(
                              image: NetworkImage(post.imgThumbnailUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.title,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  letterSpacing: -0.01,
                                  height: 1.4,
                                  fontWeight: FontWeight.w400,
                                  color: GRAYSCALE_BLACK_GRAY,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '${post.price} ${post.currency}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: GRAYSCALE_GRAY_05,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16.0),
        InkWell(
          onTap: widget.onMorePressed,
          child: Container(
            width: (MediaQuery.of(context).size.width - 32),
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: GRAYSCALE_GRAY_01_5),
              borderRadius: BorderRadius.circular(10.0),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.5),
              //     spreadRadius: 1,
              //     blurRadius: 2,
              //     offset: const Offset(0, 2),
              //   ),
              // ],
              color: Colors.white,
            ),
            child: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "더보기",
                    style: TextStyle(
                      fontFamily: "Pretendard",
                      fontSize: 14.0,
                      letterSpacing: -0.01,
                      height: 1.4,
                      fontWeight: FontWeight.w500,
                      color: GRAYSCALE_GRAY_04,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
