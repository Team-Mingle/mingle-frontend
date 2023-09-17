import 'package:flutter/material.dart';
import 'package:mingle/common/component/post_preview_card.dart';
import 'package:mingle/user/view/home_screen/tab_screen.dart';

class LawnTabScreen extends StatelessWidget {
  LawnTabScreen({
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
    };
  });

  @override
  Widget build(BuildContext context) {
    return TabScreen(
      title: '잔디밭',
      subtitle: '밍글대',
      tab1: '전체글',
      tab2: '자유',
      tab3: '질문',
      tab4: '학생회',
      tabContents: [
        // 첫 번째 탭 내용
        PostPreviewCard(
          postList: dummyPostList,
          cardType: CardType.square,
        ),
        // 두 번째 탭 내용
        PostPreviewCard(
          postList: dummyPostList,
          cardType: CardType.square,
        ),
        // 세 번째 탭 내용
        PostPreviewCard(
          postList: dummyPostList,
          cardType: CardType.square,
        ),
        // 네 번째 탭 내용
        PostPreviewCard(
          postList: dummyPostList,
          cardType: CardType.square,
        ),
      ],
    );
  }
}
