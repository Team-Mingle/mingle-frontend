import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/post/components/comment_details.dart';
import 'package:mingle/post/components/comment_reply_card.dart';

class CommentCard extends StatelessWidget {
  final String comment;
  const CommentCard({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CommentDetails(comment: comment),
        ),
        Column(
          children: List.generate(
            4,
            (index) => const Column(
              children: [
                SizedBox(
                  height: 12.0,
                ),
                CommentReplyCard(),
              ],
            ),
          ),
        )
      ],
    );
  }
}
