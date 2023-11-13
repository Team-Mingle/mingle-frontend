import 'package:flutter/material.dart';
import 'package:mingle/common/component/post_preview_card.dart';
import 'package:mingle/user/view/home_screen/tab_screen.dart';

class SquareTabScreen extends StatelessWidget {
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

  SquareTabScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabScreen(
      title: '광장',
      subtitle: '모든 학교의 학생들이 모인',
      tab1: '전체글',
      tab2: '자유',
      tab3: '질문',
      tab4: '밍글소식',
      tabContents: [
        PostPreviewCard(
          postList: dummyPostList,
          cardType: CardType.square,
        ),
        PostPreviewCard(
          postList: dummyPostList,
          cardType: CardType.square,
        ),
        PostPreviewCard(
          postList: dummyPostList,
          cardType: CardType.square,
        ),
        PostPreviewCard(
          postList: dummyPostList,
          cardType: CardType.square,
        ),
      ],
    );
  }
}
