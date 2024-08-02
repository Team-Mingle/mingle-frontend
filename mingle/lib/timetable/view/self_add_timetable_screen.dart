import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/common/const/error_codes.dart';
import 'package:mingle/common/const/utils.dart';
import 'package:mingle/common/model/course_time_model.dart';
import 'package:mingle/main.dart';
import 'package:mingle/module/components/toast_message_card.dart';
import 'package:mingle/module/model/course_detail_model.dart';
import 'package:mingle/module/model/course_model.dart';
import 'package:mingle/timetable/components/add_course_time_dropdowns.dart';
import 'package:mingle/timetable/model/class_model.dart';
import 'package:mingle/timetable/provider/pinned_timetable_id_provider.dart';
import 'package:mingle/timetable/repository/timetable_repository.dart';

class AddDirectTimeTableScreen extends ConsumerStatefulWidget {
  final Function addClass;
  final Function addClassesAtAddTimeTableScreen;
  const AddDirectTimeTableScreen({
    Key? key,
    required this.addClass,
    required this.addClassesAtAddTimeTableScreen,
  }) : super(key: key);

  @override
  ConsumerState<AddDirectTimeTableScreen> createState() =>
      _AddDirectTimeTableScreenState();
}

class _AddDirectTimeTableScreenState
    extends ConsumerState<AddDirectTimeTableScreen> {
  List<Widget> timeDropdownWidgets = [];
  String moduleName = "";
  List<String> days = [];
  List<String> startTimes = [];
  List<String> endTimes = [];
  String moduleCode = "";
  String location = "";
  String subclass = "";
  String profName = "";
  late FToast fToast;
  bool isLoading = false;

  @override
  void initState() {
    timeDropdownWidgets.add(
      AddTimeDropdownsWidget(
        index: 0,
        onDayChange: onDayChange,
        onStartTimeChange: onStartTimeChange,
        onEndTimeChange: onEndTimeChange,
        delete: deleteTimeAtIndex,
      ),
    );
    days.add("");
    startTimes.add("");
    endTimes.add("");
    fToast = FToast();
    fToast.init(navigatorKey.currentContext!);
    super.initState();
  }

  void deleteTimeAtIndex(int index) {
    setState(() {
      timeDropdownWidgets.removeAt(index);
      days.removeAt(index);
      startTimes.removeAt(index);
      endTimes.removeAt(index);
    });
  }

  void addTimeDropdownWidget() {
    if (timeDropdownWidgets.length < 5) {
      // 최대 5번까지 추가
      setState(() {
        timeDropdownWidgets.add(AddTimeDropdownsWidget(
          index: timeDropdownWidgets.length,
          onDayChange: onDayChange,
          onStartTimeChange: onStartTimeChange,
          onEndTimeChange: onEndTimeChange,
          delete: deleteTimeAtIndex,
        ));
        days.add("");
        startTimes.add("");
        endTimes.add("");
      });
    }
  }

  void onDayChange(value, index) {
    setState(() {
      days[index] = value;
    });
  }

  void onStartTimeChange(value, index) {
    setState(() {
      startTimes[index] = value;
    });
  }

  void onEndTimeChange(value, index) {
    setState(() {
      endTimes[index] = value;
    });
    print(days);
    print(startTimes);
    print(endTimes);
  }

  Future<void> sendAddPersonalClassRequest(
      {bool overrideValidation = false}) async {
    setState(() {
      isLoading = true;
    });
    if (timeDropdownWidgets.isEmpty ||
        days[0].isEmpty ||
        startTimes[0].isEmpty ||
        endTimes[0].isEmpty) {
      fToast.showToast(
        child: const ToastMessage(message: "강의 시간을 입력해주세요"),
        gravity: ToastGravity.CENTER,
        toastDuration: const Duration(seconds: 2),
      );
      setState(() {
        isLoading = false;
      });
      return;
    }
    for (int i = 0; i < timeDropdownWidgets.length; i++) {
      if (startTimes[i].compareTo(endTimes[i]) >= 0) {
        fToast.showToast(
          child: const ToastMessage(message: "끝나는 시간이 시작 시간보다 빠를 수 없습니다"),
          gravity: ToastGravity.CENTER,
          toastDuration: const Duration(seconds: 2),
        );
        setState(() {
          isLoading = false;
        });
        return;
      }
    }
    try {
      CourseDetailModel result = await ref
          .watch(timetableRepositoryProvider)
          .addPersonalCourse(
              timetableId: ref.watch(pinnedTimetableIdProvider)!,
              addPersonalCourseDto: AddPersonalCourseDto(
                  overrideValidation: overrideValidation,
                  name: moduleName,
                  courseTimeDtoList: List.generate(
                      days.length,
                      (index) => CourseTimeModel(
                          dayOfWeek: convertKorDayToEngDay(days[index]),
                          startTime: startTimes[index],
                          endTime: endTimes[index])),
                  courseCode: moduleCode,
                  venue: location,
                  subclass: subclass,
                  professor: profName,
                  memo: ""));
      result.courseType = "PERSONAL";
      widget.addClass(result, overrideValidation);
      widget.addClassesAtAddTimeTableScreen(result, overrideValidation);
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    } on DioException catch (e) {
      setState(() {
        isLoading = false;
      });
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          automaticallyImplyLeading: false,
          titleSpacing: 0.0,
          leading: GestureDetector(
            child: Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/img/post_screen/cross_icon.svg',
                width: 24,
                height: 24,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            "강의 직접 추가하기",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              letterSpacing: -0.02,
              height: 1.5,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: [
            isLoading
                ? const Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: CircularProgressIndicator(
                      color: PRIMARY_COLOR_ORANGE_01,
                    ),
                  )
                : GestureDetector(
                    child: const Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: Text(
                        "완료하기",
                        style: TextStyle(
                          color: PRIMARY_COLOR_ORANGE_01,
                          fontSize: 14.0,
                          letterSpacing: -0.01,
                          height: 1.4,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    onTap: () async {
                      await sendAddPersonalClassRequest();
                    },
                  ),
          ],
          // title: Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     const SizedBox(width: 8.0),
          // InkWell(
          //   child: SizedBox(
          //     width: 40.0,
          //     height: 48.0,
          //     child: Align(
          //       alignment: Alignment.center,
          //       child: SvgPicture.asset(
          //         'assets/img/post_screen/cross_icon.svg',
          //         width: 24,
          //         height: 24,
          //       ),
          //     ),
          //   ),
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          // ),
          //     const Spacer(),
          // const Text(
          //   "강의 직접 추가하기",
          //   style: TextStyle(
          //     color: Colors.black,
          //     fontSize: 16.0,
          //     letterSpacing: -0.02,
          //     height: 1.5,
          //     fontWeight: FontWeight.w400,
          //   ),
          // ),
          //     const Spacer(),
          // InkWell(
          //   child: const Padding(
          //     padding: EdgeInsets.only(right: 20.0),
          //     child: Text(
          //       "완료하기",
          //       style: TextStyle(
          //         color: PRIMARY_COLOR_ORANGE_01,
          //         fontSize: 14.0,
          //         letterSpacing: -0.01,
          //         height: 1.4,
          //         fontWeight: FontWeight.w400,
          //       ),
          //     ),
          //   ),
          //   onTap: () {
          //     //TODO: fix
          //     // CourseModel classModel = CourseModel(id: id, name: name, courseCode: courseCode, professor: professor, courseTimeDtoList: courseTimeDtoList, rgb: rgb)
          //     // widget.addClass(classModel);
          //     // widget.addClassesAtAddTimeTableScreen(classModel);
          //     Navigator.pop(context);
          //   },
          // ),
          //   ],
          // ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text(
                        '강의명*',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          letterSpacing: -0.01,
                          height: 1.4,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          moduleName = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "강의명을 입력하세요",
                        hintStyle: const TextStyle(
                          color: GRAYSCALE_GRAY_03,
                          fontSize: 16.0,
                          letterSpacing: -0.02,
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 14.0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: GRAYSCALE_GRAY_02),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: GRAYSCALE_GRAY_02),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  const Row(
                    children: [
                      Text(
                        '강의 시간*',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          letterSpacing: -0.01,
                          height: 1.4,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  const Row(
                    children: [
                      Text(
                        '요일에 따라 강의 시간대가 다를 경우 시간대를 추가하세요.',
                        style: TextStyle(
                          color: GRAYSCALE_GRAY_03,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  if (timeDropdownWidgets.isNotEmpty)
                    ...List.generate(2 * timeDropdownWidgets.length - 1,
                        (index) {
                      if (index % 2 == 0) {
                        return AddTimeDropdownsWidget(
                          index: index ~/ 2,
                          onDayChange: onDayChange,
                          onStartTimeChange: onStartTimeChange,
                          onEndTimeChange: onEndTimeChange,
                          delete: deleteTimeAtIndex,
                        );

                        // timeDropdownWidgets[index ~/ 2];
                      } else {
                        return const SizedBox(
                          height: 20.0,
                        );
                      }
                    }),
                  // ...timeDropdownWidgets,
                  const SizedBox(
                    height: 12.0,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      addTimeDropdownWidget();
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 48),
                      side: const BorderSide(
                        width: 1,
                        color: PRIMARY_COLOR_ORANGE_02,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          '추가하기',
                          style: TextStyle(
                            color: PRIMARY_COLOR_ORANGE_02,
                            fontSize: 14.0,
                            letterSpacing: -0.01,
                            height: 1.4,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/img/common/ic_plus_orange.svg',
                          width: 24,
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  const Row(
                    children: [
                      Text(
                        '과목 코드',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          letterSpacing: -0.01,
                          height: 1.4,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          moduleCode = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "과목 코드를 입력하세요",
                        hintStyle: const TextStyle(
                          color: GRAYSCALE_GRAY_03,
                          fontSize: 16.0,
                          letterSpacing: -0.02,
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 14.0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: GRAYSCALE_GRAY_02),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: GRAYSCALE_GRAY_02),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  const Row(
                    children: [
                      Text(
                        '강의 장소',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          letterSpacing: -0.01,
                          height: 1.4,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          location = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "강의 장소를 입력하세요",
                        hintStyle: const TextStyle(
                          color: GRAYSCALE_GRAY_03,
                          fontSize: 16.0,
                          letterSpacing: -0.02,
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 14.0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: GRAYSCALE_GRAY_02),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: GRAYSCALE_GRAY_02),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  const Row(
                    children: [
                      Text(
                        '분반',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          letterSpacing: -0.01,
                          height: 1.4,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          subclass = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "분반을 입력하세요",
                        hintStyle: const TextStyle(
                          color: GRAYSCALE_GRAY_03,
                          fontSize: 16.0,
                          letterSpacing: -0.02,
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 14.0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: GRAYSCALE_GRAY_02),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: GRAYSCALE_GRAY_02),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  const Row(
                    children: [
                      Text(
                        '교수명',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          letterSpacing: -0.01,
                          height: 1.4,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          profName = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "교수명을 입력하세요",
                        hintStyle: const TextStyle(
                          color: GRAYSCALE_GRAY_03,
                          fontSize: 16.0,
                          letterSpacing: -0.02,
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 14.0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: GRAYSCALE_GRAY_02),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: GRAYSCALE_GRAY_02),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  )
                ],
              ),
            ),
          ),
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
                          sendAddPersonalClassRequest(overrideValidation: true);
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
