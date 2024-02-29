import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/component/item_post_preview_card.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/second_hand_market/provider/second_hand_market_post_provider.dart';
import 'package:mingle/second_hand_market/view/add_second_hand_post_screen.dart';
import 'package:mingle/second_hand_market/view/second_hand_market_search_screen.dart';
import 'package:mingle/user/view/home_screen/home_root_tab.dart';
import 'package:mingle/user/view/home_screen/home_tab_screen.dart';
import 'package:mingle/user/view/home_screen/notification_screen.dart';
import 'package:mingle/user/view/home_screen/search_screen.dart';
import 'package:mingle/user/view/my_page_screen/my_page_screen.dart';
import 'package:page_transition/page_transition.dart';

class MarketTabScreen extends ConsumerWidget {
  final Function(int)? changeTabIndex;
  final CustomScrollController controller;
  MarketTabScreen({
    this.changeTabIndex,
    required this.controller,
    Key? key,
  }) : super(key: key);

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        toolbarHeight: 48,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          '장터',
          style: TextStyle(
            color: GRAYSCALE_BLACK_GRAY,
            fontSize: 20.0,
            letterSpacing: -0.03,
            height: 1.5,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/img/home_screen/ic_home_myPage.svg',
                width: 24,
                height: 24,
              ),
            ),
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const MyPageScreen())),
          ),
          IconButton(
            icon: Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/img/home_screen/ic_home_search.svg',
                width: 24,
                height: 24,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/img/home_screen/ic_home_notification.svg',
                  width: 28,
                  height: 28,
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.bottomToTop,
                        duration: const Duration(milliseconds: 200),
                        child: const NotificationScreen()));
              },
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          ItemPostPreviewCard(
            controller: controller,
            data: ref.watch(secondHandPostProvider),
            notifierProvider: ref.watch(secondHandPostProvider.notifier),
            postDetailProvider: secondHandPostDetailProvider,
            cardType: CardType.market,
          ),
          const SizedBox(height: 48.0),
          Positioned(
            right: 16.0,
            bottom: 16.0,
            child: FloatingActionButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => const AddSecondHandPostScreen())),
              backgroundColor: PRIMARY_COLOR_ORANGE_02,
              shape: const CircleBorder(),
              child: const Icon(
                color: Colors.white,
                Icons.add,
                size: 36,
              ),
            ),
          )
        ],
      ),
    );
  }
}
