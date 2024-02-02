import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/component/item_post_preview_card.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/post/provider/post_provider.dart';
import 'package:mingle/user/provider/member_provider.dart';

class LikedSecondHandPostsScreen extends ConsumerStatefulWidget {
  const LikedSecondHandPostsScreen({super.key});

  @override
  ConsumerState<LikedSecondHandPostsScreen> createState() =>
      _LikedSecondHandPostsScreenState();
}

class _LikedSecondHandPostsScreenState
    extends ConsumerState<LikedSecondHandPostsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // TabController 초기화
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
        title: const Text(
          "찜한 내역",
          style: TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black),
        ),
      ),
      body: ItemPostPreviewCard(
        data: ref.watch(likedSecondHandPostProvider),
        notifierProvider: ref.watch(likedSecondHandPostProvider.notifier),
        postDetailProvider: likedSecondHandPostDetailProvider,
        cardType: CardType.market,
      ),
    );
  }
}
