import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/timetable/components/timetable_list_container.dart';
import 'package:mingle/timetable/model/timetable_list_model.dart';
import 'package:mingle/timetable/model/timetable_preview_model.dart';
import 'package:mingle/timetable/repository/timetable_repository.dart';

class TimetableList extends StatefulWidget {
  final String semester;
  final List<TimetablePreviewModel> timetables;
  const TimetableList(
      {super.key, required this.semester, required this.timetables});

  @override
  State<TimetableList> createState() => _TimetableListState();
}

class _TimetableListState extends State<TimetableList> {
  void pinTimetable(TimetablePreviewModel timetableToBePinned) {
    setState(() {
      widget.timetables.firstWhere((timetable) => timetable.isPinned).isPinned =
          false;
      widget.timetables
          .firstWhere((timetable) =>
              timetable.timetableId == timetableToBePinned.timetableId)
          .isPinned = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            Row(
              children: [
                Text(
                  widget.semester,
                  style: const TextStyle(
                    color: GRAYSCALE_GRAY_03,
                    fontSize: 16.0,
                    letterSpacing: -0.02,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // TimetableListWidget(),
            // TimetableListWidget(),
            // TimetableListWidget(),
            ...List.generate(
                widget.timetables.length,
                (index) => TimetableListWidget(
                    pinTimetable: pinTimetable,
                    timetables: widget.timetables,
                    timetablePreviewModel: widget.timetables[index]))
          ],
        ),
      ),
    );
  }
}
