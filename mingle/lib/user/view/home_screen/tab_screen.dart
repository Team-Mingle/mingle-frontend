import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/post/view/add_post_screen.dart';
import 'package:mingle/user/view/home_screen/search_screen.dart';

class TabScreen extends StatelessWidget {
  final List<Widget> tabContents;
  final String boardType;
  final String title;
  final List<String> tabs;

  const TabScreen({
    required this.tabContents,
    required this.title,
    required this.tabs,
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
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
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
                    tabs: List.generate(
                        tabs.length,
                        (index) => Tab(
                              child: Text(
                                tabs[index],
                                textAlign: TextAlign.center,
                              ),
                            ))

                    // [
                    //   Tab(
                    //     child: Text(
                    //       tab1,
                    //       textAlign: TextAlign.center,
                    //     ),
                    //   ),
                    //   Tab(
                    //     child: Text(
                    //       tab2,
                    //       textAlign: TextAlign.center,
                    //     ),
                    //   ),
                    //   Tab(
                    //     child: Text(
                    //       tab3,
                    //       textAlign: TextAlign.center,
                    //     ),
                    //   ),
                    //   Tab(
                    //     child: Text(
                    //       tab4,
                    //       textAlign: TextAlign.center,
                    //     ),
                    //   ),
                    // ],
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
          ],
        ),
      ),
    );
  }
}
