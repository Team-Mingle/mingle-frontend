import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/component/like_animation.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/second_hand_market/model/second_hand_market_post_detail_model.dart';
import 'package:mingle/second_hand_market/model/second_hand_market_post_model.dart';

class SecondHandMarketPostLikeAndCommentNumbersCard extends StatefulWidget {
  SecondHandMarketPostModel post;
  final Function likeOrUnlikePost;
  SecondHandMarketPostLikeAndCommentNumbersCard(
      {super.key, required this.post, required this.likeOrUnlikePost});

  @override
  State<SecondHandMarketPostLikeAndCommentNumbersCard> createState() =>
      _SecondHandMarketPostLikeAndCommentNumbersCardState();
}

class _SecondHandMarketPostLikeAndCommentNumbersCardState
    extends State<SecondHandMarketPostLikeAndCommentNumbersCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 23.0),
      child: SizedBox(
        height: 50.0,
        width: MediaQuery.of(context).size.width,
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Text(
            "찜",
            style: TextStyle(color: GRAYSCALE_GRAY_04),
          ),
          const SizedBox(
            width: 4.0,
          ),
          Text(
            widget.post.likeCount.toString(),
            style: const TextStyle(
                color: GRAYSCALE_GRAY_ORANGE_02, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            width: 16.0,
          ),
          const Text(
            "댓글",
            style: TextStyle(color: GRAYSCALE_GRAY_04),
          ),
          const SizedBox(
            width: 4.0,
          ),
          Text(
            widget.post.commentCount.toString(),
            style: const TextStyle(
                color: GRAYSCALE_GRAY_ORANGE_02, fontWeight: FontWeight.w600),
          ),
          Expanded(child: Container()),
          GestureDetector(
            onTap: () async {
              if (widget.post.isLiked) {
                setState(() {
                  widget.post.likeCount--;
                  widget.post.isLiked = false;
                });
              } else {
                setState(() {
                  widget.post.likeCount++;
                  widget.post.isLiked = true;
                });
              }
              await widget.likeOrUnlikePost();
            },
            child: SvgPicture.asset(
              widget.post.isLiked
                  ? "assets/img/second_hand_market_screen/heart_icon_filled.svg"
                  : "assets/img/second_hand_market_screen/heart_icon.svg",
            ),
          )
        ]),
      ),
    );
    // return Padding(
    //   padding: const EdgeInsets.only(left: 20.0, right: 23.0),
    //   child: SizedBox(
    //     height: 40.0,
    //     width: MediaQuery.of(context).size.width,
    //     child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
    //       const Text(
    //         "좋아요",
    //         style: TextStyle(color: GRAYSCALE_GRAY_04),
    //       ),
    //       const SizedBox(
    //         width: 4.0,
    //       ),
    //       Text(
    //         // "0",
    //         widget.post.likeCount.toString(),
    //         style: const TextStyle(
    //             color: GRAYSCALE_GRAY_ORANGE_02, fontWeight: FontWeight.w600),
    //       ),
    //       const SizedBox(
    //         width: 16.0,
    //       ),
    //       const Text(
    //         "댓글",
    //         style: TextStyle(color: GRAYSCALE_GRAY_04),
    //       ),
    //       const SizedBox(
    //         width: 4.0,
    //       ),
    //       Text(
    //         // "0",
    //         widget.post.commentCount.toString(),
    //         style: const TextStyle(
    //             color: GRAYSCALE_GRAY_ORANGE_02, fontWeight: FontWeight.w600),
    //       ),
    //       Expanded(child: Container()),
    //       GestureDetector(
    // onTap: () async {
    //   if (widget.post.liked) {
    //     setState(() {
    //       widget.post.likeCount--;
    //       widget.post.liked = false;
    //     });
    //   } else {
    //     setState(() {
    //       widget.post.likeCount++;
    //       widget.post.liked = true;
    //     });
    //   }
    //   await widget.likeOrUnlikePost();
    // },
    //         child: LikeAnimation(
    //           isAnimating: widget.post.liked,
    //           child: SvgPicture.asset(widget.post.liked
    //               ? "assets/img/post_screen/thumbs_up_selected_icon.svg"
    //               : "assets/img/post_screen/thumbs_up_icon.svg"),
    //         ),
    //       ),
    //       const SizedBox(
    //         width: 34.0,
    //       ),
    //       SvgPicture.asset("assets/img/post_screen/scrap_icon.svg"),
    //     ]),
    //   ),
    // );
  }
}
