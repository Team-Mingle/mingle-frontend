import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/common/const/error_codes.dart';
import 'package:mingle/common/const/utils.dart';
import 'package:mingle/common/model/course_time_model.dart';
import 'package:mingle/module/components/toast_message_card.dart';
import 'package:mingle/module/model/course_detail_model.dart';
import 'package:mingle/module/model/course_model.dart';
import 'package:mingle/module/repository/course_repository.dart';
import 'package:mingle/timetable/components/add_course_time_dropdowns.dart';
import 'package:mingle/timetable/model/class_model.dart';
import 'package:mingle/timetable/model/timetable_course_model.dart';
import 'package:mingle/timetable/provider/pinned_timetable_id_provider.dart';
import 'package:mingle/timetable/provider/pinned_timetable_provider.dart';
import 'package:mingle/timetable/repository/timetable_repository.dart';

class EditCrawledCourseScreen extends ConsumerStatefulWidget {
  final Function refreshClasses;
  final TimetableCourseModel course;
  const EditCrawledCourseScreen({
    Key? key,
    required this.refreshClasses,
    required this.course,
  }) : super(key: key);

  @override
  ConsumerState<EditCrawledCourseScreen> createState() =>
      _EditSelfAddedCourseScreenState();
}

class _EditSelfAddedCourseScreenState
    extends ConsumerState<EditCrawledCourseScreen> {
  List<Widget> timeDropdownWidgets = [];
  String moduleName = "";
  List<String> days = [];
  List<String> startTimes = [];
  List<String> endTimes = [];
  String moduleCode = "";
  String venue = "";
  String profName = "";
  String subclass = "";
  late FToast fToast;
  bool isLoading = false;

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    moduleName = widget.course.name;
    moduleCode = widget.course.courseCode;
    // location = widget.course.venue;
    profName = widget.course.professor;

    super.initState();
  }

  void deleteTimeAtIndex(int index) {
    setState(() {
      timeDropdownWidgets.removeAt(index);
      days.removeAt(index);
      startTimes.removeAt(index);
      endTimes.removeAt(index);
    });
  }

  Future<void> sendEditPersonalClassRequest(
      {bool overrideValidation = false}) async {
    setState(() {
      isLoading = true;
    });

    try {
      await ref.watch(timetableRepositoryProvider).editTimetableCourse(
          timetableCourseId: widget.course.courseTimetableId,
          editTimetableCourseDto: EditTimetableCourseDto(
              venue: venue, professor: profName, subclass: subclass));
      ref.read(pinnedTimetableProvider.notifier).fetchPinnedTimetable();
      await widget.refreshClasses();
      setState(() {
        isLoading = false;
      });
      // result.courseType = "PERSONAL";
      // widget.addClass(result, overrideValidation);
      // widget.addClassesAtAddTimeTableScreen(result, overrideValidation);
      Navigator.of(context).pop();
    } on DioException catch (e) {
      setState(() {
        isLoading = false;
      });

      fToast.showToast(
        child: ToastMessage(
            message: e.response?.data['message'] ?? generalErrorMsg),
        gravity: ToastGravity.CENTER,
        toastDuration: const Duration(seconds: 2),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        titleSpacing: 0.0,
        leading: GestureDetector(
          child: Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/img/post_screen/cross_icon.svg',
              width: 24,
              height: 24,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "강의 수정하기",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            letterSpacing: -0.02,
            height: 1.5,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          isLoading
              ? const Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: CircularProgressIndicator(
                    color: PRIMARY_COLOR_ORANGE_01,
                  ),
                )
              : GestureDetector(
                  child: const Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: Text(
                      "완료하기",
                      style: TextStyle(
                        color: PRIMARY_COLOR_ORANGE_01,
                        fontSize: 14.0,
                        letterSpacing: -0.01,
                        height: 1.4,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  onTap: () async {
                    await sendEditPersonalClassRequest();
                  },
                ),
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const Row(
                  children: [
                    Text(
                      '강의명',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        letterSpacing: -0.01,
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: GRAYSCALE_GRAY_02,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextFormField(
                    initialValue: moduleName,
                    onChanged: (value) {
                      setState(() {
                        moduleName = value;
                      });
                    },
                    decoration: InputDecoration(
                      enabled: false,
                      hintText: "강의명을 입력하세요",
                      hintStyle: const TextStyle(
                        color: GRAYSCALE_GRAY_03,
                        fontSize: 16.0,
                        letterSpacing: -0.02,
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 14.0,
                      ),
                      disabledBorder: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: GRAYSCALE_GRAY_02),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: GRAYSCALE_GRAY_02),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const Row(
                  children: [
                    Text(
                      '과목 코드',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        letterSpacing: -0.01,
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: GRAYSCALE_GRAY_02,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextFormField(
                    initialValue: moduleCode,
                    onChanged: (value) {
                      setState(() {
                        moduleCode = value;
                      });
                    },
                    decoration: InputDecoration(
                      enabled: false,
                      hintText: "과목 코드를 입력하세요",
                      hintStyle: const TextStyle(
                        color: GRAYSCALE_GRAY_03,
                        fontSize: 16.0,
                        letterSpacing: -0.02,
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 14.0,
                      ),
                      disabledBorder: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: GRAYSCALE_GRAY_02),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: GRAYSCALE_GRAY_02),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const Row(
                  children: [
                    Text(
                      '강의 장소',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        letterSpacing: -0.01,
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        venue = value;
                      });
                    },
                    initialValue: widget.course.venue,
                    decoration: InputDecoration(
                      hintText: "강의 장소를 입력하세요",
                      hintStyle: const TextStyle(
                        color: GRAYSCALE_GRAY_03,
                        fontSize: 16.0,
                        letterSpacing: -0.02,
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 14.0,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: GRAYSCALE_GRAY_02),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: GRAYSCALE_GRAY_02),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const Row(
                  children: [
                    Text(
                      '교수명',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        letterSpacing: -0.01,
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextFormField(
                    initialValue: profName,
                    onChanged: (value) {
                      setState(() {
                        profName = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "교수명을 입력하세요",
                      hintStyle: const TextStyle(
                        color: GRAYSCALE_GRAY_03,
                        fontSize: 16.0,
                        letterSpacing: -0.02,
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 14.0,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: GRAYSCALE_GRAY_02),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: GRAYSCALE_GRAY_02),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const Row(
                  children: [
                    Text(
                      '그룹',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        letterSpacing: -0.01,
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextFormField(
                    initialValue: subclass,
                    onChanged: (value) {
                      setState(() {
                        subclass = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "그룹을 입력하세요",
                      hintStyle: const TextStyle(
                        color: GRAYSCALE_GRAY_03,
                        fontSize: 16.0,
                        letterSpacing: -0.02,
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 14.0,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: GRAYSCALE_GRAY_02),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: GRAYSCALE_GRAY_02),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
