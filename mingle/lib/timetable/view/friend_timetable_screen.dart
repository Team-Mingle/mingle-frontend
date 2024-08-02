import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/main.dart';
import 'package:mingle/module/components/toast_message_card.dart';
import 'package:mingle/module/model/course_detail_model.dart';
import 'package:mingle/module/model/course_model.dart';
import 'package:mingle/module/view/add_module_review_screen.dart';
import 'package:mingle/module/view/module_details_screen.dart';
import 'package:mingle/timetable/components/timetable_grid.dart';
import 'package:mingle/timetable/model/timetable_list_model.dart';
import 'package:mingle/timetable/model/timetable_model.dart';
import 'package:mingle/timetable/provider/timetable_grid_height_divider_value_provider.dart';
import 'package:mingle/timetable/repository/friend_repository.dart';
import 'package:mingle/timetable/repository/timetable_repository.dart';

class FriendTimetableScreen extends ConsumerStatefulWidget {
  final int friendId;
  String friendName;
  final Function refreshFriendList;

  FriendTimetableScreen({
    super.key,
    required this.friendId,
    required this.friendName,
    required this.refreshFriendList,
  });

  @override
  ConsumerState<FriendTimetableScreen> createState() =>
      _FriendTimetableScreenState();
}

class _FriendTimetableScreenState extends ConsumerState<FriendTimetableScreen> {
  List<TimetableModel> timetables = [];
  TimetableModel? currentTimetable;
  List<Widget> addedClasses = [];
  String newFriendName = "";
  late FToast fToast;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fToast = FToast();
    fToast.init(navigatorKey.currentContext!);

