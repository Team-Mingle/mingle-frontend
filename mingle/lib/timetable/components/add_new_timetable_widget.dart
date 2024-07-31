import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mingle/common/component/anonymous_textfield.dart';
import 'package:mingle/common/component/character_count_textfield.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/main.dart';
import 'package:mingle/module/components/toast_message_card.dart';
import 'package:mingle/timetable/provider/pinned_timetable_id_provider.dart';
import 'package:mingle/timetable/repository/timetable_repository.dart';

class AddNewTimetableWidget extends ConsumerStatefulWidget {
  final Function addTimetable;
  final Function refreshTimetableList;
  const AddNewTimetableWidget(
      {super.key,
      required this.refreshTimetableList,
      required this.addTimetable});

  @override
  ConsumerState<AddNewTimetableWidget> createState() =>
      _AddNewTimetableWidgetState();
}

class _AddNewTimetableWidgetState extends ConsumerState<AddNewTimetableWidget> {
  final List<String> semesters = [
    '2024년 2학기',
    '2024년 1학기',
    // '2022년 2학기',
    // '2022년 1학기',
    // '2020년 2학기',
    // '2020년 1학기',
  ];

  String? selectedSemester = "2024년 2학기";
  // String timetableName = "";
  late FToast fToast;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast.init(navigatorKey.currentContext!);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Dialog(
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.zero,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 32.0, left: 20.0, right: 20.0, bottom: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '새 시간표 추가하기',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  letterSpacing: -0.02,
                  height: 1.5,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Container(
                width: 295.0,
                decoration: BoxDecoration(
                  border: Border.all(color: GRAYSCALE_GRAY_03),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        borderRadius: BorderRadius.circular(8.0),
                        dropdownColor: Colors.white,
                        isExpanded: true,
                        underline: const SizedBox.shrink(),
                        hint: const Text('학기'),
                        value: selectedSemester ?? semesters[0],
                        items: semesters.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (semester) {
                          setState(() {
                            selectedSemester = semester;
                          });
                        },
                        icon: Align(
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            'assets/img/common/ic_dropdown.svg',
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(
              //   height: 8.0,
              // ),
              // Container(
              //   height: 48.0,
              //   width: 295.0,
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: 12.0,
              //   ),
              //   decoration: BoxDecoration(
              //       border: Border.all(color: GRAYSCALE_GRAY_02),
              //       borderRadius: BorderRadius.circular(8.0)),
              //   child: Center(
              //     child: TextFormField(
              //       maxLength: 10,
              //       onChanged: (name) {
              //         setState(() {
              //           timetableName = name;
              //         });
              //       },
              //       decoration: InputDecoration(
              //         counterText: "",
              //         border: InputBorder.none,
              //         suffix: Text("${timetableName.length}/10"),
              //         hintText: "새 시간표 이름을 작성하세요.",
              //         hintStyle: const TextStyle(
              //             color: GRAYSCALE_GRAY_03, fontSize: 16.0),
              //       ),
              //     ),
              //   ),
              // ),
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
                    onTap: () async {
                      fToast.showToast(
                          child: const ToastMessage(message: "시간표가 추가되었습니다."),
                          toastDuration: const Duration(seconds: 2),
                          gravity: ToastGravity.CENTER);
                      await widget.addTimetable(selectedSemester!);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();

                      // changeTimetabelName();
                    },
                    child: Container(
                      height: 40.0,
                      width: 120.0,
                      decoration: BoxDecoration(
                          color: PRIMARY_COLOR_ORANGE_02,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: const Center(
                        child: Text(
                          "추가하기",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
