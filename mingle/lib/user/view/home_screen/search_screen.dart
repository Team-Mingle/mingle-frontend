import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/component/general_post_preview_card.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/model/cursor_pagination_model.dart';
import 'package:mingle/post/models/post_model.dart';
import 'package:mingle/post/provider/post_provider.dart';
import 'package:mingle/post/repository/post_repository.dart';
import 'package:collection/collection.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;
  Future<CursorPagination<PostModel>>? searchFuture;
  StateNotifierProvider<PostStateNotifier, CursorPaginationBase>?
      searchPostProvier;
  ProviderFamily<PostModel?, int>? searchPostDetailProvider;
// final univRecentPostProvider =
//     StateNotifierProvider<PostStateNotifier, CursorPaginationBase>((ref) {
//   final repository = ref.watch(postRepositoryProvider);

//   final notifier = UnivRecentPostStateNotifier(postRepository: repository);

//   return notifier;
// });

// final bestPostDetailProvider = Provider.family<PostModel?, int>((ref, id) {
//   final state = ref.watch(bestPostProvider);

//   if (state is! CursorPagination) {
//     return null;
//   }

//   return state.data.firstWhereOrNull((e) => e.postId == id);
// });

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
    return PopScope(
      canPop: false,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              titleSpacing: 0,
              leading: Container(
                margin: const EdgeInsets.only(
                    left: 6.0, top: 4.0, bottom: 4.0, right: 0.0),
                child: IconButton(
                  icon: Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'assets/img/post_screen/cross_icon.svg',
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
                              .watch(postRepositoryProvider)
                              .search(keyword: _searchController.text);
                          searchPostProvier = StateNotifierProvider<
                              PostStateNotifier, CursorPaginationBase>((ref) {
                            final repository =
                                ref.watch(postRepositoryProvider);

                            final notifier = PostStateNotifier(
                                postRepository: repository,
                                boardType: '',
                                categoryType: '',
                                keyword: _searchController.text);

                            return notifier;
                          });
                          searchPostDetailProvider =
                              Provider.family<PostModel?, int>((ref, id) {
                            final state = ref.watch(searchPostProvier!);

                            if (state is! CursorPagination) {
                              return null;
                            }

                            return state.data
                                .firstWhereOrNull((e) => e.postId == id);
                          });
                        });
                      },
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: '검색어를 입력하세요.',
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
                        height: 13 / 11,
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
          body: searchFuture == null
              ? const Center(child: Text('밍글에 궁금한 것을 물어보세요'))
              : GeneralPostPreviewCard(
                  boardType: "",
                  cardType: CardType.square,
                  data: ref.watch(searchPostProvier!),
                  notifierProvider: ref.watch(searchPostProvier!.notifier),
                  postDetailProvider: searchPostDetailProvider,
                )
          // FutureBuilder(
          //     future: searchFuture,
          //     builder: (context,
          //         AsyncSnapshot<CursorPagination<PostModel>> snapshot) {
          //       if (!snapshot.hasData) {
          //         return const Center(child: CircularProgressIndicator());
          //       }
          //       CursorPagination<PostModel> postList = snapshot.data!;
          //       return GeneralPostPreviewCard(
          //         boardType: "",
          //         // postList: dummyPostList,
          //         data: postList,
          //         // postFuture: paginatePost("MINGLE", ref),

          //         cardType: CardType.square,
          //       );
          //     }),
          // body: Container(
          //   color: Colors.white,
          //   child: Column(
          //     children: [
          //       const SizedBox(
          //         height: 12.0,
          //       ),
          //       PreferredSize(
          //         preferredSize: const Size.fromHeight(40.0),
          //         child: Align(
          //           alignment: Alignment.centerLeft,
          //           child: SizedBox(
          //             width: MediaQuery.of(context).size.width / 2,
          //             child: TabBar(
          //               indicatorColor: Colors.orange,
          //               indicatorWeight: 2,
          //               indicatorSize: TabBarIndicatorSize.tab,
          //               labelColor: Colors.black,
          //               unselectedLabelColor: Colors.black,
          //               controller: _tabController,
          //               tabs: const [
          //                 Tab(text: '광장'),
          //                 Tab(text: '잔디밭'),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //       Expanded(
          //         child: TabBarView(
          //           controller: _tabController,
          //           children: [
          //             searchFuture == null
          //                 ? const Center(child: Text('밍글에 궁금한 것을 물어보세요'))
          //                 : FutureBuilder(
          //                     future: searchFuture,
          //                     builder: (context,
          //                         AsyncSnapshot<CursorPagination<PostModel>>
          //                             snapshot) {
          //                       if (!snapshot.hasData) {
          //                         return const Center(
          //                             child: CircularProgressIndicator());
          //                       }
          //                       CursorPagination<PostModel> postList =
          //                           snapshot.data!;
          //                       return GeneralPostPreviewCard(
          //                         boardType: "",
          //                         // postList: dummyPostList,
          //                         data: postList,
          //                         // postFuture: paginatePost("MINGLE", ref),

          //                         cardType: CardType.square,
          //                       );
          //                     }),
          //             const Center(child: Text('밍글에 궁금한 것을 물어보세요')),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          ),
    );
  }
}
