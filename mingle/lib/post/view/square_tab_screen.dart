import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/component/general_post_preview_card.dart';
// import 'package:mingle/common/component/post_preview_card.dart';
import 'package:mingle/post/provider/post_provider.dart';
import 'package:mingle/user/view/home_screen/tab_screen.dart';

class SquareTabScreen extends ConsumerWidget {
  final Function(int)? changeTabIndex;
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
    this.changeTabIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TabScreen(
      boardType: 'TOTAL',
      title: '광장',
      subtitle: '모든 학교의 학생들이 모인',
      tab1: '전체글',
      tab2: '자유',
      tab3: '질문',
      tab4: '밍글소식',
      tabContents: [
        GeneralPostPreviewCard(
          // postList: dummyPostList,
          data: ref.watch(totalAllPostProvider),
          notifierProvider: ref.watch(totalAllPostProvider.notifier),
          allNotifierProvider: ref.watch(totalAllPostProvider.notifier),
          postDetailProvider: totalAllPostDetailProvider,
          // postFuture: paginatePost("MINGLE", ref),
          cardType: CardType.square,
        ),
        GeneralPostPreviewCard(
          data: ref.watch(totalFreePostProvider),
          // postFuture: paginatePost("FREE", ref),
          notifierProvider: ref.watch(totalFreePostProvider.notifier),
          allNotifierProvider: ref.watch(totalAllPostProvider.notifier),
          postDetailProvider: totalFreePostDetailProvider,
          cardType: CardType.square,
        ),
        GeneralPostPreviewCard(
          data: ref.watch(totalQnAPostProvider),
          // postFuture: paginatePost("QNA", ref),
          notifierProvider: ref.watch(totalQnAPostProvider.notifier),
          allNotifierProvider: ref.watch(totalAllPostProvider.notifier),
          postDetailProvider: totalQnAPostDetailProvider,
          cardType: CardType.square,
        ),
        GeneralPostPreviewCard(
          data: ref.watch(totalMinglePostProvider),
          // postFuture: paginatePost("KSA", ref),
          notifierProvider: ref.watch(totalMinglePostProvider.notifier),
          allNotifierProvider: ref.watch(totalAllPostProvider.notifier),
          postDetailProvider: totalMinglePostDetailProvider,
          cardType: CardType.square,
        ),
      ],
    );
  }
}
