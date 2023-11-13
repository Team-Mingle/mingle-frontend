import 'package:flutter/material.dart';
import 'package:mingle/timetable/components/delete_timetable_widget.dart';
import 'package:mingle/timetable/components/modify_timetable_name_widget.dart';

class TimetableMoreModalwidget extends StatelessWidget {
  const TimetableMoreModalwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 176,
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
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
              child: Text(
                '시간표 이름 변경하기',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
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
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
              child: Text(
                '시간표 삭제하기',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
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
