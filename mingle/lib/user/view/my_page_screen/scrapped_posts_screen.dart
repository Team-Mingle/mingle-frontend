import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/component/general_post_preview_card.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/post/provider/post_provider.dart';
import 'package:mingle/user/provider/member_provider.dart';

class ScrappedPostsScreen extends ConsumerStatefulWidget {
  const ScrappedPostsScreen({super.key});

  @override
  ConsumerState<ScrappedPostsScreen> createState() =>
      _ScrappedPostsScreenState();
}

class _ScrappedPostsScreenState extends ConsumerState<ScrappedPostsScreen>
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
            "스크랩한 글",
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
          const Divider(
            height: 1.0,
            color: GRAYSCALE_GRAY_02,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                GeneralPostPreviewCard(
                  data: ref.watch(totalScrappedPostProvider),
                  // postFuture: paginatePost("FREE", ref),
                  notifierProvider:
                      ref.watch(totalScrappedPostProvider.notifier),
                  allNotifierProvider:
                      ref.watch(totalScrappedPostProvider.notifier),
                  postDetailProvider: totalScrappedPostDetailProvider,
                  cardType: CardType.square,
                ),
                GeneralPostPreviewCard(
                  data: ref.watch(univScrappedPostProvider),
                  // postFuture: paginatePost("FREE", ref),
                  notifierProvider:
                      ref.watch(univScrappedPostProvider.notifier),
                  allNotifierProvider:
                      ref.watch(univScrappedPostProvider.notifier),
                  postDetailProvider: univScrappedPostDetailProvider,
                  cardType: CardType.square,
                ),
              ],
            ),
          ),
        ]));
  }
}
