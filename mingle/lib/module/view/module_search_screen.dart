import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/model/cursor_pagination_model.dart';
import 'package:mingle/module/model/course_model.dart';
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
  List<String> previousSearch = ["CS3230", "CS3203"];
  final TextEditingController _searchController = TextEditingController();
  Future<CursorPagination<CourseModel>>? searchFuture;
  @override
  void initState() {
    super.initState();
  }

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
              AssetImage("assets/img/module_review_screen/back_tick_icon.png"),
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
      ),
      body: searchFuture == null
          ? Column(
              children: previousSearch.isEmpty
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
                      previousSearch.length + 1,
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
                                  onTap: () => setState(() {
                                    previousSearch.clear();
                                  }),
                                )
                              ]),
                            )
                          : recentSearchCard(
                              previousSearch[index - 1], index - 1),
                    ),
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
                    : SingleChildScrollView(
                        child: Column(
                            children:
                                List.generate(courses.length + 1, (index) {
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 16.0),
                                      child: Text(
                                          "일치하는 강의가 ${courses.length}개 있습니다"),
                                    )
                                  : coursePreviewCard(courses[index - 1]),
                              const Divider(
                                height: 1.0,
                                color: GRAYSCALE_GRAY_01_5,
                              )
                            ],
                          );
                        })),
                      );
              }),
    );
  }

  Widget recentSearchCard(String moduleCode, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
      child: Row(
        children: [
          Text(
            moduleCode,
            style: const TextStyle(fontSize: 16.0),
          ),
          const Spacer(),
          const SizedBox(
            width: 8.0,
          ),
          GestureDetector(
            onTap: () => setState(() {
              previousSearch.removeAt(index);
            }),
            child: SvgPicture.asset(
                "assets/img/module_review_screen/close_icon.svg",
                height: 18.0,
                width: 18.0),
          )
        ],
      ),
    );
  }

  Widget coursePreviewCard(CourseModel course) {
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
          Row(
            children: [
              Text(
                course.professor,
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
              )
            ],
          )
        ]),
      ),
    );
  }
}
