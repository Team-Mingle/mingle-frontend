import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mingle/common/component/reported_component.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/model/cursor_pagination_model.dart';
import 'package:mingle/main.dart';
import 'package:mingle/module/components/toast_message_card.dart';
import 'package:mingle/module/model/course_detail_model.dart';
import 'package:mingle/module/view/module_details_screen.dart';
import 'package:mingle/post/components/indicator_widget.dart';
import 'package:mingle/post/models/post_model.dart';
import 'package:mingle/post/provider/post_provider.dart';
import 'package:mingle/post/view/post_detail_screen.dart';
import 'package:mingle/second_hand_market/view/second_hand_post_detail_screen.dart';
import 'package:mingle/timetable/components/course_preview_card.dart';
import 'package:mingle/timetable/view/self_add_timetable_screen.dart';
import 'package:mingle/user/provider/user_provider.dart';
import 'package:mingle/user/view/home_screen/home_root_tab.dart';

class ModulePreviewComponent extends ConsumerStatefulWidget {
  // final List<Map<String, String>> postList;

  // final Future<List<PostModel>> postFuture;
  String emptyMessage;
  final bool isFromTimetableAdd;
  final CursorPaginationBase data;
  final Function? setIsSearching;
  final Function? addClass;
  final Function? showAddCourseSuccessToast;
  final Function? addClassesAtAddTimeTableScreen;
  final dynamic notifierProvider;
  final Function? setModule;
  final bool? isAdd;
  final bool isFromCourseEvaluation;
  ModulePreviewComponent({
    super.key,
    // required this.postList,
    required this.data,
    this.notifierProvider,
    this.emptyMessage = "아직 올라온 게시물이 없어요!",
    this.setIsSearching,
    this.addClass,
    this.addClassesAtAddTimeTableScreen,
    this.showAddCourseSuccessToast,
    this.isFromTimetableAdd = false,
    this.isFromCourseEvaluation = false,
    this.isAdd,
    this.setModule,
    // required this.postFuture,
  });

  @override
  ConsumerState<ModulePreviewComponent> createState() =>
      _ModulePreviewComponentState();
}

