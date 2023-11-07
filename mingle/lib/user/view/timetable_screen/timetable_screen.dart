import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/user/view/home_screen/search_screen.dart';
import 'package:mingle/user/view/my_page_screen/my_page_screen.dart';

class TimeTableHomeScreen extends StatefulWidget {
  const TimeTableHomeScreen({super.key});

  @override
  State<TimeTableHomeScreen> createState() => _TimeTableHomeScreenState();
}

class _TimeTableHomeScreenState extends State<TimeTableHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR_GRAY,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: AppBar(
          backgroundColor: BACKGROUND_COLOR_GRAY,
          elevation: 0, // 그림자 제거
          leading: IconButton(
            icon: Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/img/common/ic_list.svg',
                width: 24,
                height: 24,
              ),
            ),
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const MyPageScreen())),
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
      
    );
  }
}
