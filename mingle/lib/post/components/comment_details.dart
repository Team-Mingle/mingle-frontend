import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';

class CommentDetails extends StatelessWidget {
  final String comment;
  const CommentDetails({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            comment,
            style: const TextStyle(fontSize: 13.0),
          ),
          const SizedBox(
            width: 12.0,
          ),
          const Spacer(),
          // Flexible(fit: FlexFit.loose, child: Container()),
          SvgPicture.asset("assets/img/post_screen/triple_dot_icon.svg"),
          const SizedBox(
            width: 4.0,
          )
        ],
      ),
      const SizedBox(
        height: 10.0,
      ),
      Row(
        children: [
          const Text(
            "익명",
            style: TextStyle(color: GRAYSCALE_GRAY_04, fontSize: 12.0),
          ),
          const SizedBox(
            width: 4.0,
          ),
          const Text(
            "•",
            style: TextStyle(color: GRAYSCALE_GRAY_02, fontSize: 12.0),
          ),
          const SizedBox(
            width: 4.0,
          ),
          const Text(
            "07/17",
            style: TextStyle(color: GRAYSCALE_GRAY_03, fontSize: 12.0),
          ),
          const SizedBox(
            width: 4.0,
          ),
          const Text(
            "13:03",
            style: TextStyle(color: GRAYSCALE_GRAY_03, fontSize: 12.0),
          ),
          const Spacer(),
          SvgPicture.asset(
            "assets/img/post_screen/thumbs_up_icon.svg",
            width: 12.8,
            height: 12.0,
          ),
          const SizedBox(
            width: 6.0,
          ),
          const Text(
            "0",
            style: TextStyle(color: GRAYSCALE_GRAY_03, fontSize: 12.0),
          ),
          const SizedBox(
            width: 22.0,
          ),
          SvgPicture.asset(
            "assets/img/post_screen/reply_icon.svg",
            width: 16.0,
            height: 16.0,
          ),
          const SizedBox(
            width: 4.0,
          )
        ],
      ),
      // const CommentReplyCard()
    ]);
  }
}
