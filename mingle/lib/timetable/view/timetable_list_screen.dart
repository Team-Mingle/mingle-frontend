import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/timetable/components/add_new_timetable_widget.dart';
import 'package:mingle/timetable/components/timetable_list.dart';
import 'package:mingle/timetable/model/timetable_list_model.dart';
import 'package:mingle/timetable/model/timetable_preview_model.dart';
import 'package:mingle/timetable/repository/timetable_repository.dart';
import 'package:mingle/timetable/view/self_add_timetable_screen.dart';

class MyTimeTableListScreen extends ConsumerStatefulWidget {
  const MyTimeTableListScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<MyTimeTableListScreen> createState() =>
      _MyTimeTableListScreenState();
}

class _MyTimeTableListScreenState extends ConsumerState<MyTimeTableListScreen> {
  Map<String, List<TimetablePreviewModel>> timetables = {};
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTimetables();
    print(timetables);
  }

  void getTimetables() async {
    setState(() {
      isLoading = true;
    });
    final result = (await ref.read(timetableRepositoryProvider).getTimetables())
        .timetablePreviewResponseMap;
    setState(() {
      timetables = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
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
                    fontSize: 16.0,
                    letterSpacing: -0.02,
                    height: 1.5,
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
                        letterSpacing: -0.01,
                        height: 1.4,
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
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: PRIMARY_COLOR_ORANGE_01,
                  ),
                )
              : SingleChildScrollView(
                  // physics: const AlwaysScrollableScrollPhysics(),
                  child: Center(
                    child: Column(
                        children:
                            List.generate(timetables.keys.length, (index) {
                      final String key = timetables.keys.elementAt(index);
                      final List<TimetablePreviewModel> values =
                          timetables[key]!;
                      return TimetableList(
                          semester:
                              TimetableListModel.convertKeyToSemester(key),
                          timetables: values);
                    })
                        // [
                        //   TimetableList(),
                        //   SizedBox(
                        //     height: 56.0,
                        //   ),
                        //   TimetableList(),
                        //   SizedBox(
                        //     height: 56.0,
                        //   ),
                        //   TimetableList(),
                        //   SizedBox(
                        //     height: 56.0,
                        //   ),
                        // ],
                        ),
                  ),
                ),
        ),
      ),
    );
  }
}
