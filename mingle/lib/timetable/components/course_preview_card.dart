import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mingle/common/component/expanded_section.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/common/const/error_codes.dart';
import 'package:mingle/module/components/toast_message_card.dart';
import 'package:mingle/module/model/course_detail_model.dart';
import 'package:mingle/module/model/course_model.dart';
import 'package:mingle/module/view/module_details_screen.dart';
import 'package:mingle/timetable/model/add_course_response_model.dart';
import 'package:mingle/timetable/model/timetable_model.dart';
import 'package:mingle/timetable/provider/pinned_timetable_id_provider.dart';
import 'package:mingle/timetable/provider/pinned_timetable_id_provider.dart';
import 'package:mingle/timetable/provider/pinned_timetable_provider.dart';
import 'package:mingle/timetable/repository/timetable_repository.dart';

class CoursePreviewCard extends ConsumerStatefulWidget {
  final CourseDetailModel course;
  final Function addClass;
  final Function addClassesAtAddTimeTableScreen;
  final Function showAddCourseSuccessToast;
  final Function setIsSearching;
  const CoursePreviewCard({
    super.key,
    required this.course,
    required this.addClass,
    required this.addClassesAtAddTimeTableScreen,
    required this.showAddCourseSuccessToast,
    required this.setIsSearching,
  });

  @override
  ConsumerState<CoursePreviewCard> createState() => _CoursePreviewCardState();
}

class _CoursePreviewCardState extends ConsumerState<CoursePreviewCard> {
  bool isExpanded = false;
  bool isLoading = false;
  late FToast fToast;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  void addClass({bool overrideValidation = false}) async {
    try {
      setState(() {
        isLoading = true;
      });
      AddCourseResponseModel addCourseResponseModel =
          await ref.watch(timetableRepositoryProvider).addCourse(
                timetableId: ref.watch(pinnedTimetableIdProvider)!,
                addClassDto: AddClassDto(
                    courseId: widget.course.id,
                    overrideValidation: overrideValidation),
              );
      CourseDetailModel courseToBeAdded =
          widget.course.copyWith(rgb: addCourseResponseModel.rgb);
      widget.addClass(courseToBeAdded, overrideValidation);
      widget.addClassesAtAddTimeTableScreen(
          courseToBeAdded, overrideValidation);
      ref.read(pinnedTimetableProvider.notifier).fetchPinnedTimetable();
      widget.showAddCourseSuccessToast();
      setState(() {
        isLoading = false;
      });
      // Navigator.of(context).pop();
      widget.setIsSearching(false);
    } on DioException catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
      // print(e.response?.data['code']);
      if (e.response?.statusCode == 409 &&
          e.response?.data['code'] == TIMETABLE_CONFLICT) {
        showTimetableConflictDialog();
      } else {
        fToast.showToast(
          child: ToastMessage(
              message: e.response?.data['message'] ?? generalErrorMsg),
          gravity: ToastGravity.CENTER,
          toastDuration: const Duration(seconds: 2),
        );
      }
    }
  }

  bool isCourseInTimetable() {
    TimetableModel timetableModel =
        ref.read(pinnedTimetableProvider)! as TimetableModel;
    for (CourseDetailModel courseDetailModel
        in timetableModel.coursePreviewDtoList) {
      if (courseDetailModel.id == widget.course.id) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {
          isExpanded = !isExpanded;
        });
      },
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
        color: isExpanded ? GRAYSCALE_GRAY_01 : Colors.white,
        child: Row(
          children: [
            Expanded(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: widget.course.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                  color: Colors.black)),
                          if (isCourseInTimetable())
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: SvgPicture.asset(
                                    "assets/img/timetable_screen/check_icon.svg"),
                              ),
                            ),
                        ],
                      ),
                    ),
                    // Text(
                    //   widget.course.name,
                    //   style: const TextStyle(fontWeight: FontWeight.w500),
                    // ),
                    // if (isCourseInTimetable())
                    //   SvgPicture.asset(
                    //       "assets/img/timetable_screen/check_icon.svg"),
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
                        Expanded(
                          child: Text(
                            widget.course.getStartTimes(),
                            style: const TextStyle(
                                fontSize: 12.0,
                                letterSpacing: -0.005,
                                height: 1.3,
                                color: GRAYSCALE_GRAY_04),
                          ),
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
                                child: isLoading
                                    ? Center(
                                        child: Transform.scale(
                                          scale: 0.8,
                                          child:
                                              const CircularProgressIndicator(
                                            color: PRIMARY_COLOR_ORANGE_01,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 8.0),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: PRIMARY_COLOR_ORANGE_01),
                                            color: SUB_LIGHT_PINK,
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
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
                                onTap: () => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (_) => ModuleDetailsScreen(
                                              courseId: widget.course.id,
                                              moduleName: widget.course.name,
                                              courseDetail: widget.course,
                                            ))),
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

  void showTimetableConflictDialog() {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        insetPadding: EdgeInsets.zero,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0)),
              // width: 343,
              padding: const EdgeInsets.only(
                  top: 32.0, left: 32.0, right: 32.0, bottom: 24.0),
              child: Column(
                children: [
                  const Text(
                    "‘강의명’을 시간표에 추가하시겠습니까?",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.32),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Text(
                    "시간이 겹치는 강의가 삭제됩니다.",
                    style: TextStyle(letterSpacing: -0.14),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          addClass(overrideValidation: true);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 40.0,
                          width: 120.0,
                          decoration: BoxDecoration(
                              color: GRAYSCALE_GRAY_01,
                              borderRadius: BorderRadius.circular(8.0)),
                          child: const Center(
                            child: Text(
                              "강의 추가하기",
                              style: TextStyle(
                                  color: GRAYSCALE_GRAY_04,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 40.0,
                          width: 120.0,
                          decoration: BoxDecoration(
                              color: PRIMARY_COLOR_ORANGE_02,
                              borderRadius: BorderRadius.circular(8.0)),
                          child: const Center(
                            child: Text(
                              "취소하기",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
