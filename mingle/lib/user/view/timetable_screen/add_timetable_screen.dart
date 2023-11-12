import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/user/view/my_page_screen/my_page_screen.dart';
import 'package:mingle/user/view/timetable_screen/self_add_timetable_screen.dart';
import 'package:mingle/user/view/timetable_screen/components/timetable_grid.dart';

class AddTimeTableScreen extends StatefulWidget {
  const AddTimeTableScreen({super.key});

  @override
  State<AddTimeTableScreen> createState() => _AddTimeTableScreenState();
}

class _AddTimeTableScreenState extends State<AddTimeTableScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 650)).then((_) {
      showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        isScrollControlled: false,
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 414.0,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 16.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: GRAYSCALE_GRAY_01,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Row(
                        children: [
                          const Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "강의명을 입력하세요",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Align(
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                'assets/img/common/ic_search.svg',
                                width: 24,
                                height: 24,
                              ),
                            ),
                            onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => const MyPageScreen())),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Divider(
                  height: 1,
                  color: GRAYSCALE_GRAY_01,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Text(
                  '최근 검색어 내역이 없습니다.',
                  style: TextStyle(
                    color: GRAYSCALE_GRAY_04,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            titleSpacing: 0.0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: SvgPicture.asset(
                      "assets/img/post_screen/cross_icon.svg",
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const Spacer(),
                const Text(
                  " 강의 추가하기",
                  style: TextStyle(
                      color: GRAYSCALE_GRAY_03,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400),
                ),
                const Spacer(),
                InkWell(
                  child: const Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: Text(
                      "직접 추가",
                      style: TextStyle(
                          color: PRIMARY_COLOR_ORANGE_01,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const AddDirectTimeTableScreen())),
                ),
              ],
            ),
            centerTitle: false, // Set centerTitle to false
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: const Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 11.0,
                ),
                Hero(
                  tag: "timetable",
                  child: TimeTableGrid(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
