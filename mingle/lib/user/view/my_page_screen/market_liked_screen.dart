import 'package:flutter/material.dart';
import 'package:mingle/common/component/post_preview_card.dart';
import 'package:mingle/common/const/colors.dart';

class MarketLikedScreen extends StatelessWidget {
  MarketLikedScreen({super.key});

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
        title: const Center(
          child: Text(
            "찜한내역",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: ListView(
        children: const [
          // PostPreviewCard(
          //   postList: dummyPostList,
          //   cardType: CardType.market,
          // ),
          SizedBox(height: 48.0),
        ],
      ),
    );
  }
}
