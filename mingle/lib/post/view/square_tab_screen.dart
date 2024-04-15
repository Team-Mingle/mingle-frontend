import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/component/general_post_preview_card.dart';
// import 'package:mingle/common/component/post_preview_card.dart';
import 'package:mingle/post/provider/post_provider.dart';
import 'package:mingle/user/provider/user_provider.dart';
import 'package:mingle/user/view/home_screen/home_root_tab.dart';
import 'package:mingle/user/view/home_screen/tab_screen.dart';

class SquareTabScreen extends ConsumerWidget {
  final Function(int)? changeTabIndex;
  final CustomScrollController controller;
  const SquareTabScreen({
    Key? key,
    this.changeTabIndex,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isChina = ref.watch(currentUserProvider)!.country == "CHINA";
    return TabScreen(
      boardType: 'TOTAL',
      title: '광장',
      subtitle: '모든 학교의 학생들이 모인',
      tab1: '전체글',
      tab2: '자유',
      tab3: '질문',
      tab4: isChina ? '총학생회' : '밍글소식',
      tabContents: [
        GeneralPostPreviewCard(
          boardType: "광장",
          controller: controller,
          categoryType: "전체",
          // postList: dummyPostList,
          data: ref.watch(totalAllPostProvider),
          notifierProvider: ref.watch(totalAllPostProvider.notifier),
          allNotifierProvider: ref.watch(totalAllPostProvider.notifier),
          postDetailProvider: totalAllPostDetailProvider,
          // postFuture: paginatePost("MINGLE", ref),
          cardType: CardType.square,
        ),
        GeneralPostPreviewCard(
          controller: controller,
          boardType: "광장",
          categoryType: "자유",
          data: ref.watch(totalFreePostProvider),
          // postFuture: paginatePost("FREE", ref),
          notifierProvider: ref.watch(totalFreePostProvider.notifier),
          allNotifierProvider: ref.watch(totalAllPostProvider.notifier),
          postDetailProvider: totalFreePostDetailProvider,
          cardType: CardType.square,
        ),
        GeneralPostPreviewCard(
          boardType: "광장",
          categoryType: "질문",
          controller: controller,
          data: ref.watch(totalQnAPostProvider),
          // postFuture: paginatePost("QNA", ref),
          notifierProvider: ref.watch(totalQnAPostProvider.notifier),
          allNotifierProvider: ref.watch(totalAllPostProvider.notifier),
          postDetailProvider: totalQnAPostDetailProvider,
          cardType: CardType.square,
        ),
        GeneralPostPreviewCard(
          boardType: "광장",
          categoryType: "밍글소식",
          controller: controller,
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
