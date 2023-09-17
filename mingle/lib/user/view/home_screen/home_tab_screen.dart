import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mingle/common/component/post_card.dart';
import 'package:mingle/common/const/colors.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  List imageList = [
    "https://cdn.pixabay.com/photo/2014/04/14/20/11/pink-324175_1280.jpg",
    "https://cdn.pixabay.com/photo/2014/02/27/16/10/flowers-276014_1280.jpg",
    "https://cdn.pixabay.com/photo/2012/03/01/00/55/flowers-19830_1280.jpg",
    "https://cdn.pixabay.com/photo/2015/06/19/20/13/sunset-815270_1280.jpg",
    "https://cdn.pixabay.com/photo/2016/01/08/05/24/sunflower-1127174_1280.jpg",
  ];

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
              onPressed: () {},
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
              onPressed: () {},
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
                  sliderWidget(),
                  const SizedBox(height: 8.0), 
                  sliderIndicator(),
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
              PostCard(title: '지금 광장에서는'),
              const SizedBox(height: 40.0),
              PostCard(title: '지금 잔디밭에서는'),
              const SizedBox(height: 40.0),
              PostCard(title: '불타오르는 게시글'),
              const SizedBox(height: 169),
            ],
          ),
        ),
      ),
    );
  }

  // 위젯 분리 필요
  Widget sliderWidget() {
    return CarouselSlider(
      carouselController: _controller,
      items: imageList.map(
        (imgLink) {
          return Builder(
            builder: (context) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(10.0), // 여기서 borderRadius를 설정합니다.
                  child: Image(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      imgLink,
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
