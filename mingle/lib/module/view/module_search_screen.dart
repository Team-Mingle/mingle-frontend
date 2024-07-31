import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/component/module_preview_component.dart';
import 'package:mingle/common/component/search_history_service.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/model/cursor_pagination_model.dart';
import 'package:mingle/module/model/course_detail_model.dart';
import 'package:mingle/module/model/course_model.dart';
import 'package:mingle/module/provider/module_provider.dart';
import 'package:mingle/module/repository/course_repository.dart';
import 'package:mingle/module/view/module_details_screen.dart';
import 'package:mingle/post/models/post_model.dart';

class ModuleSearchScreen extends ConsumerStatefulWidget {
  final bool isAdd;
  final Function? setModule;
  const ModuleSearchScreen({super.key, this.isAdd = false, this.setModule});

  @override
  ConsumerState<ModuleSearchScreen> createState() => _ModuleSearchScreenState();
}

class _ModuleSearchScreenState extends ConsumerState<ModuleSearchScreen> {
  List<String>? previousSearch;
  final TextEditingController _searchController = TextEditingController();
  StateNotifierProvider<ModuleStateNotifier, CursorPaginationBase>?
      searchModuleProvier;
  @override
  void initState() {
    super.initState();
    getSearchHistories();
  }

  void getSearchHistories() async {
    List<String>? searchHistory =
        (await SearchHistoryService.getInstance()).getHistories();
    setState(() {
      previousSearch = searchHistory;
    });
    print(searchHistory);
  }

