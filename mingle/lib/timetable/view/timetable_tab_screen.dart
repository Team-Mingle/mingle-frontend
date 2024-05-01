// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:mingle/common/component/expanded_section.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/module/components/toast_message_card.dart';
import 'package:mingle/module/model/course_detail_model.dart';
import 'package:mingle/module/model/course_model.dart';
import 'package:mingle/module/view/add_module_review_screen.dart';
import 'package:mingle/module/view/first_onboarding_screen.dart';
import 'package:mingle/module/view/module_details_screen.dart';
import 'package:mingle/module/view/module_review_main_screen.dart';
import 'package:mingle/secure_storage/secure_storage.dart';
import 'package:mingle/timetable/components/add_friend_dialog.dart';
import 'package:mingle/timetable/components/timetable_screenshot_grid.dart';
import 'package:mingle/timetable/model/class_model.dart';
import 'package:mingle/module/model/course_model.dart';
import 'package:mingle/timetable/model/friend_model.dart';
import 'package:mingle/timetable/model/timetable_list_model.dart';
import 'package:mingle/timetable/model/timetable_model.dart';
import 'package:mingle/timetable/provider/pinned_timetable_id_provider.dart';
import 'package:mingle/timetable/provider/pinned_timetable_id_provider.dart';
import 'package:mingle/timetable/provider/pinned_timetable_provider.dart';
import 'package:mingle/timetable/repository/friend_repository.dart';
import 'package:mingle/timetable/repository/timetable_repository.dart';
import 'package:mingle/timetable/view/add_timetable_screen.dart';
import 'package:mingle/timetable/components/timetable_grid.dart';
import 'package:mingle/timetable/view/edit_self_added_course_screen.dart';
import 'package:mingle/timetable/view/friend_timetable_screen.dart';
import 'package:mingle/timetable/view/timetable_list_screen.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image/image.dart' as IMG;

class TimeTableHomeScreen extends ConsumerStatefulWidget {
  const TimeTableHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<TimeTableHomeScreen> createState() =>
      _TimeTableHomeScreenState();
}

class _TimeTableHomeScreenState extends ConsumerState<TimeTableHomeScreen> {
  bool _isFriendListExpanded = false;
  TimetableModel? timetable;
  List<Color> usedCoursePalette = [];
  List<Widget> addedCourses = [];
  int flag = 1;
  String friendCode = "";
  String friendDisplayName = "";
  String myDisplayName = "";
  bool isLoading = false;
  String newTimetableName = "";
  List<FriendModel> friendList = [];
  final ScrollController scrollController = ScrollController();
  ScreenshotController screenshotController = ScreenshotController();
  late FToast fToast;

  @override
  void initState() {
    checkIsOnboarding();
    // TODO: implement initState
    super.initState();
    getClasses();
    getFriends();
    fToast = FToast();
    fToast.init(context);
  }

