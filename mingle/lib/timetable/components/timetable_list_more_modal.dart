import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mingle/module/components/toast_message_card.dart';
import 'package:mingle/timetable/components/delete_timetable_widget.dart';
import 'package:mingle/timetable/components/modify_timetable_name_widget.dart';
import 'package:mingle/timetable/model/timetable_preview_model.dart';
import 'package:mingle/timetable/provider/pinned_timetable_provider.dart';
import 'package:mingle/timetable/repository/timetable_repository.dart';

class TimetableMoreModalwidget extends ConsumerStatefulWidget {
  final Function pinTimetable;
  final List<TimetablePreviewModel> timetables;
  final TimetablePreviewModel timetablePreviewModel;
  const TimetableMoreModalwidget(
      {super.key,
      required this.timetablePreviewModel,
      required this.timetables,
      required this.pinTimetable});

  @override
  ConsumerState<TimetableMoreModalwidget> createState() =>
      _TimetableMoreModalwidgetState();
}

class _TimetableMoreModalwidgetState
    extends ConsumerState<TimetableMoreModalwidget> {
  late FToast fToast;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    void pin() async {
      Navigator.pop(context);
      try {
        await ref.read(timetableRepositoryProvider).pinTimetable(
            timetableId: widget.timetablePreviewModel.timetableId);
        await ref
            .watch(pinnedTimetableIdProvider.notifier)
            .fetchPinnedTimetable();
      } on DioException catch (e) {
        fToast.showToast(
          child: const ToastMessage(message: "다시 시도해주세요"),
          gravity: ToastGravity.CENTER,
          toastDuration: const Duration(seconds: 2),
        );
      }
      widget.pinTimetable(widget.timetablePreviewModel);
      // timetables.firstWhere((timetable) => timetable.isPinned).isPinned = false;
      // timetablePreviewModel.isPinned = true;
    }

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
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const ModifyTimetableNameWidget();
                },
              );
            },
            child: const SizedBox(
              height: 56.0,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
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
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const DeleteTimetableWidget();
                },
              );
            },
            child: const SizedBox(
              height: 56.0,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
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
                  padding:
                      EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
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
  }
}
