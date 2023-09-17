import 'package:flutter/material.dart';
import 'package:mingle/common/component/post_preview_card.dart';
import 'package:mingle/user/view/home_screen/tab_screen.dart';

class SquareTabScreen extends StatelessWidget {
  final dummyPostList = [
    {
      'title':
          'Post 1Post 1Post 1Post 1Post 1Post 1Post 1Post 1Post 1Post 1Post 1Post 1Post 1Post 1Post 1Post 1Post 1',
      'content':
          'This is the content of Post 1. This is the content of Post 1.This is the content of Post 1. This is the content of Post 1. This is the content of Post 1. content of Post 1. This is the content of Post 1. content of Post 1. This is the content of Post 1. content of Post 1. This is the content of Post 1..',
      'nickname': 'User1',
      'timestamp': '2 hours ago',
      'likeCounts': '10',
      'commentCounts': '5',
    },
    {
      'title': 'Post 2',
      'content': 'This is the content of Post 2.',
      'nickname': 'User2',
      'timestamp': '1 hour ago',
      'likeCounts': '20',
      'commentCounts': '8',
    },
    {
      'title': 'Post 3',
      'content': 'This is the content of Post 3.',
      'nickname': 'User3',
      'timestamp': '1 hour ago',
      'likeCounts': '30',
      'commentCounts': '8',
    },
    {
      'title': 'Post 4',
      'content': 'This is the content of Post 4.',
      'nickname': 'User4',
      'timestamp': '4 hour ago',
      'likeCounts': '20',
      'commentCounts': '8',
    },
    {
      'title': 'Post 3',
      'content': 'This is the content of Post 3.',
      'nickname': 'User3',
      'timestamp': '1 hour ago',
      'likeCounts': '30',
      'commentCounts': '8',
    },
    {
      'title': 'Post 4',
      'content': 'This is the content of Post 4.',
      'nickname': 'User4',
      'timestamp': '4 hour ago',
      'likeCounts': '20',
      'commentCounts': '8',
    },
    {
      'title': 'Post 3',
      'content': 'This is the content of Post 3.',
      'nickname': 'User3',
      'timestamp': '1 hour ago',
      'likeCounts': '30',
      'commentCounts': '8',
    },
    {
      'title': 'Post 4',
      'content': 'This is the content of Post 4.',
      'nickname': 'User4',
      'timestamp': '4 hour ago',
      'likeCounts': '20',
      'commentCounts': '8',
    },
    {
      'title': 'Post 3',
      'content': 'This is the content of Post 3.',
      'nickname': 'User3',
      'timestamp': '1 hour ago',
      'likeCounts': '30',
      'commentCounts': '8',
    },
    {
      'title': 'Post 4',
      'content': 'This is the content of Post 4.',
      'nickname': 'User4',
      'timestamp': '4 hour ago',
      'likeCounts': '20',
      'commentCounts': '8',
    },
    {
      'title': 'Post 3',
      'content': 'This is the content of Post 3.',
      'nickname': 'User3',
      'timestamp': '1 hour ago',
      'likeCounts': '30',
      'commentCounts': '8',
    },
    {
      'title': 'Post 4',
      'content': 'This is the content of Post 4.',
      'nickname': 'User4',
      'timestamp': '4 hour ago',
      'likeCounts': '20',
      'commentCounts': '8',
    },
    {
      'title': 'Post 3',
      'content': 'This is the content of Post 3.',
      'nickname': 'User3',
      'timestamp': '1 hour ago',
      'likeCounts': '30',
      'commentCounts': '8',
    },
    {
      'title': 'Post 4',
      'content': 'This is the content of Post 4.',
      'nickname': 'User4',
      'timestamp': '4 hour ago',
      'likeCounts': '20',
      'commentCounts': '8',
    },
    {
      'title': 'Post 3',
      'content': 'This is the content of Post 3.',
      'nickname': 'User3',
      'timestamp': '1 hour ago',
      'likeCounts': '30',
      'commentCounts': '8',
    },
    {
      'title': 'Post 4',
      'content': 'This is the content of Post 4.',
      'nickname': 'User4',
      'timestamp': '4 hour ago',
      'likeCounts': '20',
      'commentCounts': '8',
    },
    {
      'title': 'Post 3',
      'content': 'This is the content of Post 3.',
      'nickname': 'User3',
      'timestamp': '1 hour ago',
      'likeCounts': '30',
      'commentCounts': '8',
    },
    {
      'title': 'Post 4',
      'content': 'This is the content of Post 4.',
      'nickname': 'User4',
      'timestamp': '4 hour ago',
      'likeCounts': '20',
      'commentCounts': '8',
    },
  ];

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
