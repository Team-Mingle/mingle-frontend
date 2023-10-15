import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mingle/post/view/post_detail_screen.dart';
import 'package:mingle/user/view/home_screen/home_tab_screen.dart';
import 'package:mingle/user/view/home_screen/lawn_tab_screen.dart';
import 'package:mingle/user/view/home_screen/market_tab_screen.dart';
import 'package:mingle/user/view/home_screen/square_tab_screen.dart';
import 'package:mingle/user/view/home_screen/view/home_tab_screen.dart';

class HomeRootTab extends StatefulWidget {
  const HomeRootTab({
    Key? key,
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
    'assets/img/root_screen/ic_market_unselected.svg',
  ];

  final List<String> _selectedSvgImagePaths = [
    'assets/img/root_screen/ic_home_selected.svg',
    'assets/img/root_screen/ic_square_selected.svg',
    'assets/img/root_screen/ic_lawn_selected.svg',
    'assets/img/root_screen/ic_market_selected.svg',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getSelectedScreen(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return const HomeTabScreen();
      case 1:
        return SquareTabScreen();
      case 2:
        return LawnTabScreen();
      case 3:
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
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        backgroundColor: Colors.white,
        items: List.generate(
          _normalSvgImagePaths.length,
          (index) {
            return BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SvgPicture.asset(
                  _selectedIndex == index
                      ? _selectedSvgImagePaths[index] // 선택된 아이콘 이미지
                      : _normalSvgImagePaths[index], // 기본 아이콘 이미지
                  width: 24,
                  height: 24,
                ),
              ),
              label: '', // 라벨을 빈 문자열로 설정
            );
          },
        ),
      ),
    );
  }
}
