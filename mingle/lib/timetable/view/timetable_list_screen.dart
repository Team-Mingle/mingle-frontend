import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/timetable/components/add_new_timetable_widget.dart';
import 'package:mingle/timetable/components/timetable_list.dart';
import 'package:mingle/timetable/view/self_add_timetable_screen.dart';

class MyTimeTableListScreen extends ConsumerWidget {
  const MyTimeTableListScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  '시간표 목록',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                InkWell(
                  child: const Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Text(
                      "시간표 추가",
                      style: TextStyle(
                        color: PRIMARY_COLOR_ORANGE_01,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return const Center(
                          child: AddNewTimetableWidget(),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            centerTitle: false, // Set centerTitle to false
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: const SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  TimetableList(),
                  SizedBox(
                    height: 56.0,
                  ),
                  TimetableList(),
                  SizedBox(
                    height: 56.0,
                  ),
                  TimetableList(),
                  SizedBox(
                    height: 56.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
