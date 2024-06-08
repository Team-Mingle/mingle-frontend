import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/backoffice/provider/backoffice_provider.dart';
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
    return TabScreen(
      boardType: 'TOTAL',
      title: '광장',
      tabs: const ["홍콩", "중국", "싱가폴"],
      tabContents: [
        GeneralPostPreviewCard(
          boardType: "광장",
          controller: controller,
          // postList: dummyPostList,
          data: ref.watch(hongkongAllPostProvider),
          notifierProvider: ref.watch(hongkongAllPostProvider.notifier),
          allNotifierProvider: ref.watch(hongkongAllPostProvider.notifier),
          postDetailProvider: hongkongAllPostProviderDetailProvider,
          // postFuture: paginatePost("MINGLE", ref),
          cardType: CardType.square,
        ),
        GeneralPostPreviewCard(
          controller: controller,
          boardType: "광장",
          data: ref.watch(chinaAllPostProvider),
          notifierProvider: ref.watch(chinaAllPostProvider.notifier),
          allNotifierProvider: ref.watch(chinaAllPostProvider.notifier),
          postDetailProvider: chinaAllPostProviderDetailProvider,
          cardType: CardType.square,
        ),
        GeneralPostPreviewCard(
          boardType: "광장",
          controller: controller,
          data: ref.watch(singaporeAllPostProvider),
          notifierProvider: ref.watch(singaporeAllPostProvider.notifier),
          allNotifierProvider: ref.watch(singaporeAllPostProvider.notifier),
          postDetailProvider: singaporeAllPostProviderDetailProvider,
          cardType: CardType.square,
        ),
      ],
    );
  }
}
