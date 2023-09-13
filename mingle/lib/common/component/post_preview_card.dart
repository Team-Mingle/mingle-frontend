import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';

class PostPreviewCard extends StatelessWidget {
  final List<Map<String, String>> postList;

  const PostPreviewCard({
    required this.postList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 20.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: postList.length,
        itemBuilder: (context, index) {
          final post = postList[index];

          return InkWell(
            onTap: () {
              print('Post ${post['title']} tapped');
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 32, 0),
                  child: Row(
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
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 12, 0),
                  child: Align(
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
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                  child: Row(
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
                          const SizedBox(width: 16.0),
                        ],
                      ),
                    ],
                  ),
                ),
                if (index != postList.length - 1)
                  const Divider(
                    color: Colors.grey,
                    thickness: 1.0,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
