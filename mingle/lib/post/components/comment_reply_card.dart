import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/post/components/comment_card.dart';
import 'package:mingle/post/components/comment_details.dart';

class CommentReplyCard extends StatelessWidget {
  const CommentReplyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 12.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            "assets/img/post_screen/reply_icon.svg",
            width: 16.0,
            height: 16.0,
          ),
          const SizedBox(
            width: 3.0,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: GRAYSCALE_GRAY_01_5,
                  border: Border.all(color: GRAYSCALE_GRAY_01_5),
                  borderRadius: BorderRadius.circular(8.0)),
              child: const Padding(
                padding: EdgeInsets.only(
                    top: 12.0, bottom: 12.0, left: 14.0, right: 8.0),
                child: CommentDetails(
                  comment: "hi",
                  // ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
