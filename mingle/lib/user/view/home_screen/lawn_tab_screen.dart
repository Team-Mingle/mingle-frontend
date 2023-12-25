import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/component/general_post_preview_card.dart';
// import 'package:mingle/common/component/post_preview_card.dart';
import 'package:mingle/post/provider/post_provider.dart';
import 'package:mingle/user/view/home_screen/tab_screen.dart';

class LawnTabScreen extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    return TabScreen(
      boardType: "UNIV",
      title: '잔디밭',
      subtitle: '밍글대',
      tab1: '전체글',
      tab2: '자유',
      tab3: '질문',
      tab4: '학생회',
      tabContents: [
        GeneralPostPreviewCard(
          // postList: dummyPostList,
          data: ref.watch(univAllPostProvider),
          notifierProvider: ref.watch(univFreePostProvider.notifier),
          allNotifierProvider: ref.watch(univAllPostProvider.notifier),
          postDetailProvider: univFreePostDetailProvider,
          // postFuture: paginatePost("MINGLE", ref),
          cardType: CardType.square,
        ),
        GeneralPostPreviewCard(
          data: ref.watch(univFreePostProvider),
          // postFuture: paginatePost("FREE", ref),
          notifierProvider: ref.watch(univFreePostProvider.notifier),
          allNotifierProvider: ref.watch(univAllPostProvider.notifier),
          postDetailProvider: univFreePostDetailProvider,
          cardType: CardType.square,
        ),
        GeneralPostPreviewCard(
          data: ref.watch(univQnAPostProvider),
          // postFuture: paginatePost("QNA", ref),
          notifierProvider: ref.watch(univQnAPostProvider.notifier),
          allNotifierProvider: ref.watch(univAllPostProvider.notifier),
          postDetailProvider: univQnAPostDetailProvider,
          cardType: CardType.square,
        ),
        GeneralPostPreviewCard(
          data: ref.watch(univKsaPostProvider),
          // postFuture: paginatePost("KSA", ref),
          notifierProvider: ref.watch(univKsaPostProvider.notifier),
          allNotifierProvider: ref.watch(univAllPostProvider.notifier),
          postDetailProvider: univKsaPostDetailProvider,
          cardType: CardType.square,
        ),
      ],
    );
  }
}
