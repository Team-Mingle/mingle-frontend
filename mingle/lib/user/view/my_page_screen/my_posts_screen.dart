import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/component/general_post_preview_card.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/post/provider/post_provider.dart';
import 'package:mingle/user/provider/member_provider.dart';

class MyPostsScreen extends ConsumerStatefulWidget {
  const MyPostsScreen({super.key});

  @override
  ConsumerState<MyPostsScreen> createState() => _MyPostsScreenState();
}

class _MyPostsScreenState extends ConsumerState<MyPostsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // TabController 초기화
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const ImageIcon(
              AssetImage("assets/img/signup_screen/previous_screen_icon.png"),
              color: GRAYSCALE_BLACK,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            "내가 작성한 글",
            style: TextStyle(
                fontSize: 16.0,
                letterSpacing: -0.02,
                height: 1.5,
                fontWeight: FontWeight.w400,
                color: Colors.black),
          ),
        ),
        body: Column(children: [
          Stack(
            children: [
              const Column(
                children: [
                  SizedBox(
                    height: 46,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Divider(
                      height: 2.0,
                      color: GRAYSCALE_GRAY_02,
                    ),
                  ),
                ],
              ),
              PreferredSize(
                preferredSize: const Size.fromHeight(40.0),
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 80 * 2.0,
                    child: TabBar(
                      indicatorColor: PRIMARY_COLOR_ORANGE_01,
                      indicatorWeight: 2,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.black,
                      controller: _tabController,
                      tabs: const [
                        Tab(text: '광장'),
                        Tab(text: '잔디밭'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                GeneralPostPreviewCard(
                  boardType: "광장",
                  emptyMessage: "내가 작성한 게시물이 없어요!",

                  data: ref.watch(totalMyPostProvider),
                  // postFuture: paginatePost("FREE", ref),
                  notifierProvider: ref.watch(totalMyPostProvider.notifier),
                  allNotifierProvider: ref.watch(totalMyPostProvider.notifier),
                  postDetailProvider: totalMyPostDetailProvider,
                  cardType: CardType.square,
                ),
                GeneralPostPreviewCard(
                  boardType: "잔디밭",
                  emptyMessage: "내가 작성한 게시물이 없어요!",

                  data: ref.watch(univMyPostProvider),
                  // postFuture: paginatePost("FREE", ref),
                  notifierProvider: ref.watch(univMyPostProvider.notifier),
                  allNotifierProvider: ref.watch(univMyPostProvider.notifier),
                  postDetailProvider: univMyPostDetailProvider,
                  cardType: CardType.square,
                ),
              ],
            ),
          ),
        ]));
  }
}
