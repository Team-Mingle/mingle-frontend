import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/component/item_post_preview_card.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/model/cursor_pagination_model.dart';
import 'package:mingle/second_hand_market/model/second_hand_market_post_model.dart';
import 'package:mingle/second_hand_market/repository/second_hand_market_post_repository.dart';

class SecondHandMarketSearchScreen extends ConsumerStatefulWidget {
  const SecondHandMarketSearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<SecondHandMarketSearchScreen> createState() =>
      _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SecondHandMarketSearchScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;
  Future<CursorPagination<SecondHandMarketPostModel>>? searchFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // TabController 초기화
  }

  @override
  void dispose() {
    _tabController.dispose(); // TabController 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: GRAYSCALE_GRAY_01,
          titleSpacing: 0,
          leading: Container(
            margin: const EdgeInsets.only(
                left: 6.0, top: 4.0, bottom: 4.0, right: 0.0),
            child: IconButton(
              icon: Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/img/home_screen/ic_search_back.svg',
                  width: 24,
                  height: 24,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
            child: Container(
              decoration: BoxDecoration(
                color: GRAYSCALE_GRAY_01_5,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: TextField(
                  onEditingComplete: () {
                    setState(() {
                      searchFuture = ref
                          .watch(secondHandPostRepositoryProvider)
                          .search(keyword: _searchController.text);
                    });
                  },
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: '검색어를 입력하세요 왤케 아래에 있지...',
                    hintStyle: TextStyle(
                      color: GRAYSCALE_GRAY_03,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(
                  left: 0.0, top: 4.0, bottom: 4.0, right: 7.0),
              child: IconButton(
                icon: Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/img/home_screen/ic_search_delete.svg',
                    width: 24,
                    height: 24,
                  ),
                ),
                onPressed: () {
                  _searchController.clear();
                },
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: GRAYSCALE_GRAY_01,
        child: Column(
          children: [
            const SizedBox(
              height: 12.0,
            ),
            // PreferredSize(
            //   preferredSize: const Size.fromHeight(40.0),
            //   child: Align(
            //     alignment: Alignment.centerLeft,
            //     child: SizedBox(
            //       width: MediaQuery.of(context).size.width / 2,
            //       child: TabBar(
            //         indicatorColor: Colors.orange,
            //         labelColor: Colors.black,
            //         unselectedLabelColor: Colors.black,
            //         controller: _tabController,
            //         tabs: const [
            //           Tab(text: '광장'),
            //           Tab(text: '잔디밭'),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            Expanded(
              child: searchFuture == null
                  ? const Center(child: Text('탭 1 콘텐츠'))
                  : FutureBuilder(
                      future: searchFuture,
                      builder: (context,
                          AsyncSnapshot<
                                  CursorPagination<SecondHandMarketPostModel>>
                              snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        CursorPagination<SecondHandMarketPostModel> postList =
                            snapshot.data!;
                        return ItemPostPreviewCard(
                          // postList: dummyPostList,
                          data: postList,
                          // postFuture: paginatePost("MINGLE", ref),

                          cardType: CardType.market,
                        );
                      }),
            ),
          ],
        ),
      ),
    );
  }
}
