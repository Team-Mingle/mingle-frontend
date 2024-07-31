import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mingle/common/component/expanded_section.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/main.dart';
import 'package:mingle/module/components/module_review_card.dart';
import 'package:mingle/module/components/toast_message_card.dart';
import 'package:mingle/module/model/course_detail_model.dart';
import 'package:mingle/module/model/course_evaluation_model.dart';
import 'package:mingle/module/model/course_model.dart';
import 'package:mingle/module/repository/course_evaluation_repository.dart';
import 'package:mingle/module/repository/course_repository.dart';
import 'package:mingle/module/util/module_satisfaction_enum.dart';
import 'package:mingle/module/view/add_module_review_screen.dart';
import 'package:mingle/point_shop/model/coupon_model.dart';
import 'package:mingle/point_shop/provider/my_coupon_provider.dart';
import 'package:mingle/point_shop/view/point_shop_screen.dart';
import 'package:mingle/timetable/provider/pinned_timetable_id_provider.dart';
import 'package:mingle/timetable/provider/pinned_timetable_provider.dart';
import 'package:mingle/timetable/repository/timetable_repository.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';

class ModuleDetailsScreen extends ConsumerStatefulWidget {
  final int courseId;
  final String? moduleName;
  final CourseDetailModel? courseDetail;
  final bool isFromCourseEvaluation;
  const ModuleDetailsScreen(
      {super.key,
      required this.courseId,
      this.moduleName,
      this.courseDetail,
      this.isFromCourseEvaluation = false});

  @override
  ConsumerState<ModuleDetailsScreen> createState() =>
      _ModuleDetailsScreenState();
}

