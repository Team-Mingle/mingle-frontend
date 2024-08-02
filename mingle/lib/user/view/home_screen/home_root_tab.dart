import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/module/view/module_review_main_screen.dart';
import 'package:mingle/post/view/post_detail_screen.dart';
import 'package:mingle/timetable/model/timetable_model.dart';
import 'package:mingle/timetable/provider/number_of_days_provider.dart';
import 'package:mingle/timetable/provider/pinned_timetable_provider.dart';
import 'package:mingle/timetable/provider/timetable_grid_height_divider_value_provider.dart';
import 'package:mingle/timetable/provider/timetable_grid_height_provider.dart';
import 'package:mingle/timetable/provider/timetable_grid_width_provider.dart';
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

class HomeRootTab extends ConsumerStatefulWidget {
  bool isFromLogin;
  int index;
  HomeRootTab({
    Key? key,
    this.isFromLogin = false,
    this.index = 0,
  }) : super(key: key);

  @override
  ConsumerState<HomeRootTab> createState() => _HomeRootTabState();
}

class _HomeRootTabState extends ConsumerState<HomeRootTab> {
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
  final List<CustomScrollController> _controllers = [
    CustomScrollController(),
    CustomScrollController(),
    CustomScrollController(),
    CustomScrollController(),
    CustomScrollController(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _selectedIndex = widget.index;
    });
  }

  void _onItemTapped(int index) {
    if (index == _selectedIndex) {
      _controllers[index].scrollUp();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Widget _getSelectedScreen(int selectedIndex, double bottomPaddingHeight) {
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
      case 3:
        return TimeTableHomeScreen(
          bottomPaddingHeight: bottomPaddingHeight,
        );
      case 4:
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
    final availableHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top + kToolbarHeight) -
        TIMETABLE_BOTTOM_WIDGETS_HEIGHT -
        (MediaQuery.of(context).padding.bottom + kBottomNavigationBarHeight) -
        TIMETABLE_TOP_PADDING -
        TIMETABLE_BOTTOM_PADDING;

    Future.delayed(Duration.zero, () {
      if (ref.read(timetableGridWidthProvider) != 0) {
        return;
      }
      ref.read(timetableGridWidthProvider.notifier).update(
            (state) =>
                (MediaQuery.of(context).size.width - TIMETABLE_SIDE_PADDINGS),
          );
    });
    Future.delayed(Duration.zero, () {
      if (ref.read(timetableGridHeightProvider) != 0) {
        return;
      }
      ref
          .read(timetableGridHeightProvider.notifier)
          .update((state) => availableHeight);
    });
    Future.delayed(Duration.zero, () async {
      await ref.read(pinnedTimetableProvider.notifier).fetchPinnedTimetable();
      final timetable = ref.read(pinnedTimetableProvider);

      if (timetable is TimetableModel) {
        print("no of days: ${(timetable).getNumberOfDays()}");

        ref
            .read(numberOfDaysProvider.notifier)
            .update((state) => timetable.getNumberOfDays());
      }
    });
    // Future.delayed(Duration.zero, () {
    //   ref.read(pinnedTimetableProvider.notifier).fetchPinnedTimetable();
    //   TimetableModel? pinnedTimetable = ref.read(pinnedTimetableProvider);
    //   if (pinnedTimetable != null) {
    //     ref.read(timetableGridHeightDividerValueProvider.notifier).update(
    //         (state) => pinnedTimetable.getGridTotalHeightDividerValue());
    //   }
    // });
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: _getSelectedScreen(
            _selectedIndex, MediaQuery.of(context).padding.bottom),
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
                      padding: const EdgeInsets.only(bottom: 0.0),
                      child: SvgPicture.asset(
                        _selectedIndex == index
                            ? _selectedSvgImagePaths[index]
                            : _normalSvgImagePaths[index],
                        width: 28,
                        height: 28,
                      ),
                    ),
                  ],
                ),
                label: _labels[index],
              );
            },
          ),
          selectedLabelStyle:
              const TextStyle(color: Colors.black, fontSize: 10.0, height: 1),
          unselectedLabelStyle: const TextStyle(
              color: GRAYSCALE_GRAY_03, fontSize: 10.0, height: 1),
        ),
      ),
    );
  }
}
