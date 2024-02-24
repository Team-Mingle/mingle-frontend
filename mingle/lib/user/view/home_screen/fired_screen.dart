import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/component/general_post_preview_card.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/post/provider/post_provider.dart';

class fireScreen extends ConsumerWidget {
  const fireScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: BACKGROUND_COLOR_GRAY,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 0.0),
            child: InkWell(
              child: Image.asset(
                  "assets/img/signup_screen/previous_screen_icon.png",
                  fit: BoxFit.scaleDown),
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
          title: const Text(
            "불타오르는 게시물",
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                color: Colors.black),
          ),
        ),
        body: GeneralPostPreviewCard(
          // boardType: "잔디밭",
          // data: ref.watch(univAllPostProvider),
          // notifierProvider: ref.watch(univAllPostProvider.notifier),
          // allNotifierProvider: ref.watch(univAllPostProvider.notifier),
          // postDetailProvider: univAllPostDetailProvider,
          // cardType: CardType.square,
          boardType: "best",
          data: ref.watch(bestPostProvider),
          notifierProvider: ref.watch(bestPostProvider.notifier),
          allNotifierProvider: ref.watch(bestPostProvider.notifier),
          postDetailProvider: bestPostDetailProvider,
          cardType: CardType.square,
        ),
      ),
    );
  }
}