  void setSearch() {
    setState(
      () {
        searchModuleProvier =
            StateNotifierProvider<ModuleStateNotifier, CursorPaginationBase>(
                (ref) {
          final repository = ref.watch(courseRepositoryProvider);

          final notifier = ModuleStateNotifier(
              moduleRepository: repository,
              keyword: _searchController.text,
              isFromCourseEvaluation: true);

          return notifier;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(previousSearch);
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
          title: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              height: 40.0,
              decoration: BoxDecoration(
                  color: GRAYSCALE_GRAY_01,
                  border: Border.all(color: GRAYSCALE_GRAY_01),
                  borderRadius: BorderRadius.circular(8.0)),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextFormField(
                  autofocus: true,
                  onEditingComplete: () {
                    SearchHistoryService.getInstance().then((service) {
                      service.addHistory(_searchController.text);
                    });

                    setSearch();
                  },
                  controller: _searchController,
                  textAlignVertical: TextAlignVertical.top,
                  obscureText: false,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      hintText: "강의명을 입력하세요.",
                      hintStyle: const TextStyle(
                          color: GRAYSCALE_GRAY_03, fontSize: 16.0),
                      border: InputBorder.none,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Hero(
                          tag: "search",
                          child: SvgPicture.asset(
                            "assets/img/module_review_screen/search_icon.svg",
                            height: 24.0,
                            width: 24.0,
                            colorFilter: const ColorFilter.mode(
                                Colors.black, BlendMode.srcIn),
                          ),
                        ),
                      )),
                ),
              ),
            ),
          ),
        ),
        body: searchModuleProvier == null
            ? Column(
                children: previousSearch == null || previousSearch!.isEmpty
                    ? [
                        const SizedBox(
                          height: 48.0,
                        ),
                        const Align(
                          child: Text(
                            "최근 검색어 내역이 없습니다.",
                            style: TextStyle(
                                fontSize: 16.0,
                                letterSpacing: -0.02,
                                height: 1.5,
                                color: GRAYSCALE_GRAY_03),
                          ),
                        )
                      ]
                    : List.generate(
                        previousSearch!.length + 1,
                        (index) => index == 0
                            ? Container(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20.0, top: 16.0),
                                child: Row(children: [
                                  const Text(
                                    "최근 검색어",
                                    style: TextStyle(color: GRAYSCALE_GRAY_03),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                      child: const Text(
                                        "전체삭제",
                                        style: TextStyle(
                                            color: GRAYSCALE_GRAY_04,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      onTap: () {
                                        SearchHistoryService.getInstance()
                                            .then((service) {
                                          service.clearHistories();
                                        });
                                        setState(() {
                                          previousSearch!.clear();
                                        });
                                      })
                                ]),
                              )
                            : recentSearchCard(
                                previousSearch![index - 1], index - 1),
                      ),
              )
            :
            // FutureBuilder(
            //     future: searchFuture,
            //     builder: (context,
            //         AsyncSnapshot<CursorPagination<CourseDetailModel>> snapshot) {
            //       if (!snapshot.hasData ||
            //           snapshot.connectionState != ConnectionState.done) {
            //         print(snapshot);
            //         return const Center(
            //             child: CircularProgressIndicator(
            //           color: PRIMARY_COLOR_ORANGE_01,
            //         ));
            //       }
            //       CursorPagination<CourseDetailModel> courseList = snapshot.data!;
            //       List<CourseDetailModel> courses = courseList.data;
            //       return courses.isEmpty
            //           ? const Column(
            //               children: [
            //                 SizedBox(
            //                   height: 48.0,
            //                 ),
            //                 Center(
            //                   child: Text(
            //                     "일치하는 강의가 없습니다.",
            //                     style: TextStyle(
            //                         fontSize: 16.0,
            //                         letterSpacing: -0.02,
            //                         height: 1.5,
            //                         color: GRAYSCALE_GRAY_04),
            //                   ),
            //                 )
            //               ],
            //             )
            //           :
            ModulePreviewComponent(
                data: ref.watch(searchModuleProvier!),
                notifierProvider: ref.watch(searchModuleProvier!.notifier),
                isAdd: widget.isAdd,
                isFromCourseEvaluation: true,
                setModule: widget.setModule,
              )

        // SingleChildScrollView(
        //     child: Column(
        //         children:
        //             List.generate(courses.length + 1, (index) {
        //       // if (index == 0) {
        //       //   return Container(
        //       //     padding: const EdgeInsets.symmetric(
        //       //         horizontal: 20.0, vertical: 16.0),
        //       //     child: Text("일치하는 강의가 ${courses.length}개 있습니다"),
        //       //   );
        //       // } else {
        //       //   return coursePreviewCard(courses[index - 1]);
        //       // }
        //       return Column(
        //         children: [
        //           index == 0
        //               ? Container(
        //                   padding: const EdgeInsets.symmetric(
        //                       horizontal: 20.0, vertical: 16.0),
        //                   child: Text(
        //                       "일치하는 강의가 ${courses.length}개 있습니다"),
        //                 )
        //               : coursePreviewCard(courses[index - 1]),
        //           const Divider(
        //             height: 1.0,
        //             color: GRAYSCALE_GRAY_01_5,
        //           )
        //         ],
        //       );
        //     })),
        //   );
        // }),
        );
  }

  Widget recentSearchCard(String history, int index) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        setState(() {
          _searchController.text = history;
        });
        SearchHistoryService.getInstance().then((service) {
          service.addHistory(_searchController.text);
        });

        setSearch();
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              history,
              style: const TextStyle(fontSize: 16.0),
            ),
            const Spacer(),
            const SizedBox(
              width: 8.0,
            ),
            GestureDetector(
              onTap: () {
                SearchHistoryService.getInstance()
                    .then((service) => service.removeHistoryAt(index));
                setState(() {
                  previousSearch!.removeAt(index);
                });
              },
              child: SvgPicture.asset(
                  "assets/img/module_review_screen/close_icon.svg",
                  height: 18.0,
                  width: 18.0),
            )
          ],
        ),
      ),
    );
  }

  Widget coursePreviewCard(CourseDetailModel course) {
    return GestureDetector(
      onTap: widget.isAdd
          ? () {
              widget.setModule!(course.name, course.id);
              Navigator.pop(context);
            }
          : () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => ModuleDetailsScreen(
                    courseId: course.id,
                    moduleName: course.name,
                    courseDetail: course,
                  ))),
      child: Container(
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
          //       course.getStartTimes(),
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
