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

// class HomeTabController {
//   void Function() scrollUp = () {};
// }

// class LawnTabController {
//   void Function() scrollUp = () {};
// }

// class SquareTabController {
//   void Function() scrollUp = () {};
// }

// class MarketTabController {
//   void Function() scrollUp = () {};
// }

class CustomScrollController {
  void Function() scrollUp = () {};
}

class HomeRootTab extends StatefulWidget {
  bool isFromLogin;
  HomeRootTab({
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
    //'assets/img/root_screen/ic_timetable_unselected.svg',
    'assets/img/root_screen/ic_market_unselected.svg',
  ];

  final List<String> _selectedSvgImagePaths = [
    'assets/img/root_screen/ic_home_selected.svg',
    'assets/img/root_screen/ic_square_selected.svg',
    'assets/img/root_screen/ic_lawn_selected.svg',
    //'assets/img/root_screen/ic_timetable_selected.svg',
    'assets/img/root_screen/ic_market_selected.svg',
  ];

  final List<String> _labels = [
    '홈',
    '광장',
    '잔디밭',
    //'시간표',
    '장터',
  ];
  final List<CustomScrollController> _controllers = [
    CustomScrollController(),
    CustomScrollController(),
    CustomScrollController(),
    //CustomScrollController(),
    CustomScrollController(),
  ];

  void _onItemTapped(int index) {
    if (index == _selectedIndex) {
      _controllers[index].scrollUp();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Widget _getSelectedScreen(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (_) => const HomeTabScreen()));
        return HomeTabScreen(
          controller: _controllers[0],
          setIsFromLogin: setIsFromLogin,
          changeTabIndex: (int index) {
            _onItemTapped(index);
          },
        );
      case 1:
        return SquareTabScreen(
          controller: _controllers[1],
          changeTabIndex: (int index) {
            _onItemTapped(index);
          },
        );
      case 2:
        return LawnTabScreen(
          controller: _controllers[2],
          changeTabIndex: (int index) {
            _onItemTapped(index);
          },
        );
      // case 3:
      //   return const ModuleReviewMainScreen();
      case 3:
        return MarketTabScreen(
          controller: _controllers[3],
          changeTabIndex: (int index) {
            _onItemTapped(index);
          },
        );
      default:
        return HomeTabScreen(
          controller: _controllers[0],
          changeTabIndex: (int index) {
            _onItemTapped(index);
          },
        );
    }
  }

  void setIsFromLogin() {
    setState(() {
      widget.isFromLogin = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
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
      ),
    );
  }
}