  void checkIsOnboarding() async {
    if (await ref
            .read(secureStorageProvider)
            .read(key: IS_FRESH_ONBOARDING_KEY) ==
        'y') {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const FirstOnboardingScreen()));
    }
  }

  void getClasses() async {
    // await ref.read(pinnedTimetableIdProvider.notifier).fetchPinnedTimetable();
    TimetableModel? currentTimetable = ref.read(pinnedTimetableProvider);
    if (currentTimetable == null) {
      setState(() {
        timetable = null;
        flag = 0;
      });
      return;
    }
    setState(() {
      flag = 1;
    });
    // await ref
    //     .read(timetableRepositoryProvider)
    //     .getTimetable(timetableId: ref.read(pinnedTimetableIdProvider)!);
    List<CourseDetailModel> courses = currentTimetable.coursePreviewDtoList;
    List<Widget> coursesToBeAdded = [];
    for (CourseDetailModel course in courses) {
      coursesToBeAdded.addAll(course.generateClasses(() {
        if (course.courseType == "PERSONAL") {
          showSelfAddedCourseDetailModal(course);
        } else {
          showCourseDetailModal(course);
        }
      }));
    }
    setState(() {
      timetable = currentTimetable;
      newTimetableName = currentTimetable.name;
      addedCourses = coursesToBeAdded;
    });
  }

  void getFriends() async {
    try {
      List<FriendModel> friends =
          (await ref.read(friendRepositoryProvider).getFriends()).friendList;
      setState(() {
        friendList = friends;
      });
    } on DioException catch (e) {
      print(e);
    }
  }

  void deleteTimetable(int timetableId) async {
    try {
      await ref
          .watch(timetableRepositoryProvider)
          .deleteTimetable(timetableId: timetableId);
      ref.read(pinnedTimetableIdProvider.notifier).fetchPinnedTimetableId();
    } on DioException catch (e) {
      print(e.response?.data['message']);
      fToast.showToast(
        child: const ToastMessage(message: generalErrorMsg),
        gravity: ToastGravity.CENTER,
        toastDuration: const Duration(seconds: 2),
      );
    }
  }

  void changeTimetableName(String newTimetableName) async {
    try {
      if (newTimetableName == timetable!.name) {
        return;
      }
      await ref.watch(timetableRepositoryProvider).changeTimetableName(
          timetableId: ref.read(pinnedTimetableIdProvider)!,
          changeTimetableNameDto:
              ChangeTimetableNameDto(name: newTimetableName));
      setState(() {
        timetable!.name = newTimetableName;
      });
    } on DioException catch (e) {
      fToast.showToast(
        child: ToastMessage(
            message: e.response?.data['message'] ?? generalErrorMsg),
        gravity: ToastGravity.CENTER,
        toastDuration: const Duration(seconds: 2),
      );
    }
  }

  setTimetableName(String newTimetableName) {
    setState(() {
      timetable!.name = newTimetableName;
    });
  }

  void addFriend() async {
    setState(() {
      isLoading = true;
    });
    if (friendDisplayName.isEmpty) {
      fToast.showToast(
        child: const ToastMessage(message: "이름을 입력해주세요."),
        gravity: ToastGravity.CENTER,
        toastDuration: const Duration(seconds: 2),
      );
      setState(() {
        isLoading = false;
      });
      return;
    }
    try {
      await ref.watch(friendRepositoryProvider).addFriend(
          AddFriendDto(friendCode: friendCode, myDisplayName: myDisplayName));
      getFriends();
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } on DioException catch (e) {
      setState(() {
        isLoading = false;
      });
      fToast.showToast(
        child: ToastMessage(
            message: e.response?.data['message'] ?? generalErrorMsg),
        gravity: ToastGravity.CENTER,
        toastDuration: const Duration(seconds: 2),
      );
    }
  }

  void showTimetableSettingModal(
          {required double screenHeight, required double screenWidth}) =>
      showModalBottomSheet<void>(
        isScrollControlled: false,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            // height: 176,
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
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    showChangeTimetableNameDialog();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    child: const Text(
                      "시간표 이름 변경하기",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    deleteTimetable(ref.read(pinnedTimetableIdProvider)!);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    child: const Text(
                      "시간표 삭제하기",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
                    screenshotController
                        .captureFromLongWidget(
                      InheritedTheme.captureAll(
                        context,
                        Material(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: TimeTableScreenshotGrid(
                            addedClasses: addedCourses,
                          ),
                        )),
                      ),
                      pixelRatio: pixelRatio,
                      delay: const Duration(milliseconds: 100),
                      context: context,

                      ///
                      /// Additionally you can define constraint for your image.
                      ///
                      // constraints: BoxConstraints(
                      //   maxHeight:
                      //       MediaQuery.of(context).size.height - 37,
                      //   maxWidth: MediaQuery.of(context).size.width,
                      // )
                    )
                        .then(
                      (capturedImage) async {
                        final container = SizedBox(
                            height: screenHeight - 50,
                            width: screenWidth,
                            child: Image.memory(
                              capturedImage,
                              fit: BoxFit.contain,
                            ));
                        screenshotController
                            .captureFromWidget(container)
                            .then((image) async {
                          await ImageGallerySaver.saveImage(image);
                        });
                        // Uint8List resizedImage = capturedImage;
                        // resizedImage =
                        //     await FlutterImageCompress.compressWithList(
                        //   resizedImage,
                        //   minHeight:
                        //       MediaQuery.of(context).size.height.round() - 100,
                        //   minWidth:
                        //       MediaQuery.of(context).size.width.round() - 50,
                        // );
                        // IMG.Image img = IMG.decodeImage(resizedImage)!;
                        // IMG.Image resized = IMG.copyResize(img,
                        //     width: img.width *
                        //         ((MediaQuery.of(context).size.height - 50)
                        //             .round()) ~/
                        //         img.height,
                        //     height: (MediaQuery.of(context).size.height - 50)
                        //         .round());
                        // resizedImage = IMG.encodeJpg(resized);
                        // await ImageGallerySaver.saveImage(capturedImage);
                        fToast.showToast(
                          child: const ToastMessage(message: "갤러리에 저장되었습니다"),
                          gravity: ToastGravity.CENTER,
                          toastDuration: const Duration(seconds: 2),
                        );
                        // Handle captured image
                      },
                    ).onError((error, stackTrace) {
                      print(error);
                      print(stackTrace);
                      fToast.showToast(
                        child: const ToastMessage(message: generalErrorMsg),
                        gravity: ToastGravity.CENTER,
                        toastDuration: const Duration(seconds: 2),
                      );
                    });
                    Navigator.of(context).pop();
                    // deleteTimetable(ref.read(pinnedTimetableIdProvider)!);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    child: const Text(
                      "시간표 저장하기",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      );

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
                // height: 311.0,
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
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ModuleDetailsScreen(
                              courseId: currentCourse.id,
                              moduleName: currentCourse.name,
                              courseDetail: currentCourse,
                            ),
                          ),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14.0),
                        child: Text(
                          "강의상세/ 강의평 보기",
                          style:
                              TextStyle(fontSize: 16.0, letterSpacing: -0.32),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => AddModuleReviewScreen(
                              moduleId: currentCourse.id,
                              moduleName: currentCourse.name,
                            ),
                          ),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14.0),
                        child: Text(
                          "강의평 작성하기",
                          style:
                              TextStyle(fontSize: 16.0, letterSpacing: -0.32),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        // deleteClass(currentCourse);
                        showDeleteCourseDialog(currentCourse);
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14.0),
                        child: Text(
                          "삭제하기",
                          style:
                              TextStyle(fontSize: 16.0, letterSpacing: -0.32),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showSelfAddedCourseDetailModal(CourseDetailModel currentCourse) {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      isScrollControlled: false,
      context: context,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            height: 311.0,
            color: Colors.white,
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
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
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => ModuleDetailsScreen(
                              courseId: currentCourse.id,
                              moduleName: currentCourse.name,
                              courseDetail: currentCourse,
                            )));
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14.0),
                    child: Text(
                      "강의 상세보기",
                      style: TextStyle(fontSize: 16.0, letterSpacing: -0.32),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => EditSelfAddedCourseScreen(
                              course: currentCourse,
                              refreshClasses: getClasses,
                            )));
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14.0),
                    child: Text(
                      "강의 수정하기",
                      style: TextStyle(fontSize: 16.0, letterSpacing: -0.32),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    showDeleteCourseDialog(currentCourse);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14.0),
                    child: Text(
                      "삭제하기",
                      style: TextStyle(fontSize: 16.0, letterSpacing: -0.32),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void addClass(CourseDetailModel courseModel, bool overrideValidation) {
    if (overrideValidation) {
      getClasses();
      return;
    }
    List<Widget> newCourses = [...addedCourses];
    newCourses.addAll(courseModel.generateClasses(() {
      if (courseModel.courseType == "PERSONAL") {
        showSelfAddedCourseDetailModal(courseModel);
      } else {
        showCourseDetailModal(courseModel);
      }
    }));
    setState(() {
      addedCourses = newCourses;
      // addedCourses.addAll(courseModel.generateClasses(() {
      //   print("tapped");
      //   showCourseDetailModal(courseModel);
      // }));
    });
  }

  void deleteClass(CourseDetailModel courseModel) async {
    try {
      List<Widget> newAddedCourses = [];
      TimetableModel newTimetable = timetable!;
      for (int i = 0; i < timetable!.coursePreviewDtoList.length; i++) {
        CourseDetailModel detailModel = timetable!.coursePreviewDtoList[i];
        if (detailModel.id != courseModel.id) {
          newAddedCourses.addAll(detailModel.generateClasses(() {
            if (detailModel.courseType == "PERSONAL") {
              showSelfAddedCourseDetailModal(detailModel);
            } else {
              showCourseDetailModal(detailModel);
            }
          }));
        }
      }
      print(newAddedCourses);
      print(addedCourses);
      setState(() {
        addedCourses = newAddedCourses;
        timetable = newTimetable;
      });
      await ref.read(timetableRepositoryProvider).deleteCourse(
          timetableId: ref.watch(pinnedTimetableIdProvider)!,
          courseId: courseModel.id);
      // getClasses();
    } on DioException catch (e) {
      print(e);
    }
  }

  Future<dynamic> shareOrRegisterModal() => showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            height: 192.0,
            padding: const EdgeInsets.symmetric(horizontal: 20.0)
                .copyWith(top: 32.0, bottom: 40.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    firstShareCodeModal();
                  },
                  child: const SizedBox(
                    height: 56.0,
                    child: Center(
                        child: Text(
                      "내 코드 공유하기",
                      style: TextStyle(fontSize: 16.0),
                    )),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    firstRegisterCodeModal();
                  },
                  child: const SizedBox(
                    height: 56.0,
                    child: Center(
                        child: Text(
                      "다른 사용자 코드 등록하기",
                      style: TextStyle(fontSize: 16.0),
                    )),
                  ),
                ),
              ],
            ),
          );
        },
      );

  Future<dynamic> firstRegisterCodeModal() => showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return AnimatedPadding(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: 412.0,
              padding: const EdgeInsets.symmetric(horizontal: 20.0)
                  .copyWith(top: 20.0, bottom: 24.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: SvgPicture.asset(
                              "assets/img/timetable_screen/close.svg"),
                        ),
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 4.0,
                      ),
                      const Text(
                        "다른 사용자 코드 등록하기",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(
                        height: 37.0,
                      ),
                      Container(
                        height: 48.0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: GRAYSCALE_GRAY_02),
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                          child: TextFormField(
                            onChanged: (code) {
                              setState(() {
                                friendCode = code;
                              });
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "다른 사용자의 코드를 붙여넣으세요.",
                              hintStyle: TextStyle(
                                  color: GRAYSCALE_GRAY_03, fontSize: 16.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 152.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          firstShareCodeModal();
                        },
                        child: Container(
                          height: 48.0,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: PRIMARY_COLOR_ORANGE_02),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: const Center(
                            child: Text(
                              "내 코드 공유할래요",
                              style: TextStyle(color: PRIMARY_COLOR_ORANGE_02),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      GestureDetector(
                        onTap: () => secondRegisterCodeModal(),
                        child: Container(
                          height: 48.0,
                          decoration: BoxDecoration(
                              color: PRIMARY_COLOR_ORANGE_02,
                              border:
                                  Border.all(color: PRIMARY_COLOR_ORANGE_02),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: const Center(
                            child: Text(
                              "다음",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );

  Future<dynamic> secondRegisterCodeModal() => showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          print("bottom padding: ${MediaQuery.of(context).viewInsets.bottom}");
          return AnimatedPadding(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: 415.0,
              padding: const EdgeInsets.symmetric(horizontal: 20.0)
                  .copyWith(top: 20.0, bottom: 24.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: SvgPicture.asset(
                              "assets/img/timetable_screen/close.svg"),
                        ),
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 4.0,
                      ),
                      const Text(
                        "다른 사용자 코드 등록하기",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      const Text(
                        "친구에게 보여질 이름을 작성하세요.",
                        style: TextStyle(color: GRAYSCALE_GRAY_04),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Container(
                        height: 48.0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: GRAYSCALE_GRAY_02),
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                          child: TextFormField(
                            onChanged: (name) {
                              setState(() {
                                friendDisplayName = name;
                              });
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "이름 입력",
                              hintStyle: TextStyle(
                                  color: GRAYSCALE_GRAY_03, fontSize: 16.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 152.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          firstShareCodeModal();
                        },
                        child: Container(
                          height: 48.0,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: PRIMARY_COLOR_ORANGE_02),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: const Center(
                            child: Text(
                              "내 코드 공유할래요",
                              style: TextStyle(color: PRIMARY_COLOR_ORANGE_02),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      isLoading
                          ? const CircularProgressIndicator(
                              color: PRIMARY_COLOR_ORANGE_02,
                            )
                          : GestureDetector(
                              onTap: addFriend,
                              child: Container(
                                height: 48.0,
                                decoration: BoxDecoration(
                                    color: PRIMARY_COLOR_ORANGE_02,
                                    border: Border.all(
                                        color: PRIMARY_COLOR_ORANGE_02),
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: const Center(
                                  child: Text(
                                    "친구 추가 마치기",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );

  Future<String?> firstShareCodeModal() async {
    String defaultName =
        await ref.watch(friendRepositoryProvider).getDefaultName();
    setState(() {
      myDisplayName = defaultName;
    });
    return showModalBottomSheet<String>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) {
          return AnimatedPadding(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Container(
                height: 415.0,
                padding: const EdgeInsets.symmetric(horizontal: 20.0)
                    .copyWith(top: 20.0, bottom: 24.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Stack(
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: SvgPicture.asset(
                                "assets/img/timetable_screen/close.svg"),
                          ),
                        )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 4.0,
                        ),
                        const Text(
                          "내 코드 공유하기",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        const Text(
                          "친구에게 보여질 이름을 작성하세요.",
                          style: TextStyle(color: GRAYSCALE_GRAY_04),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Container(
                          height: 48.0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(color: GRAYSCALE_GRAY_02),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Center(
                            child: TextFormField(
                              maxLength: 10,
                              onChanged: (name) {
                                setState(() {
                                  myDisplayName = name;
                                });
                              },
                              initialValue: defaultName,
                              decoration: InputDecoration(
                                counterText: "",
                                border: InputBorder.none,
                                suffix: Text("${myDisplayName.length}/10"),
                                hintText: "이름 입력",
                                hintStyle: const TextStyle(
                                    color: GRAYSCALE_GRAY_03, fontSize: 16.0),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 152.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            firstRegisterCodeModal();
                          },
                          child: Container(
                            height: 48.0,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: PRIMARY_COLOR_ORANGE_02),
                                borderRadius: BorderRadius.circular(8.0)),
                            child: const Center(
                              child: Text(
                                "다른 사용자 코드 등록할래요",
                                style:
                                    TextStyle(color: PRIMARY_COLOR_ORANGE_02),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        GestureDetector(
                          onTap: () => secondShareCodeModal(),
                          child: Container(
                            height: 48.0,
                            decoration: BoxDecoration(
                                color: PRIMARY_COLOR_ORANGE_02,
                                border:
                                    Border.all(color: PRIMARY_COLOR_ORANGE_02),
                                borderRadius: BorderRadius.circular(8.0)),
                            child: const Center(
                              child: Text(
                                "다음",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> secondShareCodeModal() async {
    String code = (await ref
            .watch(friendRepositoryProvider)
            .generateCode(GenerateCodeDto(myDisplayName: myDisplayName)))
        .code;
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 418.0,
          padding: const EdgeInsets.symmetric(horizontal: 20.0)
              .copyWith(top: 20.0, bottom: 24.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: SvgPicture.asset(
                          "assets/img/timetable_screen/close.svg"),
                    ),
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 4.0,
                  ),
                  const Text(
                    "내 코드 공유하기",
                    style: TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Text(
                    "코드를 친구에게 공유해 주세요.",
                    style: TextStyle(color: GRAYSCALE_GRAY_04),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Container(
                      height: 48.0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: GRAYSCALE_GRAY_02),
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Row(
                        children: [
                          Text(code),
                          const Spacer(),
                          GestureDetector(
                            onTap: () async {
                              await Clipboard.setData(
                                  ClipboardData(text: code)); // TODO: 코드로 바꾸기
                              Fluttertoast.showToast(
                                  backgroundColor: GRAYSCALE_GRAY_04,
                                  msg: "코드가 복사되었습니다.",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              // copied successfully
                            },
                            child: const Text(
                              "복사",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: PRIMARY_COLOR_ORANGE_01),
                            ),
                          )
                        ],
                      )),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "해당 코드는 1시간 동안 유효합니다.",
                      style: TextStyle(color: GRAYSCALE_GRAY_04),
                    ),
                  ),
                  const SizedBox(
                    height: 127.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      firstRegisterCodeModal();
                    },
                    child: Container(
                      height: 48.0,
                      decoration: BoxDecoration(
                          border: Border.all(color: PRIMARY_COLOR_ORANGE_02),
                          borderRadius: BorderRadius.circular(8.0)),
                      child: const Center(
                        child: Text(
                          "다른 사용자 코드 등록할래요",
                          style: TextStyle(color: PRIMARY_COLOR_ORANGE_02),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 48.0,
                      decoration: BoxDecoration(
                          color: PRIMARY_COLOR_ORANGE_02,
                          border: Border.all(color: PRIMARY_COLOR_ORANGE_02),
                          borderRadius: BorderRadius.circular(8.0)),
                      child: const Center(
                        child: Text(
                          "완료하기",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(pinnedTimetableIdProvider);
    // getClasses();
    ref.listen(pinnedTimetableIdProvider, (prev, next) {
      if (prev != next) {
        getClasses();
      }
      /* do something, for example, call the method doSomething */
    });

    ref.listen(pinnedTimetableProvider, (prev, next) {
      if (prev != next) {
        getClasses();
      }
    });

    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: BACKGROUND_COLOR_GRAY,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          surfaceTintColor: Colors.transparent,
          toolbarHeight: 56.0,
          backgroundColor: BACKGROUND_COLOR_GRAY,
          elevation: 0,
          leading: Ink(
            width: 44.0,
            height: 48.0,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => TimeTableListScreen(
                      deleteTimetable: deleteTimetable,
                      setTimetableName: setTimetableName,
                    ),
                  ),
                );
              },
              child: Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/img/common/ic_list.svg',
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ),
          title: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    timetable == null
                        ? ""
                        : TimetableListModel.convertKeyToSemester(
                            timetable!.semester),
                    style: const TextStyle(
                      color: GRAYSCALE_GRAY_04,
                      fontSize: 12,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    timetable == null ? "" : timetable!.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      letterSpacing: -0.02,
                      height: 1.5,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
          actions: <Widget>[
            if (timetable != null)
              IconButton(
                icon: Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/img/common/ic_add.svg',
                    width: 24,
                    height: 24,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddTimeTableScreen(
                          addClass: addClass, addedClasses: addedCourses),
                    ),
                  );
                },
              ),
            IconButton(
                icon: Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/img/timetable_screen/add_friend.svg',
                    width: 24,
                    height: 24,
                  ),
                ),
                onPressed: () => shareOrRegisterModal()

                // showDialog(
                //   context: context,
                //   builder: (BuildContext context) {
                //     return const AddFriendDialog();
                //   },
                // );

                ),
            if (timetable != null)
              IconButton(
                icon: Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/img/common/ic_setting.svg',
                    width: 24,
                    height: 24,
                  ),
                ),
                onPressed: () => showTimetableSettingModal(
                    screenHeight: MediaQuery.of(context).size.height,
                    screenWidth: MediaQuery.of(context).size.width),
              ),
          ],
        ),
        body: Center(
            child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CustomScrollView(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    slivers: [
                      CupertinoSliverRefreshControl(
                        onRefresh: () async {
                          await Future.delayed(
                              const Duration(milliseconds: 1000), () {
                            print('refreshing');
                            getFriends();
                            getClasses();
                            // ref
                            //     .watch(univRecentPostProvider.notifier)
                            //     .paginate(normalRefetch: true);
                            // ref
                            //     .watch(totalRecentPostProvider.notifier)
                            //     .paginate(normalRefetch: true);
                            // ref
                            //     .watch(bestPostProvider.notifier)
                            //     .paginate(normalRefetch: true);
                          });
                          // await widget.notifierProvider!.paginate(forceRefetch: true);
                        },
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate([
                          SizedBox(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (flag == 0) // flag 값이 0인 경우
                                  const SizedBox(height: 200),
                                if (flag == 0)
                                  const Text(
                                    '아직 시간표를 만들지 않았어요.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      letterSpacing: -0.02,
                                      height: 1.5,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                if (flag == 0) const SizedBox(height: 8),
                                if (flag == 0)
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => TimeTableListScreen(
                                            deleteTimetable: deleteTimetable,
                                            setTimetableName: setTimetableName,
                                            isAddTimetable: true,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "새 시간표 추가하기",
                                          style: TextStyle(
                                            fontFamily: "Pretendard",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: PRIMARY_COLOR_ORANGE_01,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        SvgPicture.asset(
                                          'assets/img/home_screen/ic_navigation_right_orange.svg',
                                          width: 16,
                                          height: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                if (flag == 0) const SizedBox(height: 200),
                                if (flag == 1) // flag 값이 1인 경우
                                  TimeTableGrid(
                                    addedClasses: addedCourses,
                                  ),
                                // TimeTableScreenshotGrid(
                                //     addedClasses: addedCourses),
                                const SizedBox(
                                  height: 24.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isFriendListExpanded =
                                            !_isFriendListExpanded;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 12.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: GRAYSCALE_GRAY_02),
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                "친구 목록",
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const Spacer(),
                                              SvgPicture.asset(_isFriendListExpanded
                                                  ? "assets/img/module_review_screen/up_tick_icon.svg"
                                                  : "assets/img/module_review_screen/down_tick_icon.svg")
                                            ],
                                          ),
                                          ExpandedSection(
                                              expand: _isFriendListExpanded,
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                      height: 16.0,
                                                    ),
                                                    if (friendList.isEmpty)
                                                      const Text(
                                                        "아직 추가된 친구가 없네요!\n친구를 추가하면 시간표를 공유할 수 있어요.",
                                                        style: TextStyle(
                                                            color:
                                                                GRAYSCALE_GRAY_04,
                                                            letterSpacing:
                                                                -0.14),
                                                      ),
                                                    ...List.generate(
                                                      friendList.length,
                                                      (index) =>
                                                          GestureDetector(
                                                        onTap: () => Navigator
                                                                .of(context)
                                                            .push(
                                                                MaterialPageRoute(
                                                                    builder: (_) =>
                                                                        FriendTimetableScreen(
                                                                          refreshFriendList:
                                                                              getFriends,
                                                                          friendId:
                                                                              friendList[index].friendId,
                                                                          friendName:
                                                                              friendList[index].friendName,
                                                                        ))),
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical:
                                                                      14.5),
                                                          child: Text(
                                                            friendList[index]
                                                                .friendName,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    letterSpacing:
                                                                        -0.32),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 17.0,
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: GestureDetector(
                                                        onTap:
                                                            shareOrRegisterModal,
                                                        child: const Text(
                                                          "친구 추가하기",
                                                          style: TextStyle(
                                                              fontSize: 12.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  PRIMARY_COLOR_ORANGE_01),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: GestureDetector(
                                    onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const ModuleReviewMainScreen()),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 12.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: GRAYSCALE_GRAY_02),
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                "강의평가 홈 바로가기",
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const Spacer(),
                                              SvgPicture.asset(
                                                'assets/img/timetable_screen/link.svg',
                                                width: 24,
                                                height: 24,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 84),
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ]))));
  }

  void showDeleteCourseDialog(CourseDetailModel currentCourse) {
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
                    "선택한 강의를 삭제하시겠습니까?",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.32),
                  ),
                  const SizedBox(
                    height: 41.0,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          deleteClass(currentCourse);
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

  void showChangeTimetableNameDialog() {
    setState(() {
      newTimetableName = timetable!.name;
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
                        "시간표 이름 변경하기",
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
                            initialValue: timetable!.name,
                            maxLength: 10,
                            onChanged: (name) {
                              setState(() {
                                newTimetableName = name;
                              });
                            },
                            decoration: InputDecoration(
                              counterText: "",
                              border: InputBorder.none,
                              suffix: Text("${newTimetableName.length}/10"),
                              hintText: "새 시간표 이름을 작성하세요.",
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
                              changeTimetableName(newTimetableName);
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
}
