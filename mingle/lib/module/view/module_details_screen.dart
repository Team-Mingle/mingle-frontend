import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/component/expanded_section.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/module/components/module_review_card.dart';
import 'package:mingle/module/model/course_detail_model.dart';
import 'package:mingle/module/model/course_evaluation_model.dart';
import 'package:mingle/module/model/course_model.dart';
import 'package:mingle/module/repository/course_evaluation_repository.dart';
import 'package:mingle/module/repository/course_repository.dart';
import 'package:mingle/module/util/module_satisfaction_enum.dart';
import 'package:mingle/module/view/add_module_review_screen.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';

class ModuleDetailsScreen extends ConsumerStatefulWidget {
  final int courseId;
  final String moduleName;
  const ModuleDetailsScreen(
      {super.key, required this.courseId, required this.moduleName});

  @override
  ConsumerState<ModuleDetailsScreen> createState() =>
      _ModuleDetailsScreenState();
}

class _ModuleDetailsScreenState extends ConsumerState<ModuleDetailsScreen> {
  bool isExpanded = false;
  List<String> authors = [
    "23년 1학기 수강자",
    "23년 1학기 수강자(나)",
    "23년 1학기 수강자",
    "23년 1학기 수강자"
  ];
  List<String> reviews = [
    "완전 꿀강임!\n학점 얻어가세요",
    "교수가 제정신이 아님.....................",
    "걍..네",
    "완전 꿀강임!\n학점 얻어가세요"
  ];
  List<moduleSatisfaction> satisfactions = [
    moduleSatisfaction.satisfied,
    moduleSatisfaction.unsatisfied,
    moduleSatisfaction.meh,
    moduleSatisfaction.satisfied
  ];
  List<int> likes = [8, 8, 4, 8];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
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
              FutureBuilder(
                future: ref
                    .watch(courseRepositoryProvider)
                    .getCourseDetails(courseId: widget.courseId),
                // postDetailFuture(postId),
                builder: (context, AsyncSnapshot<CourseDetailModel> snapshot) {
                  if (!snapshot.hasData) {
                    print(snapshot);
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("다시 시도 ㄱㄱ"),
                    );
                  }
                  CourseDetailModel course = snapshot.data!;

                  return Stack(
                    children: [
                      renderContent(course),
                    ],
                  );
                },
              ),
              Positioned(
                right: 16.0,
                bottom: 16.0,
                // child: ExpandableFab(
                //   distance: 112,
                //   children: [
                //     ActionButton(
                //       onPressed: () => print("hi"),
                //       //  () => Navigator.of(context).push(
                //       //     MaterialPageRoute(
                //       //         builder: (_) => const AddModuleReviewScreen())),
                //       child: Container(
                //         padding: const EdgeInsets.all(16.0),
                //         decoration: BoxDecoration(
                //             color: Colors.white,
                //             border: Border.all(color: GRAYSCALE_GRAY_02),
                //             borderRadius: BorderRadius.circular(8.0)),
                //         child: const Text("강의평 작성하기"),
                //       ),
                //     ),
                //     // ActionButton(
                //     //   onPressed: () {},
                //     //   icon: const Icon(Icons.insert_photo),
                //     // ),
                //     // ActionButton(
                //     //   onPressed: () {},
                //     //   icon: const Icon(Icons.videocam),
                //     // ),
                //   ],
                // ),

                child: FloatingActionButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => AddModuleReviewScreen(
                            moduleId: widget.courseId,
                            moduleName: widget.moduleName,
                          ))),
                  backgroundColor: PRIMARY_COLOR_ORANGE_02,
                  child: const Icon(
                    Icons.add,
                    size: 36,
                  ),
                ),
              ),
            ],
          ),
        )
        // renderContent(),
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
                    Expanded(child: Text(courseDetailModel.professor))
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
                        "강의시간",
                        style: TextStyle(color: GRAYSCALE_GRAY_03),
                      ),
                    ),
                    SizedBox(
                      width: 12.0,
                    ),
                    //TODO: change to actual time
                    Expanded(child: Text("화2/수2"))
                  ],
                ),
                ExpandedSection(
                  expand: isExpanded,
                  child: expandedModuleInformation(courseDetailModel),
                ),
                const SizedBox(
                  height: 31.5,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    isExpanded = !isExpanded;
                  }),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isExpanded ? "과목 정보 접기" : "과목 정보 더보기",
                        style: const TextStyle(color: GRAYSCALE_GRAY_04),
                      ),
                      SvgPicture.asset(isExpanded
                          ? "assets/img/module_review_screen/up_tick_icon.svg"
                          : "assets/img/module_review_screen/down_tick_icon.svg")
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15.5,
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: ref
                .watch(courseEvalutationRepositoryProvider)
                .getCourseEvaluations(courseId: widget.courseId),
            // postDetailFuture(postId),
            builder:
                (context, AsyncSnapshot<CourseEvaluationResponseDto> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
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
          Container(
            width: MediaQuery.of(context).size.width,
            height: 16.0,
            color: GRAYSCALE_GRAY_01,
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
          ...List.generate(
              moduleReviews.length,
              (index) => ModuleReviewCard(
                  reivew: moduleReviews[index].comment,
                  author: moduleReviews[index].convertSemesterString(),
                  likes: 0, // TODO: change to likes
                  satisfaction:
                      moduleReviews[index].convertRatingToSatisfaction()))
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

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    super.key,
    this.initialOpen,
    required this.distance,
    required this.children,
  });

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

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
    return Stack(
      alignment: Alignment.bottomRight,
      clipBehavior: Clip.none,
      children: [
        _buildTapToCloseFab(),
        ..._buildExpandingActionButtons(),
        _buildTapToOpenFab(),
      ],
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56,
      height: 56,
      child: Center(
        child: Material(
          color: Colors.white,
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4,
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
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0;
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        // transform: Matrix4.diagonal3Values(
        //   _open ? 0.7 : 1.0,
        //   _open ? 0.7 : 1.0,
        //   1.0,
        // ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: _toggle,
            backgroundColor: PRIMARY_COLOR_ORANGE_02,
            child: const Icon(
              Icons.add,
              size: 36,
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
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        return Positioned(
            right: 16.0,
            bottom: 72.0,
            child: Transform.scale(
              scale: progress.value,
              child: child,
            ));
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // return IconButton(onPressed: onPressed, icon: const Icon(Icons.abc));
    return Material(child: GestureDetector(onTap: onPressed, child: child));
  }
}
