import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/component/general_post_preview_card.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/post/provider/post_provider.dart';
import 'package:mingle/user/provider/member_provider.dart';

class LikedPostsScreen extends ConsumerStatefulWidget {
  const LikedPostsScreen({super.key});

  @override
  ConsumerState<LikedPostsScreen> createState() => _LikedPostsScreenState();
}

class _LikedPostsScreenState extends ConsumerState<LikedPostsScreen>
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
            "좋아요 누른 글",
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                color: Colors.black),
          ),
        ),
        body: Column(children: [
          PreferredSize(
            preferredSize: const Size.fromHeight(40.0),
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 80 * 2.0,
                child: TabBar(
                  indicatorColor: Colors.orange,
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
          const Divider(
            height: 1.0,
            color: GRAYSCALE_GRAY_02,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                GeneralPostPreviewCard(
                  emptyMessage: "아직 좋아요 누른 게시물이 없어요!",
                  data: ref.watch(totalLikedPostProvider),
                  // postFuture: paginatePost("FREE", ref),
                  notifierProvider: ref.watch(totalLikedPostProvider.notifier),
                  allNotifierProvider:
                      ref.watch(totalLikedPostProvider.notifier),
                  postDetailProvider: totalLikedPostDetailProvider,
                  cardType: CardType.square,
                ),
                GeneralPostPreviewCard(
                  emptyMessage: "아직 좋아요 누른 게시물이 없어요!",
                  data: ref.watch(univLikedPostProvider),
                  // postFuture: paginatePost("FREE", ref),
                  notifierProvider: ref.watch(univLikedPostProvider.notifier),
                  allNotifierProvider:
                      ref.watch(univLikedPostProvider.notifier),
                  postDetailProvider: univLikedPostDetailProvider,
                  cardType: CardType.square,
                ),
              ],
            ),
          ),
        ]));
  }
}
