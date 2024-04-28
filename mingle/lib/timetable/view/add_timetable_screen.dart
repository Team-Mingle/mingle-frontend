import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/module/model/course_model.dart';
import 'package:mingle/module/view/add_module_review_screen.dart';
import 'package:mingle/module/view/module_details_screen.dart';
import 'package:mingle/timetable/components/search_course_modal.dart';
import 'package:mingle/timetable/model/class_model.dart';
import 'package:mingle/timetable/model/timetable_model.dart';
import 'package:mingle/timetable/provider/pinned_timetable_provider.dart';
import 'package:mingle/timetable/repository/timetable_repository.dart';
import 'package:mingle/user/view/my_page_screen/my_page_screen.dart';
import 'package:mingle/timetable/view/self_add_timetable_screen.dart';
import 'package:mingle/timetable/components/timetable_grid.dart';

class AddTimeTableScreen extends ConsumerStatefulWidget {
  final Function addClass;
  List<Widget> addedClasses;
  AddTimeTableScreen({
    super.key,
    required this.addClass,
    required this.addedClasses,
  });

  @override
  ConsumerState<AddTimeTableScreen> createState() => _AddTimeTableScreenState();
}

class _AddTimeTableScreenState extends ConsumerState<AddTimeTableScreen> {
  @override
  void initState() {
    getClasses();
    Future.delayed(const Duration(milliseconds: 650)).then((_) {
      showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return AnimatedPadding(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SearchCourseModalWidget(
              addClass: widget.addClass,
              addClassesAtAddTimeTableScreen: addClassesAtAddTimeTableScreen,
            ),
          );
        },
      );
    });
    super.initState();
  }

  void addClassesAtAddTimeTableScreen(
      CourseModel courseModel, bool overrideValidation) {
    if (overrideValidation) {
      print("im overriden");
      getClasses();
      return;
    }
    setState(() {
      widget.addedClasses.addAll(courseModel.generateClasses(() {}));
    });
  }

  void getClasses() async {
    // await ref.read(pinnedTimetableIdProvider.notifier).fetchPinnedTimetable();

    TimetableModel currentTimetable = await ref
        .read(timetableRepositoryProvider)
        .getTimetable(timetableId: ref.read(pinnedTimetableIdProvider)!);
    List<CourseModel> courses = currentTimetable.coursePreviewDtoList;
    List<Widget> coursesToBeAdded = [];
    for (CourseModel course in courses) {
      coursesToBeAdded.addAll(course.generateClasses(() {}));
    }
    setState(() {
      widget.addedClasses = coursesToBeAdded;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(t);
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            automaticallyImplyLeading: true,
            leading: Align(
              alignment: Alignment.center,
              child: GestureDetector(
                child: SvgPicture.asset(
                  "assets/img/post_screen/cross_icon.svg",
                  // height: 24.0,
                  // width: 24.0,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            titleSpacing: 0.0,
            title: const Text(
              "강의 추가하기",
              style: TextStyle(
                  color: GRAYSCALE_GRAY_03,
                  fontSize: 14.0,
                  letterSpacing: -0.01,
                  height: 1.4,
                  fontWeight: FontWeight.w400),
            ),
            centerTitle: true,
            actions: [
              InkWell(
                child: const Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Text(
                    "직접 추가",
                    style: TextStyle(
                        color: PRIMARY_COLOR_ORANGE_01,
                        fontSize: 14.0,
                        letterSpacing: -0.01,
                        height: 1.4,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => AddDirectTimeTableScreen(
                          addClass: widget.addClass,
                          addClassesAtAddTimeTableScreen:
                              addClassesAtAddTimeTableScreen,
                        ))),
              ),
            ],
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 9.0,
                ),
                TimeTableGrid(
                  addedClasses: widget.addedClasses,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
