import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/backoffice/provider/backoffice_provider.dart';
import 'package:mingle/common/component/general_post_preview_card.dart';
import 'package:mingle/common/model/cursor_pagination_model.dart';
import 'package:mingle/post/models/post_model.dart';
// import 'package:mingle/common/component/post_preview_card.dart';
import 'package:mingle/post/provider/post_provider.dart';
import 'package:mingle/user/provider/user_provider.dart';
import 'package:mingle/user/view/home_screen/home_root_tab.dart';
import 'package:mingle/user/view/home_screen/tab_screen.dart';

class LawnTabScreen extends ConsumerStatefulWidget {
  final Function(int)? changeTabIndex;
  final CustomScrollController controller;
  const LawnTabScreen({
    this.changeTabIndex,
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  ConsumerState<LawnTabScreen> createState() => _LawnTabScreenState();
}

class _LawnTabScreenState extends ConsumerState<LawnTabScreen> {
  @override
  Widget build(BuildContext context) {
    // List<
    //         StateNotifierProvider<BackofficePostStateNotifier,
    //             CursorPaginationBase>> dataList =
    //     List.generate(27, (index) => universityAllPostProvider(index + 1));
    // // List<dynamic> notifierProviderList = List.generate(
    // //     27, (index) => universityAllPostProvider(index + 1));
    // // List<dynamic> allNotifierProviderList = List.generate(
    // //     27, (index) => universityAllPostProvider(index + 1));
    // List<ProviderFamily<PostModel?, int>> postDetailProviderList =
    //     List.generate(
    //         27, (index) => universityAllPostProviderDetailProvider(index + 1));
    return TabScreen(
        boardType: "UNIV",
        title: '잔디밭',
        tabs: const [
          "전체",
          "HKU",
          "HKUST",
          "CUHK",
          "CITYU",
          "POLYU",
          "FRESHMAN",
          "NUS",
          "NTU",
          "SMU",
          "USTB",
          "UIBE",
          "BNU",
          "BFSU",
          "PKUHSC",
          "BIFT",
          "CUEB",
          "CMU",
          "BLCU",
          "BUPT",
          "BIT",
          "RUC",
          "CUC",
          "BISU",
          "CAFA",
          "THU",
          "BUAA",
          "CUPL"
        ],
        tabContents: List.generate(
            28,
            (index) => GeneralPostPreviewCard(
                  controller: widget.controller,
                  boardType: "잔디밭",
                  // postList: dummyPostList,
                  data: ref.watch(universityAllPostProviderList[index]),
                  notifierProvider:
                      ref.watch(universityAllPostProviderList[index].notifier),
                  allNotifierProvider:
                      ref.watch(universityAllPostProviderList[index].notifier),
                  postDetailProvider:
                      universityAllPostDetailProviderList[index],
                  // postFuture: paginatePost("MINGLE", ref),
                  cardType: CardType.square,
                )));
  }

  @override
  bool get wantKeepAlive => true;
}
