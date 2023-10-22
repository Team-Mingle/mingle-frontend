import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/component/anonymous_textfield.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/post/components/comment_card.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';
import 'package:url_launcher/url_launcher.dart';

class SecondHandPostDetailScreen extends StatefulWidget {
  const SecondHandPostDetailScreen({super.key});

  @override
  State<SecondHandPostDetailScreen> createState() =>
      _SecondHandPostDetailScreenState();
}

class _SecondHandPostDetailScreenState
    extends State<SecondHandPostDetailScreen> {
  List imageList = [
    "https://cdn.pixabay.com/photo/2014/04/14/20/11/pink-324175_1280.jpg",
    "https://cdn.pixabay.com/photo/2014/02/27/16/10/flowers-276014_1280.jpg",
    "https://cdn.pixabay.com/photo/2012/03/01/00/55/flowers-19830_1280.jpg",
    "https://cdn.pixabay.com/photo/2015/06/19/20/13/sunset-815270_1280.jpg",
    "https://cdn.pixabay.com/photo/2016/01/08/05/24/sunflower-1127174_1280.jpg",
  ];
  int _current = 0;
  bool _isReserved = false;
  bool _isLiked = false;
  final CarouselController _controller = CarouselController();
  final EdgeInsets _contentPadding =
      const EdgeInsets.symmetric(horizontal: 20.0);
  final Divider _contentDivider = const Divider(
    height: 32.0,
    thickness: 0.0,
    color: GRAYSCALE_GRAY_01,
  );
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                "거래 계시판",
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: GRAYSCALE_GRAY_03),
              ),
              centerTitle: false,
              actions: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        String selectedOption = '판매중'; // 기본 선택 항목

                        return Container(
                          height: 248,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 32.0,
                                ),
                                ListTile(
                                  title: Center(
                                    child: Text(
                                      '판매중',
                                      style: TextStyle(
                                        fontWeight: selectedOption == '판매중'
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                    selectedOption = '판매중'; // 선택한 항목 설정
                                    print("판매중");
                                  },
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                ListTile(
                                  title: Center(
                                    child: Text(
                                      '예약중',
                                      style: TextStyle(
                                        fontWeight: selectedOption == '예약중'
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                    selectedOption = '예약중'; // 선택한 항목 설정
                                    print("예약중");
                                  },
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                ListTile(
                                  title: Center(
                                    child: Text(
                                      '판매완료',
                                      style: TextStyle(
                                        fontWeight: selectedOption == '판매완료'
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                    selectedOption = '판매완료'; // 선택한 항목 설정
                                    print("판매완료");
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      backgroundColor: Colors.transparent,
                    );
                  },
                  child: SvgPicture.asset(
                      "assets/img/post_screen/triple_dot_icon.svg"),
                ),
                const SizedBox(
                  width: 18.0,
                ),
                const SizedBox(
                  width: 18.0,
                )
              ],
            ),
            body: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: _contentPadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 8.0,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 320.0,
                              child: Stack(
                                children: [
                                  sliderWidget(),
                                  sliderIndicator(),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 24.0,
                            ),
                            const Text(
                              "쓴지 3일 된 책상",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            const Text(
                              "30 hkd",
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      _contentDivider,
                      Padding(
                        padding: _contentPadding,
                        child: const Text(
                            "쓴 지 3일됐는데 급하게 처분합니다\n하자 별로 없어요\n만약 3줄이 넘어간다면\n아래 선과 16px을 유지한 상태로 필드가\n늘어나게 해 주세요"),
                      ),
                      _contentDivider,
                      Padding(
                        padding: _contentPadding,
                        child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "희망 거래장소/시간대",
                                style: TextStyle(
                                    color: GRAYSCALE_GRAY_03,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Text("밍글대 밍끼마당, 주말은 x\n평일 월 화 선호")
                            ]),
                      ),
                      _contentDivider,
                      Padding(
                        padding: _contentPadding.copyWith(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "오픈채팅방 링크",
                                style: TextStyle(
                                    color: GRAYSCALE_GRAY_03,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                width: 16.0,
                              ),
                              InkWell(
                                  onTap: () async {
                                    final Uri url =
                                        Uri.parse('https://flutter.dev');

                                    if (!await launchUrl(url)) {
                                      throw Exception('Could not launch $url');
                                    }
                                  },
                                  child: const Text(
                                    "open.kakao/minglefighting",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline),
                                  ))
                            ]),
                      ),
                      const Divider(
                        height: 16.0,
                        thickness: 0.0,
                      ),
                      Padding(
                        padding: _contentPadding.copyWith(bottom: 8.0),
                        child: const Row(
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
                      ),
                      Column(
                        children: [
                          const Divider(
                            thickness: 1.0,
                            height: 0.0,
                            color: GRAYSCALE_GRAY_01,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 23.0),
                            child: SizedBox(
                              height: 50.0,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "찜",
                                      style:
                                          TextStyle(color: GRAYSCALE_GRAY_04),
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
                                      style:
                                          TextStyle(color: GRAYSCALE_GRAY_04),
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
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _isLiked = !_isLiked;
                                        });
                                      },
                                      child: SvgPicture.asset(
                                        _isLiked
                                            ? "assets/img/second_hand_market_screen/heart_icon_filled.svg"
                                            : "assets/img/second_hand_market_screen/heart_icon.svg",
                                      ),
                                    )
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 12.0,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "•",
                                        style: TextStyle(
                                            color: GRAYSCALE_GRAY_03,
                                            fontSize: 11.0),
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
                                            color: GRAYSCALE_GRAY_03,
                                            fontSize: 11.0),
                                      ),
                                      Text(
                                          "악의적인 글 혹은 댓글은 오른쪽 상단 버튼을 통해 신고가 가능합니다.",
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
                    ],
                  ),
                )
              ],
            ),
            bottomNavigationBar: Container(height: 56.0),
          ),
          bottomSheet: const AnonymousTextfield(),
        ),
      ),
    );
  }

  Widget sliderWidget() {
    return CarouselSlider(
      carouselController: _controller,
      items: imageList.map(
        (imgLink) {
          return Builder(
            builder: (context) {
              return Stack(children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 320.0,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(8.0), // 여기서 borderRadius를 설정합니다.
                    child: Image(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        imgLink,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _isReserved = !_isReserved;
                    });
                  },
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(8.0), // 여기서 borderRadius를 설정합니다.
                    child: Container(
                      color: _isReserved
                          ? Colors.black.withOpacity(0.6)
                          : Colors.transparent,
                      child: Center(
                        child: Text(
                          _isReserved ? "예약중" : "",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                )
              ]);
            },
          );
        },
      ).toList(),
      options: CarouselOptions(
        height: 320,
        viewportFraction: 1.0,
        autoPlay: false,
        onPageChanged: (index, reason) {
          setState(() {
            _current = index;
          });
        },
      ),
    );
  }

  // 위젯 분리 필요
  Widget sliderIndicator() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imageList.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: _current == entry.key ? 24.0 : 6.0, // 선택된 인디케이터는 가로로 길게
              height: 6,
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle, // BoxShape을 rectangle로 변경
                borderRadius: BorderRadius.circular(3.0),
                color: _current == entry.key
                    ? PRIMARY_COLOR_ORANGE_02
                    : GRAYSCALE_GRAY_02,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
