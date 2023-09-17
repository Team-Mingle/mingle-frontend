import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';

class TabScreen extends StatelessWidget {
  final List<Widget> tabContents;
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabContents.length,
      child: Scaffold(
        appBar: AppBar(
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
                      color: GRAYSCALE_GRAY_02,
                      fontSize: 11,
                      fontFamily: 'Pretendard Variable',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      color: GRAYSCALE_BLACK_GRAY,
                      fontSize: 20,
                      fontFamily: 'Pretendard Variable',
                      fontWeight: FontWeight.w500,
                      height: 0,
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
                onPressed: () {},
              ),
            ],
          ),
          bottom: TabBar(
            indicatorColor: PRIMARY_COLOR_ORANGE_01,
            // indicatorPadding: const EdgeInsets.all(5),
            labelColor: Colors.black,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            labelStyle: const TextStyle(
              fontSize: 14,
              fontFamily: 'Pretendard Variable',
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelColor: GRAYSCALE_GRAY_04,
            unselectedLabelStyle: const TextStyle(
              fontSize: 14,
              fontFamily: 'Pretendard Variable',
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
        ),
        body: TabBarView(
          children: tabContents,
        ),
      ),
    );
  }
}
