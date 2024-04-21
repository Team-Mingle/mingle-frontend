import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/module/model/course_model.dart';
import 'package:mingle/module/view/add_module_review_screen.dart';
import 'package:mingle/module/view/module_details_screen.dart';
import 'package:mingle/timetable/components/timetable_grid.dart';
import 'package:mingle/timetable/model/timetable_list_model.dart';
import 'package:mingle/timetable/model/timetable_model.dart';
import 'package:mingle/timetable/repository/timetable_repository.dart';

class FriendTimetableScreen extends ConsumerStatefulWidget {
  final int friendId;
  const FriendTimetableScreen({super.key, required this.friendId});

  @override
  ConsumerState<FriendTimetableScreen> createState() =>
      _FriendTimetableScreenState();
}

class _FriendTimetableScreenState extends ConsumerState<FriendTimetableScreen> {
  List<TimetableModel> timetables = [];
  TimetableModel? currentTimetable;
  List<Widget> addedClasses = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTimetables();
  }

  void getTimetables() async {
    try {
      List<TimetableModel> friendTimetables = (await ref
              .read(timetableRepositoryProvider)
              .getFriendTimetables(friendId: widget.friendId))
          .friendTimetableDetailList;
      TimetableModel? selectedTimetable =
          friendTimetables.isEmpty ? null : friendTimetables[0];
      List<CourseModel> courses = selectedTimetable == null
          ? []
          : selectedTimetable.coursePreviewDtoList;
      generateClassWidgets(courses);
      setState(() {
        timetables = friendTimetables;
        currentTimetable =
            friendTimetables.isEmpty ? null : friendTimetables[0];
      });
    } on DioException catch (e) {
      print(e);
    }
  }

  void generateClassWidgets(List<CourseModel> courses) {
    List<Widget> coursesToBeAdded = [];
    for (CourseModel course in courses) {
      coursesToBeAdded
          .addAll(course.generateClasses(() => showCourseDetailModal(course)));
    }
    setState(() {
      addedClasses = coursesToBeAdded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        shape: const Border(
            bottom: BorderSide(color: GRAYSCALE_GRAY_01, width: 1)),
        backgroundColor: Colors.white,
        titleSpacing: 0.0,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: const ImageIcon(
              AssetImage("assets/img/module_review_screen/back_tick_icon.png"),
              color: GRAYSCALE_BLACK,
            ),
            color: GRAYSCALE_BLACK,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: const Text(
          "닉네임의 시간표",
          style: TextStyle(fontSize: 16.0, letterSpacing: -0.32),
        ),
        actions: [
          IconButton(
            icon: Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/img/common/ic_setting.svg',
                width: 24,
                height: 24,
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder(
          future: ref
              .watch(timetableRepositoryProvider)
              .getFriendTimetables(friendId: widget.friendId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: PRIMARY_COLOR_ORANGE_01,
                ),
              );
            }
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: renderSelectedSemesterWidget(),
                    ),
                  ),
                ),
                TimeTableGrid(
                  isFull: true,
                  addedClasses: addedClasses,
                ),
              ],
            );
          }),
    );
  }

  List<Widget> renderSelectedSemesterWidget() {
    return List.generate((2 * timetables.length) - 1, (index) {
      if (index % 2 != 0) {
        return const SizedBox(
          width: 4.0,
        );
      }
      TimetableModel timetable = timetables[index ~/ 2];
      bool isSelected = currentTimetable == timetable;
      return GestureDetector(
        onTap: () {
          generateClassWidgets(timetable.coursePreviewDtoList);
          setState(() {
            currentTimetable = timetable;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
              border: Border.all(
                  color:
                      isSelected ? PRIMARY_COLOR_ORANGE_01 : GRAYSCALE_GRAY_03),
              borderRadius: BorderRadius.circular(16.0)),
          child: Text(
            TimetableListModel.convertKeyToSemester(timetable.semester),
            style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color:
                    isSelected ? PRIMARY_COLOR_ORANGE_01 : GRAYSCALE_GRAY_02),
          ),
        ),
      );
    });
  }

  void showCourseDetailModal(CourseModel currentCourse) {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      isScrollControlled: false,
      context: context,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            height: 311.0,
            color: Colors.white,
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentCourse.name,
                  style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.32),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Text(
                  currentCourse.courseCode,
                  style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.32),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Text(
                  "${currentCourse.professor} ${currentCourse.getStartTimes()}",
                  style: const TextStyle(
                      color: GRAYSCALE_GRAY_04, letterSpacing: -0.14),
                ),
                const Divider(
                  height: 32.0,
                  color: GRAYSCALE_GRAY_01_5,
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ModuleDetailsScreen(
                        courseId: currentCourse.id,
                        moduleName: currentCourse.name,
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14.0),
                    child: Text(
                      "강의상세/ 강의평 보기",
                      style: TextStyle(fontSize: 16.0, letterSpacing: -0.32),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => AddModuleReviewScreen(
                              moduleId: currentCourse.id,
                              moduleName: currentCourse.name,
                            )),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14.0),
                    child: Text(
                      "강의평 작성하기",
                      style: TextStyle(fontSize: 16.0, letterSpacing: -0.32),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
