import 'package:flutter/material.dart';
import 'package:mingle/timetable/components/delete_timetable_widget.dart';
import 'package:mingle/timetable/components/modify_timetable_name_widget.dart';
import 'package:mingle/timetable/model/timetable_preview_model.dart';

class TimetableMoreModalwidget extends StatelessWidget {
  TimetablePreviewModel timetablePreviewModel;
  TimetableMoreModalwidget({super.key, required this.timetablePreviewModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: timetablePreviewModel.isPinned ? 176 : 232,
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
          if (!timetablePreviewModel.isPinned)
            GestureDetector(
              onTap: () {},
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
