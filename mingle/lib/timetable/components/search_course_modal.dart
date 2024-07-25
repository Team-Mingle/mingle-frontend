import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mingle/common/component/module_preview_component.dart';
import 'package:mingle/common/component/search_history_service.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/model/cursor_pagination_model.dart';
import 'package:mingle/module/components/toast_message_card.dart';
import 'package:mingle/module/model/course_detail_model.dart';
import 'package:mingle/module/model/course_model.dart';
import 'package:mingle/module/provider/module_provider.dart';
import 'package:mingle/module/repository/course_repository.dart';
import 'package:mingle/timetable/components/course_preview_card.dart';
import 'package:mingle/timetable/view/self_add_timetable_screen.dart';
import 'package:mingle/user/view/my_page_screen/my_page_screen.dart';

class SearchCourseModalWidget extends ConsumerStatefulWidget {
  final Function addClass;
  final Function addClassesAtAddTimeTableScreen;
  final double topPadding;
  const SearchCourseModalWidget(
      {super.key,
      required this.addClass,
      required this.addClassesAtAddTimeTableScreen,
      required this.topPadding});

  @override
  ConsumerState<SearchCourseModalWidget> createState() =>
      _SearchCourseModalWidgetState();
}

class _SearchCourseModalWidgetState
    extends ConsumerState<SearchCourseModalWidget> {
  final TextEditingController _searchController = TextEditingController();
  List<String>? previousSearch;
  Future<CursorPagination<CourseDetailModel>>? searchFuture;
  StateNotifierProvider<ModuleStateNotifier, CursorPaginationBase>?
      searchModuleProvier;
  late FToast fToast;
  bool isSearching = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSearchHistories();
    fToast = FToast();
    fToast.init(context);
  }

  void getSearchHistories() async {
    List<String>? searchHistory =
        (await SearchHistoryService.getInstance()).getHistories();
    setState(() {
      previousSearch = searchHistory;
    });
  }

  void setIsSearching(bool value) {
    setState(() {
      isSearching = value;
    });
  }

  void setSearch() {
    setState(
      () {
        searchFuture = ref
            .watch(courseRepositoryProvider)
            .search(keyword: _searchController.text);

        searchModuleProvier =
            StateNotifierProvider<ModuleStateNotifier, CursorPaginationBase>(
                (ref) {
          final repository = ref.watch(courseRepositoryProvider);

          final notifier = ModuleStateNotifier(
              moduleRepository: repository, keyword: _searchController.text);

          return notifier;
        });
        isSearching = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    void unfocus() {
      print('unfocus called');
      FocusScope.of(context).unfocus();
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {
          isSearching = false;
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(top: isSearching ? 0 : widget.topPadding),
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 16.0,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    height: 40.0,
                    decoration: BoxDecoration(
                        color: GRAYSCALE_GRAY_01,
                        border: Border.all(color: GRAYSCALE_GRAY_01),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextFormField(
                        onTap: () => setState(() {
                          isSearching = true;
                        }),
                        autofocus: false,
                        onEditingComplete: () {
                          if (_searchController.text.isEmpty) {
                            return;
                          }
                          SearchHistoryService.getInstance().then((service) {
                            service.addHistory(_searchController.text);
                          });
                          // FocusScope.of(context).unfocus();
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
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
                const SizedBox(
                  height: 10.0,
                ),
                const Divider(
                  height: 1,
                  color: GRAYSCALE_GRAY_01,
                ),
                // const SizedBox(
                //   height: 16.0,
                // ),
                // const Text(
                //   '최근 검색어 내역이 없습니다.',
                //   style: TextStyle(
                //     color: GRAYSCALE_GRAY_04,
                //     fontSize: 14.0,
                //     letterSpacing: -0.01,
                //     height: 1.4,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
                searchFuture == null
                    ? Column(
                        children: previousSearch == null ||
                                previousSearch!.isEmpty
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
                                            style: TextStyle(
                                                color: GRAYSCALE_GRAY_03),
                                          ),
                                          const Spacer(),
                                          GestureDetector(
                                              child: const Text(
                                                "전체삭제",
                                                style: TextStyle(
                                                    color: GRAYSCALE_GRAY_04,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              onTap: () {
                                                SearchHistoryService
                                                        .getInstance()
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
                    : Expanded(
                        child: ModulePreviewComponent(
                          isFromTimetableAdd: true,
                          data: ref.watch(searchModuleProvier!),
                          setIsSearching: setIsSearching,
                          addClass: widget.addClass,
                          showAddCourseSuccessToast: showAddCourseSuccessToast,
                          addClassesAtAddTimeTableScreen:
                              widget.addClassesAtAddTimeTableScreen,
                          notifierProvider:
                              ref.watch(searchModuleProvier!.notifier),
                        ),
                      )

                // FutureBuilder(
                //     future: searchFuture,
                //     builder: (context,
                //         AsyncSnapshot<CursorPagination<CourseDetailModel>>
                //             snapshot) {
                //       print("hasData: ${snapshot.hasData}");
                //       if (!snapshot.hasData ||
                //           snapshot.connectionState !=
                //               ConnectionState.done) {
                //         return const Padding(
                //           padding: EdgeInsets.only(top: 30.0),
                //           child: Center(
                //               child: CircularProgressIndicator(
                //             color: PRIMARY_COLOR_ORANGE_01,
                //           )),
                //         );
                //       }
                //       CursorPagination<CourseDetailModel> courseList =
                //           snapshot.data!;
                //       List<CourseDetailModel> courses = courseList.data;
                //       return courses.isEmpty
                //           ? Column(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: [
                //                 const SizedBox(
                //                   height: 48.0,
                //                 ),
                //                 const Text(
                //                   "일치하는 강의가 없습니다.",
                //                   style: TextStyle(
                //                       fontSize: 16.0,
                //                       letterSpacing: -0.02,
                //                       height: 1.5,
                //                       color: GRAYSCALE_GRAY_04),
                //                 ),
                //                 const SizedBox(
                //                   height: 17.0,
                //                 ),
                //                 GestureDetector(
                //                   onTap: () {
                //                     Navigator.of(context).pop();
                //                     Navigator.of(context).push(MaterialPageRoute(
                //                         builder: (_) => AddDirectTimeTableScreen(
                //                             addClass: widget.addClass,
                //                             addClassesAtAddTimeTableScreen:
                //                                 widget
                //                                     .addClassesAtAddTimeTableScreen)));
                //                   },
                //                   child: Row(
                //                     mainAxisAlignment:
                //                         MainAxisAlignment.center,
                //                     mainAxisSize: MainAxisSize.min,
                //                     children: [
                //                       const Text(
                //                         "직접 추가하기",
                //                         style: TextStyle(
                //                             fontSize: 12.0,
                //                             fontWeight: FontWeight.w500,
                //                             color: PRIMARY_COLOR_ORANGE_01),
                //                       ),
                //                       SvgPicture.asset(
                //                           "assets/img/timetable_screen/right_tick_icon.svg")
                //                     ],
                //                   ),
                //                 )
                //               ],
                //             )
                //           :
                //           Expanded(
                //               // height: 283,
                //               child: SingleChildScrollView(
                //                 child: Column(
                //                     children: List.generate(
                //                         courses.length + 1, (index) {
                //                   // if (index == 0) {
                //                   //   return Container(
                //                   //     padding: const EdgeInsets.symmetric(
                //                   //         horizontal: 20.0, vertical: 16.0),
                //                   //     child: Text("일치하는 강의가 ${courses.length}개 있습니다"),
                //                   //   );
                //                   // } else {
                //                   //   return coursePreviewCard(courses[index - 1]);
                //                   // }
                //                   return Column(
                //                     children: [
                //                       index == 0
                //                           ? Container(
                //                               padding: const EdgeInsets
                //                                   .symmetric(
                //                                   horizontal: 20.0,
                //                                   vertical: 16.0),
                //                               child: Text(
                //                                   "일치하는 강의가 ${courses.length}개 있습니다"),
                //                             )
                //                           : CoursePreviewCard(
                //                               showAddCourseSuccessToast:
                //                                   showAddCourseSuccessToast,
                //                               addClass: widget.addClass,
                //                               addClassesAtAddTimeTableScreen:
                //                                   widget
                //                                       .addClassesAtAddTimeTableScreen,
                //                               course: courses[index - 1],
                //                               setIsSearching:
                //                                   setIsSearching,
                //                             ),
                //                       const Divider(
                //                         height: 1.0,
                //                         color: GRAYSCALE_GRAY_01_5,
                //                       )
                //                     ],
                //                   );
                //                 })),
                //               ),
                //             );
                //     }),
              ],
            ),
          ),
        ),
      ),
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
  //

  void showAddCourseSuccessToast() {
    fToast.showToast(
        child: const ToastMessage(message: "강의가 추가되었습니다"),
        toastDuration: const Duration(seconds: 2),
        gravity: ToastGravity.CENTER);
  }
}
