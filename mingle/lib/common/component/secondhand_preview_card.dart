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
                child: Card(
                  elevation: 1.5,
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
                          borderRadius: BorderRadius.circular(4),
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
                                fontSize: 14,
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
                border: Border.all(color: const Color(0xffE9E7E7)),
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white),
            child: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "더보기",
                    style: TextStyle(
                      fontFamily: "Pretendard",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: GRAYSCALE_GRAY_04,
                      height: 17 / 14,
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
