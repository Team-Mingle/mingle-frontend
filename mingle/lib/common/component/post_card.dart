import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/component/general_post_preview_card.dart';
import 'package:mingle/common/component/secondhand_preview_card.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/model/cursor_pagination_model.dart';
import 'package:mingle/post/provider/post_provider.dart';
import 'package:mingle/post/view/lawn_tab_screen.dart';
import 'package:mingle/post/view/square_tab_screen.dart';

class PostCard extends ConsumerWidget {
  final String title;
  final CursorPaginationBase data;
  final String postType;
  final Function(int)? changeTabIndex;

  const PostCard({
    required this.data,
    required this.title,
    required this.postType,
    this.changeTabIndex,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget postPreviewWidget;
    switch (postType) {
      case "square":
        postPreviewWidget = GeneralPostPreviewCard(
          data: data,
          cardType: CardType.home,
        );
        break;
      case "lawn":
        postPreviewWidget = GeneralPostPreviewCard(
          data: data,
          cardType: CardType.home,
        );
        break;
      case "fire":
        postPreviewWidget = GeneralPostPreviewCard(
          data: data,
          cardType: CardType.home,
        );
      case "secondhand":
        postPreviewWidget = SecondhandPreviewCard(
          data: data,
          onMorePressed: () => changeTabIndex?.call(3),
        );
        break;
      default:
        postPreviewWidget = Container();
    }

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            switch (postType) {
              case "square":
                changeTabIndex?.call(1);
                break;
              case "lawn":
                changeTabIndex?.call(2);
                break;
              case "fire":
                print("불타는 게시판 생성중");
                break;
              case "secondhand":
                changeTabIndex?.call(3);
                break;
              default:
                print("Unknown post type: $postType");
            }
          },
          child: Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: "Pretendard",
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
        postPreviewWidget,
      ],
    );
  }
}
