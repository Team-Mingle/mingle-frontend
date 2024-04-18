import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/model/cursor_pagination_model.dart';
import 'package:mingle/module/model/course_model.dart';
import 'package:mingle/module/repository/course_repository.dart';
import 'package:mingle/timetable/components/course_preview_card.dart';
import 'package:mingle/user/view/my_page_screen/my_page_screen.dart';

class SearchCourseModalWidget extends ConsumerStatefulWidget {
  final Function addClass;
  final Function addClassesAtAddTimeTableScreen;
  const SearchCourseModalWidget({
    super.key,
    required this.addClass,
    required this.addClassesAtAddTimeTableScreen,
  });

  @override
  ConsumerState<SearchCourseModalWidget> createState() =>
      _SearchCourseModalWidgetState();
}

class _SearchCourseModalWidgetState
    extends ConsumerState<SearchCourseModalWidget> {
  final TextEditingController _searchController = TextEditingController();
  Future<CursorPagination<CourseModel>>? searchFuture;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 16.0,
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: GRAYSCALE_GRAY_01,
            //       borderRadius: BorderRadius.circular(8.0),
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //       child: Row(
            //         children: [
            //           const Expanded(
            //             child: TextField(
            //               textAlignVertical: TextAlignVertical.bottom,
            //               decoration: InputDecoration(
            //                 hintText: "강의명을 입력하세요",
            //                 border: InputBorder.none,
            //               ),
            //             ),
            //           ),
            //           IconButton(
            //             icon: Align(
            //               alignment: Alignment.center,
            //               child: SvgPicture.asset(
            //                 'assets/img/common/ic_search.svg',
            //                 width: 24,
            //                 height: 24,
            //               ),
            //             ),
            //             onPressed: () => Navigator.of(context).push(
            //                 MaterialPageRoute(
            //                     builder: (_) => const MyPageScreen())),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                    color: GRAYSCALE_GRAY_01,
                    border: Border.all(color: GRAYSCALE_GRAY_01),
                    borderRadius: BorderRadius.circular(8.0)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: TextFormField(
                    autofocus: true,
                    onEditingComplete: () {
                      setState(() {
                        searchFuture = ref
                            .watch(courseRepositoryProvider)
                            .search(keyword: _searchController.text);
                      });
                    },
                    textAlignVertical: TextAlignVertical.center,
                    obscureText: false,
                    decoration: InputDecoration(
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
            const SizedBox(
              height: 10.0,
            ),
            const Divider(
              height: 1,
              color: GRAYSCALE_GRAY_01,
            ),
            const SizedBox(
              height: 16.0,
            ),
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
                ? const Column(children:
                        //  previousSearch.isEmpty
                        // ?
                        [
                    SizedBox(
                      height: 48.0,
                    ),
                    Align(
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
                    // :
                    // List.generate(
                    //     previousSearch.length + 1,
                    //     (index) => index == 0
                    //         ? Container(
                    //             padding: const EdgeInsets.only(
                    //                 left: 20.0, right: 20.0, top: 16.0),
                    //             child: Row(children: [
                    //               const Text(
                    //                 "최근 검색어",
                    //                 style: TextStyle(color: GRAYSCALE_GRAY_03),
                    //               ),
                    //               const Spacer(),
                    //               GestureDetector(
                    //                 child: const Text(
                    //                   "전체삭제",
                    //                   style: TextStyle(
                    //                       color: GRAYSCALE_GRAY_04,
                    //                       fontWeight: FontWeight.w500),
                    //                 ),
                    //                 onTap: () => setState(() {
                    //                   previousSearch.clear();
                    //                 }),
                    //               )
                    //             ]),
                    //           )
                    //         : recentSearchCard(
                    //             previousSearch[index - 1], index - 1),
                    //   ),
                    )
                : FutureBuilder(
                    future: searchFuture,
                    builder: (context,
                        AsyncSnapshot<CursorPagination<CourseModel>> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      CursorPagination<CourseModel> courseList = snapshot.data!;
                      List<CourseModel> courses = courseList.data;
                      return courses.isEmpty
                          ? const Column(
                              children: [
                                SizedBox(
                                  height: 48.0,
                                ),
                                Text(
                                  "일치하는 강의가 없습니다.",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      letterSpacing: -0.02,
                                      height: 1.5,
                                      color: GRAYSCALE_GRAY_04),
                                )
                              ],
                            )
                          : SizedBox(
                              height: 373,
                              child: SingleChildScrollView(
                                child: Column(
                                    children: List.generate(courses.length + 1,
                                        (index) {
                                  // if (index == 0) {
                                  //   return Container(
                                  //     padding: const EdgeInsets.symmetric(
                                  //         horizontal: 20.0, vertical: 16.0),
                                  //     child: Text("일치하는 강의가 ${courses.length}개 있습니다"),
                                  //   );
                                  // } else {
                                  //   return coursePreviewCard(courses[index - 1]);
                                  // }
                                  return Column(
                                    children: [
                                      index == 0
                                          ? Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 16.0),
                                              child: Text(
                                                  "일치하는 강의가 ${courses.length}개 있습니다"),
                                            )
                                          : CoursePreviewCard(
                                              addClass: widget.addClass,
                                              addClassesAtAddTimeTableScreen: widget
                                                  .addClassesAtAddTimeTableScreen,
                                              course: courses[index - 1]),
                                      const Divider(
                                        height: 1.0,
                                        color: GRAYSCALE_GRAY_01_5,
                                      )
                                    ],
                                  );
                                })),
                              ),
                            );
                    }),
          ],
        ),
      ),
    );
  }

  //
}
