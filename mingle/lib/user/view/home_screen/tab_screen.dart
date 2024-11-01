import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/post/view/add_post_screen.dart';
import 'package:mingle/user/view/home_screen/search_screen.dart';

class TabScreen extends StatelessWidget {
  final List<Widget> tabContents;
  final String boardType;
  final String title;
  final String subtitle;
  final String tab1;
  final String tab2;
  final String tab3;
  final String tab4;

  const TabScreen({
    required this.tabContents,
    required this.title,
    required this.subtitle,
    required this.tab1,
    required this.tab2,
    required this.tab3,
    required this.tab4,
    Key? key,
    required this.boardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabContents.length,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 57,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: GRAYSCALE_GRAY_03,
                      fontSize: 11,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      letterSpacing: -0.03,
                      height: 1.5,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
              const Spacer(),
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
                    MaterialPageRoute(
                        builder: (context) => const SearchScreen()),
                  );
                },
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40.0),
            child: Stack(
              children: [
                const Column(
                  children: [
                    SizedBox(
                      height: 46,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Divider(
                        height: 2.5,
                        color: GRAYSCALE_GRAY_02,
                      ),
                    ),
                  ],
                ),
                TabBar(
                  indicatorColor: PRIMARY_COLOR_ORANGE_01,
                  indicatorWeight: 2,
                  indicatorSize: TabBarIndicatorSize.tab,
                  // indicatorPadding: const EdgeInsets.all(5),
                  labelColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  labelStyle: const TextStyle(
                    fontSize: 14.0,
                    letterSpacing: -0.01,
                    height: 1.4,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelColor: GRAYSCALE_GRAY_04,
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 14.0,
                    letterSpacing: -0.01,
                    height: 1.4,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w400,
                  ),
                  tabs: [
                    Tab(
                      child: Text(
                        tab1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Tab(
                      child: Text(
                        tab2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Tab(
                      child: Text(
                        tab3,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Tab(
                      child: Text(
                        tab4,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            TabBarView(
              physics: const AlwaysScrollableScrollPhysics(),
              // physics: ,
              children: tabContents.map((tabContent) {
                return tabContent;
              }).toList(),
            ),
            Positioned(
              right: 16.0,
              bottom: 16.0,
              child: FloatingActionButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AddPostScreen(
                      boardType: boardType,
                    ),
                  ),
                ),
                backgroundColor: PRIMARY_COLOR_ORANGE_02,
                shape: const CircleBorder(),
                child: SvgPicture.asset(
                  'assets/img/common/pen_icon.svg',

                  // width: 55,
                  // height: 55,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