class _ModulePreviewComponentState
    extends ConsumerState<ModulePreviewComponent> {
  final ScrollController scrollController = ScrollController();
  late FToast fToast;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(scrollListener);
    fToast = FToast();
    fToast.init(navigatorKey.currentContext!);
    // scrollController.addListener(() {
    //   setState(() {});
    // });
  }

  void scrollListener() {
    // 현재 위치가 현재 길이보다 조금 덜되는 위치까지 왔다면 새로운 데이터를 추가요청
    if (scrollController.offset >
        scrollController.position.maxScrollExtent - 300) {
      widget.notifierProvider!.paginate(fetchMore: true);
    }
    setState(() {});
  }

  void refreshList() {
    widget.notifierProvider!.paginate(normalRefetch: true);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data is CursorPaginationLoading) {
      return Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(
            color: PRIMARY_COLOR_ORANGE_02,
          ),
        ),
      );
    }

    if (widget.data is CursorPaginationError) {
      CursorPaginationError error = widget.data as CursorPaginationError;
      return CustomScrollView(
          controller: scrollController,
          shrinkWrap: true,

          // physics: const NeverScrollableScrollPhysics(),
          slivers: [
            CupertinoSliverRefreshControl(
              onRefresh: () async {
                await Future.delayed(const Duration(milliseconds: 1000), () {
                  print("refreshing");
                  widget.notifierProvider!.paginate(normalRefetch: true);
                });
                // await widget.notifierProvider!.paginate(forceRefetch: true);
              },
            ),
            const SliverFillRemaining(
              child: Center(
                child: Text('데이터를 가져오는데 실패했습니다'),
              ),
            )
          ]);
    }

    final courseList = widget.data as CursorPagination;
    final totalCount = courseList.totalCount!;

    if (widget.isFromTimetableAdd && courseList.data.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 48.0,
          ),
          const Text(
            "일치하는 강의가 없습니다.",
            style: TextStyle(
                fontSize: 16.0,
                letterSpacing: -0.02,
                height: 1.5,
                color: GRAYSCALE_GRAY_04),
          ),
          const SizedBox(
            height: 17.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => AddDirectTimeTableScreen(
                      addClass: widget.addClass!,
                      addClassesAtAddTimeTableScreen:
                          widget.addClassesAtAddTimeTableScreen!)));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "직접 추가하기",
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      color: PRIMARY_COLOR_ORANGE_01),
                ),
                SvgPicture.asset(
                    "assets/img/timetable_screen/right_tick_icon.svg")
              ],
            ),
          )
        ],
      );
    }

    return CupertinoTheme(
      data: const CupertinoThemeData(
          primaryColor: PRIMARY_COLOR_ORANGE_02, applyThemeToAll: true),
      child: CustomScrollView(
        controller: scrollController,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),

        // physics: const NeverScrollableScrollPhysics(),
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              await Future.delayed(const Duration(milliseconds: 1000),
                  () => widget.notifierProvider!.paginate(normalRefetch: true));
              // await widget.notifierProvider!.paginate(forceRefetch: true);
            },
          ),
          courseList.data.isEmpty
              ? SliverFillRemaining(
                  child: Center(
                    child: Text(widget.emptyMessage),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: courseList.data.length + 2,
                    (context, index) {
                      if (index == courseList.data.length + 1) {
                        return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Center(
                                child:
                                    courseList is CursorPaginationFetchingMore
                                        ? const CircularProgressIndicator(
                                            color: PRIMARY_COLOR_ORANGE_02,
                                          )
                                        : Container())
                            // const Text('마지막 데이터입니다 ㅠㅠ')),
                            );
                      }

                      return Column(
                        children: [
                          index == 0
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 16.0),
                                  child: Text("일치하는 강의가 $totalCount개 있습니다"),
                                )
                              : widget.isFromTimetableAdd
                                  ? CoursePreviewCard(
                                      showAddCourseSuccessToast:
                                          widget.showAddCourseSuccessToast!,
                                      addClass: widget.addClass!,
                                      addClassesAtAddTimeTableScreen: widget
                                          .addClassesAtAddTimeTableScreen!,
                                      course: courseList.data[index - 1],
                                      setIsSearching: widget.setIsSearching!,
                                    )
                                  : coursePreviewCard(
                                      courseList.data[index - 1]),
                          const Divider(
                            height: 1.0,
                            color: GRAYSCALE_GRAY_01_5,
                          )
                        ],
                      );
                    },
                  ),
                ),
          // ),
        ],
      ),
    );
  }

  Widget coursePreviewCard(CourseDetailModel course) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: widget.isAdd!
          ? () {
              widget.setModule!(course.name, course.id);
              Navigator.pop(context);
            }
          : () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => ModuleDetailsScreen(
                    courseId: course.id,
                    moduleName: course.name,
                    isFromCourseEvaluation: widget.isFromCourseEvaluation,
                    courseDetail: course,
                  ))),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            course.name,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 4.0,
          ),
          Text(course.courseCode),
          const SizedBox(
            height: 4.0,
          ),
          // Row(
          //   children: [
          //     Text(
          //       course.professor!,
          //       style: const TextStyle(
          //           fontSize: 12.0,
          //           letterSpacing: -0.005,
          //           height: 1.3,
          //           color: GRAYSCALE_GRAY_04),
          //     ),
          //     const SizedBox(
          //       width: 4.0,
          //     ),
          //     Text(
          //       course.getCourseTimes(),
          //       //TODO: change to actual timing
          //       // "화2/수2",
          //       style: const TextStyle(
          //           fontSize: 12.0,
          //           letterSpacing: -0.005,
          //           height: 1.3,
          //           color: GRAYSCALE_GRAY_04),
          //     )
          //   ],
          // )
        ]),
      ),
    );
  }
}
