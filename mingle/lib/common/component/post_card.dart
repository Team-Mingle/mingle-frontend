import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/component/general_post_preview_card.dart';
import 'package:mingle/common/component/post_preview_card.dart';
import 'package:mingle/common/const/colors.dart';

class PostCard extends StatelessWidget {
  final String title;

  final dummyPostList = [
    {
      'title':
          'Post 1Post 1Post 1Post 1Post 1Post 1Post 1Post 1Post 1Post 1Post 1Post 1Post 1Post 1Post 1Post 1Post 1',
      'content':
          'This is the content of Post 1. This is the content of Post 1.This is the content of Post 1. This is the content of Post 1. This is the content of Post 1.                                                  dsfsdf.',
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
  ];

  PostCard({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            print('First item tapped');
          },
          child: Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: "Pretendard Variable",
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: GRAYSCALE_BLACK,
                ),
                textAlign: TextAlign.left,
              ),
              SvgPicture.asset(
                'assets/img/home_screen/ic_home_right_direction_bold.svg',
                width: 24,
                height: 24,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        // GeneralPostPreviewCard(
        //   postList: ,
        //   cardType: CardType.home,
        // ),
      ],
    );
  }
}
