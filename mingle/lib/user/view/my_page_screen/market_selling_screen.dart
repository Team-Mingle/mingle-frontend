import 'package:flutter/material.dart';
import 'package:mingle/common/component/post_preview_card.dart';
import 'package:mingle/common/const/colors.dart';

class MarketSellingScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const TabBar(
              indicatorColor: PRIMARY_COLOR_ORANGE_01,
              labelColor: Colors.black,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              labelStyle: TextStyle(
                fontSize: 14,
                fontFamily: 'Pretendard Variable',
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelColor: GRAYSCALE_GRAY_04,
              unselectedLabelStyle: TextStyle(
                fontSize: 14,
                fontFamily: 'Pretendard Variable',
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
                  Container(),
                  Container(),
                  Container(),
                  // Center(
                  //   child: ListView(
                  //     children: [
                  //       PostPreviewCard(
                  //         postList: dummyPostList,
                  //         cardType: CardType.selling,
                  //       ),
                  //       const SizedBox(height: 48.0),
                  //     ],
                  //   ),
                  // ),
                  // Center(
                  //   child: ListView(
                  //     children: [
                  //       PostPreviewCard(
                  //         postList: dummyPostList,
                  //         cardType: CardType.selling,
                  //       ),
                  //       const SizedBox(height: 48.0),
                  //     ],
                  //   ),
                  // ),
                  // Center(
                  //   child: ListView(
                  //     children: [
                  //       PostPreviewCard(
                  //         postList: dummyPostList,
                  //         cardType: CardType.selling,
                  //       ),
                  //       const SizedBox(height: 48.0),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
