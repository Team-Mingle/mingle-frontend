import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/component/item_post_preview_card.dart';
import 'package:mingle/common/component/post_preview_card.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/second_hand_market/model/second_hand_market_post_detail_model.dart';
import 'package:mingle/second_hand_market/model/second_hand_market_post_model.dart';
import 'package:mingle/second_hand_market/provider/second_hand_market_post_provider.dart';
import 'package:mingle/user/provider/member_provider.dart';

class MarketSellingScreen extends ConsumerWidget {
  MarketSellingScreen({super.key});

  final dummyPostList = List.generate(50, (index) {
    return {
      'title': 'Post ${index + 1}',
      'content': 'This is the content of Post ${index + 1}.',
      'nickname': 'User${index + 1}',
      'timestamp': '${index + 1} hours ago',
      'likeCounts': '${10 + index}',
      'commentCounts': '${5 + index}',
      'postUrls':
          'https://cdn.pixabay.com/photo/2016/01/08/05/24/sunflower-1127174_1280.jpg',
      'askingPrice': '${index + 1}',
      'currencies': 'HKD'
    };
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR_GRAY,
      appBar: AppBar(
        backgroundColor: BACKGROUND_COLOR_GRAY,
        centerTitle: true,
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
          "판매내역",
          style: TextStyle(
            fontSize: 16.0,
            letterSpacing: -0.02,
            height: 1.5,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ),
      body:
          // ItemPostPreviewCard(
          //   data: ref.watch(itemMyPostProvider),
          //   notifierProvider: ref.watch(itemMyPostProvider.notifier),
          //   postDetailProvider: itemMyPostDetailProvider,
          //   cardType: CardType.market,
          // ),
          DefaultTabController(
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
                    data: ref.watch(mySellingSecondHandPostProvider),
                    notifierProvider:
                        ref.watch(mySellingSecondHandPostProvider.notifier),
                    postDetailProvider: mySellingSecondHandPostDetailProvider,
                    cardType: CardType.market,
                  ),
                  ItemPostPreviewCard(
                    data: ref.watch(myReservedSecondHandPostProvider),
                    notifierProvider:
                        ref.watch(myReservedSecondHandPostProvider.notifier),
                    postDetailProvider: myReservedSecondHandPostDetailProvider,
                    cardType: CardType.market,
                  ),
                  ItemPostPreviewCard(
                    data: ref.watch(mySoldoutSecondHandPostProvider),
                    notifierProvider:
                        ref.watch(mySoldoutSecondHandPostProvider.notifier),
                    postDetailProvider: mySoldoutSecondHandPostDetailProvider,
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
