import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/component/anonymous_textfield.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/view/image_detail_screen.dart';
import 'package:mingle/post/components/comment_card.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List imageList = [
      "https://cdn.pixabay.com/photo/2014/04/14/20/11/pink-324175_1280.jpg",
      "https://cdn.pixabay.com/photo/2014/02/27/16/10/flowers-276014_1280.jpg",
      "https://cdn.pixabay.com/photo/2012/03/01/00/55/flowers-19830_1280.jpg",
      "https://cdn.pixabay.com/photo/2015/06/19/20/13/sunset-815270_1280.jpg",
      "https://cdn.pixabay.com/photo/2016/01/08/05/24/sunflower-1127174_1280.jpg",
    ];

    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          body: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: SizedBox(
                height: 10.0,
                width: 10.0,
                child: InkWell(
                  child: Image.asset(
                      "assets/img/signup_screen/previous_screen_icon.png"),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ),
              titleSpacing: 0,
              title: const Text(
                "게시판 이름",
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: GRAYSCALE_GRAY_03),
              ),
              centerTitle: false,
              actions: [
                SvgPicture.asset("assets/img/post_screen/triple_dot_icon.svg"),
                const SizedBox(
                  width: 18.0,
                )
              ],
            ),
            body: CustomScrollView(slivers: [
              SliverList(
                  delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "제목제목제목",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      const Text(
                        "본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문\n본문\n본문\n본문\n본문\n본문\n본문\n본문\n",
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w400),
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 16.0,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                3,
                                (index) => Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) {
                                            return ImageDetailScreen(
                                              image: Image(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                  imageList[index],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      child: SizedBox(
                                        height: 130.0,
                                        width: 130.0,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(
                                              imageList[index],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: index < imageList.length - 1
                                          ? 4.0
                                          : 0.0,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      const Row(
                        children: [
                          Text(
                            "익명",
                            style: TextStyle(
                                color: GRAYSCALE_GRAY_04, fontSize: 12.0),
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Text(
                            "•",
                            style: TextStyle(
                                color: GRAYSCALE_GRAY_02, fontSize: 12.0),
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Text(
                            "07/17",
                            style: TextStyle(
                                color: GRAYSCALE_GRAY_03, fontSize: 12.0),
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Text(
                            "13:03",
                            style: TextStyle(
                                color: GRAYSCALE_GRAY_03, fontSize: 12.0),
                          ),
                          SizedBox(
                            width: 6.0,
                          ),
                          Text(
                            "조회",
                            style: TextStyle(
                                color: GRAYSCALE_GRAY_03, fontSize: 12.0),
                          ),
                          SizedBox(
                            width: 2.0,
                          ),
                          Text(
                            "26",
                            style: TextStyle(
                                color: GRAYSCALE_GRAY_03, fontSize: 12.0),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    const Divider(
                      thickness: 1.0,
                      height: 0.0,
                      color: GRAYSCALE_GRAY_01,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 23.0),
                      child: SizedBox(
                        height: 40.0,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "좋아요",
                                style: TextStyle(color: GRAYSCALE_GRAY_04),
                              ),
                              const SizedBox(
                                width: 4.0,
                              ),
                              const Text(
                                "0",
                                style: TextStyle(
                                    color: GRAYSCALE_GRAY_ORANGE_02,
                                    fontWeight: FontWeight.w600),
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
                              const Text(
                                "0",
                                style: TextStyle(
                                    color: GRAYSCALE_GRAY_ORANGE_02,
                                    fontWeight: FontWeight.w600),
                              ),
                              Expanded(child: Container()),
                              SvgPicture.asset(
                                  "assets/img/post_screen/thumbs_up_icon.svg"),
                              const SizedBox(
                                width: 34.0,
                              ),
                              SvgPicture.asset(
                                  "assets/img/post_screen/scrap_icon.svg"),
                            ]),
                      ),
                    ),
                    const Divider(
                      height: 0.0,
                      thickness: 2.0,
                      color: GRAYSCALE_GRAY_01,
                    ),
                    Container(
                      color: GRAYSCALE_GRAY_01_5,
                      height: 56.0,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 12.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  "•",
                                  style: TextStyle(
                                      color: GRAYSCALE_GRAY_03, fontSize: 11.0),
                                ),
                                Text("운영규칙을 위반하는 댓글은 삭제될 수 있습니다.",
                                    style: TextStyle(
                                        color: GRAYSCALE_GRAY_03,
                                        fontSize: 11.0))
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "•",
                                  style: TextStyle(
                                      color: GRAYSCALE_GRAY_03, fontSize: 11.0),
                                ),
                                Text("악의적인 글 혹은 댓글은 오른쪽 상단 버튼을 통해 신고가 가능합니다.",
                                    style: TextStyle(
                                        color: GRAYSCALE_GRAY_03,
                                        fontSize: 11.0))
                              ],
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Column(
                      children: List.generate(
                        3,
                        (index) => Column(
                          children: [
                            index > 0
                                ? const Divider(
                                    height: 24.0,
                                    thickness: 0.0,
                                  )
                                : Container(),
                            const CommentCard(
                                comment: "comment\ncomment\ncomment")
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ]))
            ]),
            bottomNavigationBar: Container(height: 56.0),
          ),
          bottomSheet: const AnonymousTextfield(),
        ),
      ),
    );
  }
}
