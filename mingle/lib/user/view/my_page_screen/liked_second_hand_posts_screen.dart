import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/component/item_post_preview_card.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/post/provider/post_provider.dart';
import 'package:mingle/user/provider/member_provider.dart';

class LikedSecondHandPostsScreen extends ConsumerStatefulWidget {
  const LikedSecondHandPostsScreen({super.key});

  @override
  ConsumerState<LikedSecondHandPostsScreen> createState() =>
      _LikedSecondHandPostsScreenState();
}

class _LikedSecondHandPostsScreenState
    extends ConsumerState<LikedSecondHandPostsScreen>
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
          "찜한 내역",
          style: TextStyle(
              fontSize: 16.0,
              letterSpacing: -0.02,
              height: 1.5,
              fontWeight: FontWeight.w400,
              color: Colors.black),
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: PRIMARY_COLOR_ORANGE_01,
              labelColor: Colors.black,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              labelStyle: TextStyle(
                fontSize: 14.0,
                letterSpacing: -0.01,
                height: 1.4,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelColor: GRAYSCALE_GRAY_04,
              unselectedLabelStyle: TextStyle(
                fontSize: 14.0,
                letterSpacing: -0.01,
                height: 1.4,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w400,
              ),
              tabs: [
                Tab(text: "판매중"),
                Tab(text: "예약중"),
                Tab(text: "판매완료"),
              ],
            ),
            const Divider(
              height: 1.0,
              color: GRAYSCALE_GRAY_02,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ItemPostPreviewCard(
                    data: ref.watch(likedSellingSecondHandPostProvider),
                    notifierProvider:
                        ref.watch(likedSellingSecondHandPostProvider.notifier),
                    postDetailProvider:
                        likedSellingSecondHandPostDetailProvider,
                    cardType: CardType.market,
                  ),
                  ItemPostPreviewCard(
                    data: ref.watch(likedReservedSecondHandPostProvider),
                    notifierProvider:
                        ref.watch(likedReservedSecondHandPostProvider.notifier),
                    postDetailProvider:
                        likedReservedSecondHandPostDetailProvider,
                    cardType: CardType.market,
                  ),
                  ItemPostPreviewCard(
                    data: ref.watch(likedSoldoutSecondHandPostProvider),
                    notifierProvider:
                        ref.watch(likedSoldoutSecondHandPostProvider.notifier),
                    postDetailProvider:
                        likedSellingSecondHandPostDetailProvider,
                    cardType: CardType.market,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
