import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/timetable/components/search_course_modal.dart';
import 'package:mingle/timetable/components/timetable_list_more_modal.dart';

class TimetableListWidget extends StatefulWidget {
  const TimetableListWidget({super.key});

  @override
  State<TimetableListWidget> createState() => _TimetableListWidgetState();
}

class _TimetableListWidgetState extends State<TimetableListWidget> {
  void MoreButtonModal() {
    Future.delayed(const Duration(milliseconds: 40)).then((_) {
      showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        isScrollControlled: false,
        context: context,
        builder: (BuildContext context) {
          return const TimetableMoreModalwidget();
        },
      );
    });
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
                const Text(
                  '시간표 1',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
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
}
