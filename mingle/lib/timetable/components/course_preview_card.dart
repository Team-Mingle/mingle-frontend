import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mingle/common/component/expanded_section.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/module/model/course_model.dart';
import 'package:mingle/module/view/module_details_screen.dart';
import 'package:mingle/timetable/provider/pinned_timetable_id_provider.dart';
import 'package:mingle/timetable/repository/timetable_repository.dart';

class CoursePreviewCard extends ConsumerStatefulWidget {
  final CourseModel course;
  final Function addClass;
  final Function addClassesAtAddTimeTableScreen;
  const CoursePreviewCard(
      {super.key,
      required this.course,
      required this.addClass,
      required this.addClassesAtAddTimeTableScreen});

  @override
  ConsumerState<CoursePreviewCard> createState() => _CoursePreviewCardState();
}

class _CoursePreviewCardState extends ConsumerState<CoursePreviewCard> {
  bool isExpanded = false;
  late FToast fToast;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  void addClass() async {
    widget.addClass(widget.course);
    widget.addClassesAtAddTimeTableScreen(widget.course);
    try {
      await ref.watch(timetableRepositoryProvider).addCourse(
          timetableId: ref.watch(pinnedTimetableIdProvider)!,
          addClassDto: AddClassDto(courseId: widget.course.id));
    } on DioException catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        isExpanded = !isExpanded;
      }),
      // onTap: widget.isAdd
      //     ? () {
      //         widget.setModule!(course.name, course.id);
      //         Navigator.pop(context); P
      //       }
      //     : () => Navigator.of(context).push(MaterialPageRoute(
      //         builder: (_) => ModuleDetailsScreen(
      //               courseId: course.id,
      //               moduleName: course.name,
      //             ))),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.course.name,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(widget.course.courseCode),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Row(
                      children: [
                        Text(
                          widget.course.professor,
                          style: const TextStyle(
                              fontSize: 12.0,
                              letterSpacing: -0.005,
                              height: 1.3,
                              color: GRAYSCALE_GRAY_04),
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        const Text(
                          //TODO: change to actual timing
                          "화2/수2",
                          style: TextStyle(
                              fontSize: 12.0,
                              letterSpacing: -0.005,
                              height: 1.3,
                              color: GRAYSCALE_GRAY_04),
                        ),
                      ],
                    ),
                    ExpandedSection(
                      expand: isExpanded,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 12.0,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: addClass,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 8.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: PRIMARY_COLOR_ORANGE_01),
                                      color: SUB_LIGHT_PINK,
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: const Text(
                                    "시간표에 추가",
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                        color: PRIMARY_COLOR_ORANGE_01),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 4.0,
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) => ModuleDetailsScreen(
                                            courseId: widget.course.id,
                                            moduleName: widget.course.name))),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 8.0),
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: GRAYSCALE_GRAY_03),
                                      color: GRAYSCALE_GRAY_01,
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: const Text(
                                    "강의평",
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                        color: GRAYSCALE_GRAY_03),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ]),
            ),
            SvgPicture.asset(isExpanded
                ? "assets/img/module_review_screen/up_tick_icon.svg"
                : "assets/img/module_review_screen/down_tick_icon.svg")
          ],
        ),
      ),
    );
  }
}
