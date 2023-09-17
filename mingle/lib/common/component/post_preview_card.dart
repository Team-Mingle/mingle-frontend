import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';

enum CardType { home, square, lawn }

class PostPreviewCard extends StatelessWidget {
  final List<Map<String, String>> postList;
  final CardType cardType;

  const PostPreviewCard({
    required this.postList,
    required this.cardType,
    Key? key,
  }) : super(key: key);

  int getMaxLines() {
    switch (cardType) {
      case CardType.home:
        return 1;
      case CardType.square:
        return 3;
      case CardType.lawn:
        return 3;
    }
  }

  double getMaxPadding() {
    switch (cardType) {
      case CardType.home:
        return 10.0;
      case CardType.square:
        return 8.0;
      case CardType.lawn:
        return 8.0;
    }
  }

  Widget buildDivider() {
    final verticalPadding = cardType == CardType.home ? 10.0 : 8.0;

    return Container(
      margin: EdgeInsets.symmetric(vertical: verticalPadding),
      height: 0.1,
      color: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: postList.length,
          itemBuilder: (context, index) {
            final post = postList[index];
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          post['title'] ?? '',
                          style: const TextStyle(
                            fontFamily: "Pretendard Variable",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: GRAYSCALE_BLACK_GRAY,
                          ),
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    post['content'] ?? '',
                    style: const TextStyle(
                      fontFamily: "Pretendard Variable",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: GRAYSCALE_GRAY_05,
                    ),
                    textAlign: TextAlign.left,
                    maxLines: getMaxLines(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          post['nickname'] ?? '',
                          style: const TextStyle(
                            fontFamily: "Pretendard Variable",
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: GRAYSCALE_GREY_ORANGE,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(width: 4.0),
                        SvgPicture.asset(
                          'assets/img/common/ic_dot.svg',
                          width: 2,
                          height: 2,
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          post['timestamp'] ?? '',
                          style: const TextStyle(
                            fontFamily: "Pretendard Variable",
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: GRAYSCALE_GREY_ORANGE,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/img/common/ic_like.svg',
                          width: 16,
                          height: 16,
                        ),
                        Text(
                          post['likeCounts'] ?? '',
                          style: const TextStyle(
                            fontFamily: "Pretendard Variable",
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: GRAYSCALE_GREY_ORANGE,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SvgPicture.asset(
                          'assets/img/common/ic_comment.svg',
                          width: 16,
                          height: 16,
                        ),
                        Text(
                          post['commentCounts'] ?? '',
                          style: const TextStyle(
                            fontFamily: "Pretendard Variable",
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: GRAYSCALE_GREY_ORANGE,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ],
                ),
                if (index != postList.length - 1) buildDivider(),
              ],
            );
          },
        ),
      ),
    );
  }
}
