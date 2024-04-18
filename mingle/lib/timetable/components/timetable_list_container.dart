import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/timetable/components/search_course_modal.dart';
import 'package:mingle/timetable/components/timetable_list_more_modal.dart';
import 'package:mingle/timetable/model/timetable_preview_model.dart';

class TimetableListWidget extends StatefulWidget {
  final Function pinTimetable;
  final List<TimetablePreviewModel> timetables;
  final TimetablePreviewModel timetablePreviewModel;
  const TimetableListWidget(
      {super.key,
      required this.timetablePreviewModel,
      required this.timetables,
      required this.pinTimetable});

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
        backgroundColor: Colors.white,
        isScrollControlled: false,
        context: context,
        builder: (BuildContext context) {
          return TimetableMoreModalwidget(
              pinTimetable: widget.pinTimetable,
              timetables: widget.timetables,
              timetablePreviewModel: widget.timetablePreviewModel);
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
}
