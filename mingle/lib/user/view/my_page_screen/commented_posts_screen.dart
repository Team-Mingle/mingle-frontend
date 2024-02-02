import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/component/general_post_preview_card.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/post/provider/post_provider.dart';
import 'package:mingle/user/provider/member_provider.dart';

class CommentedPostsScreen extends ConsumerStatefulWidget {
  const CommentedPostsScreen({super.key});

  @override
  ConsumerState<CommentedPostsScreen> createState() =>
      _CommentedPostsScreenState();
}

class _CommentedPostsScreenState extends ConsumerState<CommentedPostsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // TabController 초기화
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
            "내가 댓글 작성한 글",
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
                width: 80 * 3.0,
                child: TabBar(
                  indicatorColor: Colors.orange,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.black,
                  controller: _tabController,
                  tabs: const [
                    Tab(text: '광장'),
                    Tab(text: '잔디밭'),
                    Tab(text: "장터")
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                GeneralPostPreviewCard(
                  data: ref.watch(totalCommentedPostProvider),
                  // postFuture: paginatePost("FREE", ref),
                  notifierProvider:
                      ref.watch(totalCommentedPostProvider.notifier),
                  allNotifierProvider:
                      ref.watch(totalCommentedPostProvider.notifier),
                  postDetailProvider: totalCommentedPostDetailProvider,
                  cardType: CardType.square,
                ),
                GeneralPostPreviewCard(
                  data: ref.watch(univCommentedPostProvider),
                  // postFuture: paginatePost("FREE", ref),
                  notifierProvider:
                      ref.watch(univCommentedPostProvider.notifier),
                  allNotifierProvider:
                      ref.watch(univCommentedPostProvider.notifier),
                  postDetailProvider: univCommentedPostDetailProvider,
                  cardType: CardType.square,
                ),
                GeneralPostPreviewCard(
                  data: ref.watch(itemCommentedPostProvider),
                  // postFuture: paginatePost("FREE", ref),
                  notifierProvider:
                      ref.watch(itemCommentedPostProvider.notifier),
                  allNotifierProvider:
                      ref.watch(itemCommentedPostProvider.notifier),
                  postDetailProvider: itemCommentedPostDetailProvider,
                  cardType: CardType.square,
                ),
              ],
            ),
          ),
        ]));
  }
}
