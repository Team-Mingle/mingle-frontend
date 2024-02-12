import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/module/view/module_review_main_screen.dart';
import 'package:mingle/post/view/post_detail_screen.dart';
import 'package:mingle/user/view/home_screen/home_tab_screen.dart';
import 'package:mingle/post/view/lawn_tab_screen.dart';
import 'package:mingle/second_hand_market/view/market_tab_screen.dart';
import 'package:mingle/post/view/square_tab_screen.dart';
import 'package:mingle/timetable/view/timetable_tab_screen.dart';

class HomeRootTab extends StatefulWidget {
  final bool isFromLogin;
  const HomeRootTab({
    Key? key,
    this.isFromLogin = false,
  }) : super(key: key);

  @override
  State<HomeRootTab> createState() => _HomeRootTabState();
}

class _HomeRootTabState extends State<HomeRootTab> {
  int _selectedIndex = 0;

  final List<String> _normalSvgImagePaths = [
    'assets/img/root_screen/ic_home_unselected.svg',
    'assets/img/root_screen/ic_square_unselected.svg',
    'assets/img/root_screen/ic_lawn_unselected.svg',
    'assets/img/root_screen/ic_timetable_unselected.svg',
    'assets/img/root_screen/ic_market_unselected.svg',
  ];

  final List<String> _selectedSvgImagePaths = [
    'assets/img/root_screen/ic_home_selected.svg',
    'assets/img/root_screen/ic_square_selected.svg',
    'assets/img/root_screen/ic_lawn_selected.svg',
    'assets/img/root_screen/ic_timetable_selected.svg',
    'assets/img/root_screen/ic_market_selected.svg',
  ];

  final List<String> _labels = [
    '홈',
    '광장',
    '잔디밭',
    '시간표',
    '장터',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getSelectedScreen(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (_) => const HomeTabScreen()));

        return HomeTabScreen(
          isFromLogin: widget.isFromLogin,
        );
      case 1:
        return SquareTabScreen();
      case 2:
        return LawnTabScreen();
      case 3:
        return const ModuleReviewMainScreen();
      case 4:
        return MarketTabScreen();
      default:
        return const HomeTabScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getSelectedScreen(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        iconSize: 48.0,
        selectedFontSize: 10.0,
        unselectedFontSize: 10.0,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: GRAYSCALE_GRAY_03,
        items: List.generate(
          _normalSvgImagePaths.length,
          (index) {
            return BottomNavigationBarItem(
              icon: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: SvgPicture.asset(
                      _selectedIndex == index
                          ? _selectedSvgImagePaths[index]
                          : _normalSvgImagePaths[index],
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
              label: _labels[index],
            );
          },
        ),
        selectedLabelStyle: const TextStyle(color: Colors.black),
        unselectedLabelStyle: const TextStyle(color: GRAYSCALE_GRAY_03),
      ),
    );
  }
}
