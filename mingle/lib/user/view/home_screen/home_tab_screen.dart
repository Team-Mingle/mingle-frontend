import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mingle/common/component/post_card.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/user/model/banner_model.dart';
import 'package:mingle/user/provider/banner_provider.dart';
import 'package:mingle/post/provider/post_provider.dart';
import 'package:mingle/user/view/home_screen/search_screen.dart';
import 'package:mingle/user/view/my_page_screen/my_page_screen.dart';
import 'dart:convert';

import 'package:mingle/user/view/my_page_screen/terms_and_conditions_screen.dart';

class HomeTabScreen extends ConsumerStatefulWidget {
  final bool isFromLogin;
  const HomeTabScreen({
    Key? key,
    this.isFromLogin = false,
  }) : super(key: key);

  @override
  ConsumerState<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends ConsumerState<HomeTabScreen> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  late final Future<List<BannerModel>> _bannerProvider;

  @override
  void initState() {
    if (widget.isFromLogin) {
      Future.delayed(const Duration(seconds: 0)).then((_) {
        showModalBottomSheet<void>(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              height: 512.0,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 40.0,
                        ),
                        const Text(
                          "시작하기 전에",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          "더 나은 밍글을 위해 약속하기",
                          style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w700,
                              backgroundColor:
                                  PRIMARY_COLOR_ORANGE_02.withOpacity(0.4)),
                        ),
                        const SizedBox(
                          height: 42.0,
                        ),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "1.",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: GRAYSCALE_GRAY_03),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "서로 존중을 주고 받아요",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  "서로 비난하지 않고 함께 존중하는 커뮤니티를 만들어가요. ",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        const Divider(
                          height: 32.0,
                          thickness: 1.0,
                          color: GRAYSCALE_GRAY_01,
                        ),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "2.",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: GRAYSCALE_GRAY_03),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "서로 도움을 주고 받아요",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  "궁금한 점들을 질문하고, 내가 줄 수 있는 도움을 나눠봐요.",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        const Divider(
                          height: 32.0,
                          thickness: 1.0,
                          color: GRAYSCALE_GRAY_01,
                        ),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "2.",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: GRAYSCALE_GRAY_03),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "이용규칙을 지켜주세요.",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  "이용규칙을 지키며 더 나은 커뮤니티를 만들어가요.",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        const Divider(
                          height: 36.0,
                          thickness: 1.0,
                          color: GRAYSCALE_GRAY_01,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const TermsAndConditionsScreen())),
                    child: const Text(
                      "자세한 운영정책 보러가기",
                      style: TextStyle(
                          color: GRAYSCALE_GRAY_04,
                          fontSize: 11.0,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 48.0,
                        decoration: BoxDecoration(
                          color: PRIMARY_COLOR_ORANGE_02,
                          border: Border.all(color: PRIMARY_COLOR_ORANGE_02),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Center(child: Text("확인했습니다.")),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      });
    }
    _bannerProvider = ref.read(bannerProvider.future);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR_GRAY,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48.0),
        child: AppBar(
          backgroundColor: BACKGROUND_COLOR_GRAY,
          elevation: 0, // 그림자 제거
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
              icon: Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/img/home_screen/ic_home_myPage.svg',
                  width: 24,
                  height: 24,
                ),
              ),
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const MyPageScreen())),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/img/home_screen/ic_home_search.svg',
                  width: 24,
                  height: 24,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/img/home_screen/ic_home_notification.svg',
                    width: 28,
                    height: 28,
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
      // 스크롤 뷰
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 16.0),
              Column(
                children: [
                  FutureBuilder<List<BannerModel>>(
                    future: _bannerProvider,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return sliderWidget(snapshot.data!);
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              Column(
                children: [
                  Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            "소식 바로 보기",
                            style: TextStyle(
                              fontFamily: "Pretendard Variable",
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: GRAYSCALE_BLACK,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12.0),
                      Row(
                        children: [
                          customButton('학생회', () {
                            // 첫 번째 버튼의 동작 추가
                          }),
                          const SizedBox(width: 10.0),
                          customButton('밍글 소식', () {
                            // 두 번째 버튼의 동작 추가
                          }),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 32.0),
              PostCard(
                title: '지금 광장에서는',
                data: ref.watch(totalRecentPostProvider),
              ),
              const SizedBox(height: 40.0),
              PostCard(
                title: '지금 잔디밭에서는',
                data: ref.watch(univRecentPostProvider),
              ),
              const SizedBox(height: 40.0),
              PostCard(
                title: '불타오르는 게시글',
                data: ref.watch(bestPostProvider),
              ),
              const SizedBox(height: 169),
            ],
          ),
        ),
      ),
    );
  }

  // 위젯 분리 필요
  Widget sliderWidget(List<BannerModel> bannerList) {
    return CarouselSlider(
      carouselController: _controller,
      items: bannerList.map(
        (banner) {
          return Builder(
            builder: (context) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      banner.imgUrl,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ).toList(),
      options: CarouselOptions(
        height: 160,
        viewportFraction: 1.0,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        onPageChanged: (index, reason) {
          setState(() {
            _current = index;
          });
        },
      ),
    );
  }

  // 위젯 분리 필요
  Widget sliderIndicator(List<BannerModel> bannerList) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: bannerList.asMap().entries.map((entry) {
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

  Widget customButton(String buttonText, VoidCallback onPressed) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero, // 패딩 제거
          minimumSize: const Size(0, 44),
          backgroundColor: Colors.white,
          elevation: 0.1, // 그림자
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontFamily: "Pretendard Variable",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: GRAYSCALE_GRAY_04,
                  height: 17 / 14,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: SvgPicture.asset(
                'assets/img/home_screen/ic_home_right_direction.svg',
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