class _ModuleDetailsScreenState extends ConsumerState<ModuleDetailsScreen> {
  bool isExpanded = false;
  CouponModel? myCoupon;
  late FToast fToast;
  Future<CourseEvaluationResponseDto>? courseEvaluationFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast.init(navigatorKey.currentContext!);
    getCoupon();
    getCourseEvaluationFuture();
  }

  void getCourseEvaluationFuture() {
    setState(() {
      courseEvaluationFuture = ref
          .read(courseEvalutationRepositoryProvider)
          .getCourseEvaluations(courseId: widget.courseId);
    });
  }

  void getCoupon() async {
    await ref.read(myCouponProvider.notifier).getCoupon();
    setState(() {
      myCoupon = ref.read(myCouponProvider);
    });
  }

  void navigateToAddModuleReview() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AddModuleReviewScreen(
          moduleId: widget.courseId,
          moduleName: widget.moduleName,
        ),
      ),
    );
  }

  void addModuleToTimetable() async {
    int? pinnedTimetableId = ref.watch(pinnedTimetableIdProvider);
    if (pinnedTimetableId == null) {
      fToast.showToast(
        child: const ToastMessage(message: "시간표를 먼저 추가해주세요"),
        gravity: ToastGravity.CENTER,
        toastDuration: const Duration(seconds: 2),
      );
    }
    try {
      await ref.watch(timetableRepositoryProvider).addCourse(
          timetableId: pinnedTimetableId!,
          addClassDto: AddClassDto(courseId: widget.courseId));
      await ref.read(pinnedTimetableProvider.notifier).fetchPinnedTimetable();
    } on DioException catch (e) {
      print(e);
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
    return widget.courseDetail == null
        ? renderWithoutCourseDetail()
        : renderWithCourseDetail();
    // return Scaffold(
    //     backgroundColor: Colors.white,
    //     appBar: AppBar(
    //       surfaceTintColor: Colors.transparent,
    //       shape: const Border(
    //           bottom: BorderSide(color: GRAYSCALE_GRAY_01, width: 1)),
    //       backgroundColor: Colors.white,
    //       titleSpacing: 0.0,
    //       elevation: 0,
    //       leading: Padding(
    //         padding: const EdgeInsets.only(left: 0.0),
    //         child: IconButton(
    //           padding: EdgeInsets.zero,
    //           icon: const ImageIcon(
    //             AssetImage(
    //                 "assets/img/module_review_screen/back_tick_icon.png"),
    //             color: GRAYSCALE_BLACK,
    //           ),
    //           color: GRAYSCALE_BLACK,
    //           onPressed: () {
    //             Navigator.pop(context);
    //           },
    //         ),
    //       ),
    //       title: const Text(
    //         "강의개요",
    //         style: TextStyle(
    //             fontSize: 16.0,
    //             letterSpacing: -0.02,
    //             height: 1.5,
    //             color: Colors.black),
    //       ),
    //     ),
    //     body: SizedBox(
    //       height: MediaQuery.of(context).size.height,
    //       child: Stack(
    //         children: [
    //           renderContent(widget.courseDetail),

    //           // FutureBuilder(
    //           // future: ref
    //           //     .watch(courseRepositoryProvider)
    //           //     .getCourseDetails(courseId: widget.courseId),
    //           // // postDetailFuture(postId),
    //           // builder: (context, AsyncSnapshot<CourseDetailModel> snapshot) {
    //           //     if (!snapshot.hasData) {
    //           //       print(snapshot);
    //           //       return const Center(
    //           //         child: CircularProgressIndicator(
    //           //           color: PRIMARY_COLOR_ORANGE_01,
    //           //         ),
    //           //       );
    //           //     }
    //           //     if (snapshot.hasError) {
    //           //       return const Center(
    //           //         child: Text("다시 시도 ㄱㄱ"),
    //           //       );
    //           //     }
    //           //     CourseDetailModel course = snapshot.data!;

    //           //     return Stack(
    //           //       children: [
    //           //         renderContent(course),
    //           //       ],
    //           //     );
    //           //   },
    //           // ),
    //         ],
    //       ),
    //     ),
    //     floatingActionButton: widget.courseDetail.courseType == "CRAWL"
    //         ? ExpandableFab(
    //             distance: 112,
    //             navigateToAddModuleReview: navigateToAddModuleReview,
    //             addModuleToTimetable: addModuleToTimetable,
    //           )
    //         : null
    //     // renderContent(),
    //     );
  }

  Widget renderWithCourseDetail() {
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
                AssetImage(
                    "assets/img/module_review_screen/back_tick_icon.png"),
                color: GRAYSCALE_BLACK,
              ),
              color: GRAYSCALE_BLACK,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: const Text(
            "강의개요",
            style: TextStyle(
                fontSize: 16.0,
                letterSpacing: -0.02,
                height: 1.5,
                color: Colors.black),
          ),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              renderContent(widget.courseDetail!),

              // FutureBuilder(
              // future: ref
              //     .watch(courseRepositoryProvider)
              //     .getCourseDetails(courseId: widget.courseId),
              // // postDetailFuture(postId),
              // builder: (context, AsyncSnapshot<CourseDetailModel> snapshot) {
              //     if (!snapshot.hasData) {
              //       print(snapshot);
              //       return const Center(
              //         child: CircularProgressIndicator(
              //           color: PRIMARY_COLOR_ORANGE_01,
              //         ),
              //       );
              //     }
              //     if (snapshot.hasError) {
              //       return const Center(
              //         child: Text("다시 시도 ㄱㄱ"),
              //       );
              //     }
              //     CourseDetailModel course = snapshot.data!;

              //     return Stack(
              //       children: [
              //         renderContent(course),
              //       ],
              //     );
              //   },
              // ),
            ],
          ),
        ),
        floatingActionButton: widget.courseDetail!.courseType == "CRAWL"
            ? ExpandableFab(
                distance: 112,
                navigateToAddModuleReview: navigateToAddModuleReview,
                addModuleToTimetable: addModuleToTimetable,
              )
            : null
        // renderContent(),
        );
  }

  Widget renderWithoutCourseDetail() {
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
          "강의개요",
          style: TextStyle(
              fontSize: 16.0,
              letterSpacing: -0.02,
              height: 1.5,
              color: Colors.black),
        ),
      ),
      body: FutureBuilder(
        future: ref
            .watch(courseRepositoryProvider)
            .getCourseDetails(courseId: widget.courseId),
        // postDetailFuture(postId),
        builder: (context, AsyncSnapshot<CourseDetailModel> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: PRIMARY_COLOR_ORANGE_01,
              ),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(generalErrorMsg),
            );
          }

          CourseDetailModel courseDetail = snapshot.data!;
          return Scaffold(
              backgroundColor: Colors.white,
              body: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    renderContent(courseDetail),
                  ],
                ),
              ),
              floatingActionButton: courseDetail.courseType == "CRAWL"
                  ? ExpandableFab(
                      distance: 112,
                      navigateToAddModuleReview: navigateToAddModuleReview,
                      addModuleToTimetable: addModuleToTimetable,
                    )
                  : null
              // renderContent(),
              );
        },
      ),
    );
  }

  Widget renderContent(CourseDetailModel courseDetailModel) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultPadding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 24.0,
                ),
                const Text(
                  "강의 정보",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 32.0,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 72.0,
                      child: Text(
                        "강의명",
                        style: TextStyle(color: GRAYSCALE_GRAY_03),
                      ),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Expanded(child: Text(courseDetailModel.name))
                  ],
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 72.0,
                      child: Text(
                        "과목 코드",
                        style: TextStyle(color: GRAYSCALE_GRAY_03),
                      ),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Expanded(child: Text(courseDetailModel.courseCode))
                  ],
                ),
                const SizedBox(
                  height: 24.0,
                ),
                if (!widget.isFromCourseEvaluation) ...[
                  Row(
                    children: [
                      const SizedBox(
                        width: 72.0,
                        child: Text(
                          "교수명",
                          style: TextStyle(color: GRAYSCALE_GRAY_03),
                        ),
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Expanded(child: Text(courseDetailModel.professor!))
                    ],
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 72.0,
                        child: Text(
                          "강의시간",
                          style: TextStyle(color: GRAYSCALE_GRAY_03),
                        ),
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      //TODO: change to actual time
                      Expanded(child: Text(courseDetailModel.getStartTimes()))
                    ],
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 72.0,
                        child: Text(
                          "장소",
                          style: TextStyle(color: GRAYSCALE_GRAY_03),
                        ),
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Text(courseDetailModel.venue ?? "-")
                    ],
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 72.0,
                        child: Text(
                          "분반",
                          style: TextStyle(color: GRAYSCALE_GRAY_03),
                        ),
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Text(courseDetailModel.subclass ?? "-")
                    ],
                  ),
                ],
                // ExpandedSection(
                //   expand: isExpanded,
                //   child: expandedModuleInformation(courseDetailModel),
                // ),
                // const SizedBox(
                //   height: 31.5,
                // ),
                // GestureDetector(
                //   onTap: () => setState(() {
                //     isExpanded = !isExpanded;
                //   }),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Text(
                //         isExpanded ? "과목 정보 접기" : "과목 정보 더보기",
                //         style: const TextStyle(color: GRAYSCALE_GRAY_04),
                //       ),
                //       SvgPicture.asset(isExpanded
                //           ? "assets/img/module_review_screen/up_tick_icon.svg"
                //           : "assets/img/module_review_screen/down_tick_icon.svg")
                //     ],
                //   ),
                // ),
                const SizedBox(
                  height: 15.5,
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 16.0,
            color: GRAYSCALE_GRAY_01,
          ),
          const SizedBox(
            height: 42.0,
          ),
          if (courseDetailModel.courseType == "CRAWL")
            FutureBuilder(
              future: courseEvaluationFuture,
              // ref
              //     .watch(courseEvalutationRepositoryProvider)
              //     .getCourseEvaluations(courseId: widget.courseId),
              // postDetailFuture(postId),
              builder: (context,
                  AsyncSnapshot<CourseEvaluationResponseDto> snapshot) {
                print("snapshot data: ${snapshot.data}");
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: PRIMARY_COLOR_ORANGE_01,
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("강의평가 불러오기에 실패했습니다."),
                  );
                }

                List<CourseEvaluationModel> moduleReviews =
                    snapshot.data!.courseEvaluationList;

                return renderModuleReviews(moduleReviews);
              },
            ),
          const SizedBox(
            height: 50.0,
          ),
        ],
      ),
    );
  }

  Widget renderModuleReviews(List<CourseEvaluationModel> moduleReviews) {
    return DefaultPadding(
      child: Column(
        children: [
          Row(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                        text: "강의평",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                    TextSpan(
                        text: "(${moduleReviews.length})",
                        style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: GRAYSCALE_GRAY_03))
                  ],
                ),
              ),
              // const Spacer(),
              // GestureDetector(
              //   onTap: () {},
              //   child: Row(
              //     children: [
              //       const Text("등록순"),
              //       SvgPicture.asset(
              //           "assets/img/module_review_screen/down_tick_icon.svg")
              //     ],
              //   ),
              // ),
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          if (myCoupon == null)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50.0,
                ),
                const Text(
                  "강의평가는 조회 이용권을 보유해야 볼 수 있어요.",
                  style: TextStyle(fontSize: 16.0, letterSpacing: -0.32),
                ),
                const SizedBox(
                  height: 17.0,
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const PointShopScreen())),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "이용권 구매하러 가기",
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.06,
                            color: PRIMARY_COLOR_ORANGE_01),
                      ),
                      SvgPicture.asset(
                          "assets/img/timetable_screen/right_tick_icon.svg")
                    ],
                  ),
                ),
                const SizedBox(
                  height: 9.0,
                )
              ],
            ),
          if (myCoupon != null)
            ...List.generate(
                moduleReviews.length,
                (index) => ModuleReviewCard(
                      reivew: moduleReviews[index].comment,
                      semester: moduleReviews[index].convertSemesterString(),
                      likes: 0, // TODO: change to likes
                      satisfaction:
                          moduleReviews[index].convertRatingToSatisfaction(),
                      isMine: moduleReviews[index].isMine,
                      courseCode: moduleReviews[index].courseCode,
                    ))
        ],
      ),
    );
  }

  Widget expandedModuleInformation(CourseDetailModel courseDetailModel) {
    return Column(
      children: [
        const SizedBox(
          height: 24.0,
        ),
        const Row(
          children: [
            SizedBox(
              width: 72.0,
              child: Text(
                "수강인원",
                style: TextStyle(color: GRAYSCALE_GRAY_03),
              ),
            ),
            SizedBox(
              width: 12.0,
            ),
            Text("25")
          ],
        ),
        const SizedBox(
          height: 24.0,
        ),
        Row(
          children: [
            const SizedBox(
              width: 72.0,
              child: Text(
                "선이수과목",
                style: TextStyle(color: GRAYSCALE_GRAY_03),
              ),
            ),
            const SizedBox(
              width: 12.0,
            ),
            preRequisites(courseDetailModel.prerequisite ?? ""),
            // const SizedBox(
            //   width: 4.0,
            // ),
            // preRequisites("밍글로고디자인")
          ],
        ),
        const SizedBox(
          height: 24.0,
        ),
        const Row(
          children: [
            SizedBox(
              width: 72.0,
              child: Text(
                "학년",
                style: TextStyle(color: GRAYSCALE_GRAY_03),
              ),
            ),
            SizedBox(
              width: 12.0,
            ),
            Text("4학년")
          ],
        ),
        const SizedBox(
          height: 24.0,
        ),
        const Row(
          children: [
            SizedBox(
              width: 72.0,
              child: Text(
                "구분",
                style: TextStyle(color: GRAYSCALE_GRAY_03),
              ),
            ),
            SizedBox(
              width: 12.0,
            ),
            Text("Major Core Module")
          ],
        ),
        const SizedBox(
          height: 24.0,
        ),
        Row(
          children: [
            const SizedBox(
              width: 72.0,
              child: Text(
                "장소",
                style: TextStyle(color: GRAYSCALE_GRAY_03),
              ),
            ),
            const SizedBox(
              width: 12.0,
            ),
            Text(courseDetailModel.venue ?? "")
          ],
        ),
        const SizedBox(
          height: 24.0,
        ),
        const Row(
          children: [
            SizedBox(
              width: 72.0,
              child: Text(
                "학점",
                style: TextStyle(color: GRAYSCALE_GRAY_03),
              ),
            ),
            SizedBox(
              width: 12.0,
            ),
            Text("6")
          ],
        ),
        const SizedBox(
          height: 24.0,
        ),
        const Row(
          children: [
            SizedBox(
              width: 72.0,
              child: Text(
                "수강대상",
                style: TextStyle(color: GRAYSCALE_GRAY_03),
              ),
            ),
            SizedBox(
              width: 12.0,
            ),
            Text("1학년 한정")
          ],
        ),
      ],
    );
  }

  Widget preRequisites(String moduleName) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: GRAYSCALE_GRAY_01,
          border: Border.all(color: GRAYSCALE_GRAY_01),
          borderRadius: BorderRadius.circular(16.0)),
      child: Row(children: [
        Text(
          moduleName,
          style: const TextStyle(color: GRAYSCALE_GRAY_05, fontSize: 12.0),
        ),
        SvgPicture.asset("assets/img/module_review_screen/right_tick_icon.svg")
      ]),
    );
  }
}

