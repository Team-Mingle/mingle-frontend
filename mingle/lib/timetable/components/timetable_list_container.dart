import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/module/components/toast_message_card.dart';
import 'package:mingle/timetable/model/timetable_preview_model.dart';
import 'package:mingle/timetable/provider/pinned_timetable_id_provider.dart';
import 'package:mingle/timetable/repository/timetable_repository.dart';

class TimetableListWidget extends ConsumerStatefulWidget {
  final Function pinTimetable;
  final Function deleteTimetable;
  final Function changeTimetableName;
  final List<TimetablePreviewModel> timetables;
  final TimetablePreviewModel timetablePreviewModel;
  const TimetableListWidget(
      {super.key,
      required this.timetablePreviewModel,
      required this.timetables,
      required this.pinTimetable,
      required this.deleteTimetable,
      required this.changeTimetableName});

  @override
  ConsumerState<TimetableListWidget> createState() =>
      _TimetableListWidgetState();
}

class _TimetableListWidgetState extends ConsumerState<TimetableListWidget> {
  late FToast fToast;
  String newTimetableName = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  void MoreButtonModal() {
    Future.delayed(const Duration(milliseconds: 40)).then((_) {
      showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: Colors.white,
        isScrollControlled: false,
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: widget.timetablePreviewModel.isPinned ? 176 : 232,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 32.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    showChangeTimetableNameDialog();
                  },
                  child: const SizedBox(
                    height: 56.0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 14.0, horizontal: 20.0),
                      child: Text(
                        '시간표 이름 변경하기',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          letterSpacing: -0.02,
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    showDeleteTimetableDialog();
                  },
                  child: const SizedBox(
                    height: 56.0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 14.0, horizontal: 20.0),
                      child: Text(
                        '시간표 삭제하기',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          letterSpacing: -0.02,
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                if (!widget.timetablePreviewModel.isPinned)
                  GestureDetector(
                    onTap: pin,
                    child: const SizedBox(
                      height: 56.0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: 20.0),
                        child: Text(
                          '기본 시간표로 고정하기',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            letterSpacing: -0.02,
                            height: 1.5,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 32.0,
                ),
              ],
            ),
          );
        },
      );
    });
  }

  void pin() async {
    Navigator.pop(context);
    try {
      await ref
          .read(timetableRepositoryProvider)
          .pinTimetable(timetableId: widget.timetablePreviewModel.timetableId);
      ref.read(pinnedTimetableIdProvider.notifier).fetchPinnedTimetableId();
    } on DioException catch (e) {
      fToast.showToast(
        child: const ToastMessage(message: generalErrorMsg),
        gravity: ToastGravity.CENTER,
        toastDuration: const Duration(seconds: 2),
      );
    }
    widget.pinTimetable(widget.timetablePreviewModel);
    // timetables.firstWhere((timetable) => timetable.isPinned).isPinned = false;
    // timetablePreviewModel.isPinned = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: [
                Text(
                  widget.timetablePreviewModel.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    letterSpacing: -0.02,
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                if (widget.timetablePreviewModel.isPinned)
                  SvgPicture.asset(
                    'assets/img/timetable_screen/toggle_selected.svg',
                    width: 24,
                    height: 24,
                  ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    MoreButtonModal();
                  },
                  child: SvgPicture.asset(
                    'assets/img/timetable_screen/more.svg',
                    width: 24,
                    height: 24,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 0),
              height: 1.0,
              color: GRAYSCALE_GRAY_01,
            ),
          ),
        ],
      ),
    );
  }

  void showDeleteTimetableDialog() {
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
                    "시간표를 삭제하시겠습니까?",
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
                          widget.deleteTimetable(
                              widget.timetablePreviewModel.timetableId);
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
      newTimetableName = widget.timetablePreviewModel.name;
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
                            initialValue: widget.timetablePreviewModel.name,
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
                              widget.changeTimetableName(newTimetableName);
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