    getTimetables();
  }

  void deleteFriend() async {
    try {
      await ref
          .read(friendRepositoryProvider)
          .deleteFriend(friendId: widget.friendId);
      widget.refreshFriendList();
      fToast.showToast(
        child: const ToastMessage(message: "친구가 삭제되었습니다."),
        gravity: ToastGravity.CENTER,
        toastDuration: const Duration(seconds: 2),
      );
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } on DioException catch (e) {
      print(e);
    }
  }

  void getTimetables() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<TimetableModel> friendTimetables = (await ref
              .read(timetableRepositoryProvider)
              .getFriendTimetables(friendId: widget.friendId))
          .friendTimetableDetailList;
      TimetableModel? selectedTimetable =
          friendTimetables.isEmpty ? null : friendTimetables[0];
      List<CourseDetailModel> courses = selectedTimetable == null
          ? []
          : selectedTimetable.coursePreviewDtoList;
      setState(() {
        timetables = friendTimetables;
        currentTimetable =
            friendTimetables.isEmpty ? null : friendTimetables[0];
      });
      generateClassWidgets(courses);
      setState(() {
        isLoading = false;
      });
    } on DioException catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  void generateClassWidgets(List<CourseDetailModel> courses) {
    List<Widget> coursesToBeAdded = [];
    for (CourseDetailModel course in courses) {
      coursesToBeAdded.addAll(course.generateClasses(
          () => showCourseDetailModal(course),
          ref,
          currentTimetable!.getGridTotalHeightDividerValue(),
          isFull: true));
    }
    setState(() {
      addedClasses = coursesToBeAdded;
    });
  }

  void changeFriendName() async {
    try {
      if (newFriendName == widget.friendName) {
        return;
      }
      await ref.watch(friendRepositoryProvider).changeFriendName(
          friendId: widget.friendId,
          changeFriendNameDto: ChangeFriendNameDto(friendName: newFriendName));
      // await ref.watch(timetableRepositoryProvider).changeTimetableName(
      //     timetableId: ref.read(pinnedTimetableIdProvider)!,
      //     changeTimetableNameDto:
      //         ChangeTimetableNameDto(name: newTimetableName));
      widget.refreshFriendList();
      setState(() {
        widget.friendName = newFriendName;
      });
      fToast.showToast(
        child: const ToastMessage(message: "친구의 이름이 변경되었습니다."),
        gravity: ToastGravity.CENTER,
        toastDuration: const Duration(seconds: 2),
      );
    } on DioException catch (e) {
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
    ref.listen(timetableGridHeightDividerValueProvider, (prev, next) {
      if (prev != next) {
        generateClassWidgets(currentTimetable!.coursePreviewDtoList);
      }
    });
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
          title: Text(
            "${widget.friendName}의 시간표",
            style: const TextStyle(fontSize: 16.0, letterSpacing: -0.32),
          ),
          actions: [
            IconButton(
              icon: Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/img/common/ic_setting.svg',
                  width: 24,
                  height: 24,
                ),
              ),
              onPressed: showFriendTimetableSettingModal,
            ),
          ],
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: PRIMARY_COLOR_ORANGE_01,
                ),
              )
            : timetables.isEmpty
                ? const Center(
                    child: Text(
                      "친구는 아직 시간표를 만들지 않았어요.",
                      style: TextStyle(color: GRAYSCALE_GRAY_04),
                    ),
                  )
                : Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: renderSelectedSemesterWidget(),
                          ),
                        ),
                      ),
                      TimeTableGrid(
                        isFull: true,
                        timetable: currentTimetable!,
                        addedClasses: addedClasses,
                      ),
                    ],
                  )
        // FutureBuilder(
        //     future: ref
        //         .watch(timetableRepositoryProvider)
        //         .getFriendTimetables(friendId: widget.friendId),
        //     builder: (context, snapshot) {
        //       if (!snapshot.hasData) {
        //         return const Center(
        //           child: CircularProgressIndicator(
        //             color: PRIMARY_COLOR_ORANGE_01,
        //           ),
        //         );
        //       }

        //       FriendTimetableListModel friendTimetableListModel =
        //           snapshot.data as FriendTimetableListModel;
        //       List<TimetableModel> friendTimetables =
        //           friendTimetableListModel.friendTimetableDetailList;
        //           TimetableModel? selectedTimetable =
        //     friendTimetables.isEmpty ? null : friendTimetables[0];
        // List<CourseModel> courses = selectedTimetable == null
        //     ? []
        //     : selectedTimetable.coursePreviewDtoList;
        // generateClassWidgets(courses);
        // setState(() {
        //   timetables = friendTimetables;
        //   currentTimetable =
        //       friendTimetables.isEmpty ? null : friendTimetables[0];
        // });
        // return Column(
        //   children: [
        //     Container(
        //       width: double.infinity,
        //       padding: const EdgeInsets.symmetric(
        //           horizontal: 16.0, vertical: 12.0),
        //       child: SingleChildScrollView(
        //         scrollDirection: Axis.horizontal,
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           children: renderSelectedSemesterWidget(),
        //         ),
        //       ),
        //     ),
        //     TimeTableGrid(
        //       isFull: true,
        //       addedClasses: addedClasses,
        //     ),
        //   ],
        // );
        //     }),
        );
  }

  List<Widget> renderSelectedSemesterWidget() {
    return List.generate((2 * timetables.length) - 1, (index) {
      if (index % 2 != 0) {
        return const SizedBox(
          width: 4.0,
        );
      }
      TimetableModel timetable = timetables[index ~/ 2];
      bool isSelected = currentTimetable == timetable;
      return GestureDetector(
        onTap: () {
          generateClassWidgets(timetable.coursePreviewDtoList);
          setState(() {
            currentTimetable = timetable;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
              border: Border.all(
                  color:
                      isSelected ? PRIMARY_COLOR_ORANGE_01 : GRAYSCALE_GRAY_03),
              borderRadius: BorderRadius.circular(16.0)),
          child: Text(
            TimetableListModel.convertKeyToSemester(timetable.semester),
            style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color:
                    isSelected ? PRIMARY_COLOR_ORANGE_01 : GRAYSCALE_GRAY_02),
          ),
        ),
      );
    });
  }

  void showCourseDetailModal(CourseDetailModel currentCourse) {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      isScrollControlled: false,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                height: 311.0,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentCourse.name,
                      style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.32),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      currentCourse.courseCode,
                      style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.32),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      "${currentCourse.professor} ${currentCourse.getStartTimes()}",
                      style: const TextStyle(
                          color: GRAYSCALE_GRAY_04, letterSpacing: -0.14),
                    ),
                    const Divider(
                      height: 32.0,
                      color: GRAYSCALE_GRAY_01_5,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ModuleDetailsScreen(
                            courseId: currentCourse.id,
                            moduleName: currentCourse.name,
                            courseDetail: currentCourse,
                          ),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14.0),
                        child: Text(
                          "강의상세/ 강의평 보기",
                          style:
                              TextStyle(fontSize: 16.0, letterSpacing: -0.32),
                        ),
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () => Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //         builder: (_) => AddModuleReviewScreen(
                    //               moduleId: currentCourse.id,
                    //               moduleName: currentCourse.name,
                    //             )),
                    //   ),
                    //   child: const Padding(
                    //     padding: EdgeInsets.symmetric(vertical: 14.0),
                    //     child: Text(
                    //       "강의평 작성하기",
                    //       style:
                    //           TextStyle(fontSize: 16.0, letterSpacing: -0.32),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showFriendTimetableSettingModal() => showModalBottomSheet<void>(
        isScrollControlled: false,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            height: 176,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    showChangeFriendNameDialog();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    child: const Text(
                      "친구 이름 변경하기",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    showDeleteFriendDialog();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    child: const Text(
                      "친구 삭제하기",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      );

  void showChangeFriendNameDialog() {
    setState(() {
      newFriendName = widget.friendName;
    });
    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            insetPadding: EdgeInsets.zero,
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
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
                        "친구 이름 변경하기",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.32),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Container(
                        height: 48.0,
                        width: 279.0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: GRAYSCALE_GRAY_02),
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                          child: TextFormField(
                            initialValue: widget.friendName,
                            maxLength: 10,
                            onChanged: (name) {
                              setState(() {
                                newFriendName = name;
                              });
                            },
                            decoration: InputDecoration(
                              counterText: "",
                              border: InputBorder.none,
                              suffix: Text("${newFriendName.length}/10"),
                              hintText: "새 친구 이름을 작성하세요.",
                              hintStyle: const TextStyle(
                                  color: GRAYSCALE_GRAY_03, fontSize: 16.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
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
                                  "취소하기",
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
                              changeFriendName();
                            },
                            child: Container(
                              height: 40.0,
                              width: 120.0,
                              decoration: BoxDecoration(
                                  color: PRIMARY_COLOR_ORANGE_02,
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: const Center(
                                child: Text(
                                  "변경하기",
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
          );
        },
      ),
    );
  }

  void showDeleteFriendDialog() {
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
                    "친구를 삭제하시겠습니까?",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.32),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Text(
                    "이 작업은 되돌릴 수 없습니다.",
                    style: TextStyle(
                        color: GRAYSCALE_GRAY_04, letterSpacing: -0.14),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          deleteFriend();
                        },
                        child: Container(
                          height: 40.0,
                          width: 120.0,
                          decoration: BoxDecoration(
                              color: GRAYSCALE_GRAY_01,
                              borderRadius: BorderRadius.circular(8.0)),
                          child: const Center(
                            child: Text(
                              "삭제하기",
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
                        onTap: () => Navigator.of(context).pop(),
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