class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    super.key,
    this.initialOpen,
    required this.distance,
    required this.addModuleToTimetable,
    required this.navigateToAddModuleReview,
  });

  final bool? initialOpen;
  final double distance;
  final Function addModuleToTimetable;
  final Function navigateToAddModuleReview;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return Container(
      color: Colors.white,
      width: 56,
      height: 56,
      child: Center(
        child: Material(
          surfaceTintColor: Colors.white,
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 1,
          child: InkWell(
            onTap: _toggle,
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];

    children.add(
      _ExpandingActionButton(
        toggle: _toggle,
        directionInDegrees: 90,
        maxDistance: 60,
        progress: _expandAnimation,
        addModuleToTimetable: widget.addModuleToTimetable,
        navigateToAddModuleReview: widget.navigateToAddModuleReview,
      ),
    );

    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: GestureDetector(
            onTap: _toggle,
            child: const SizedBox(
              width: 56,
              height: 56,
              child: Center(
                child: Material(
                  color: PRIMARY_COLOR_ORANGE_02,
                  shape: CircleBorder(),
                  clipBehavior: Clip.antiAlias,
                  elevation: 1,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.toggle,
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.addModuleToTimetable,
    required this.navigateToAddModuleReview,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Function toggle;
  final Function addModuleToTimetable;
  final Function navigateToAddModuleReview;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.translate(
            offset: Offset(progress.value, 0),
            // angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: GRAYSCALE_GRAY_03),
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0)),
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            GestureDetector(
              onTap: () {
                toggle();
                addModuleToTimetable();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 11.5),
                child: const Text(
                  "시간표에 추가하기",
                  style: TextStyle(letterSpacing: -0.14),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                toggle();
                navigateToAddModuleReview();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 11.5),
                child: const Text(
                  "강의평 작성하기",
                  style: TextStyle(letterSpacing: -0.14),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
