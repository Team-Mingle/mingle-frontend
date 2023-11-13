import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/timetable/components/timetable_list_container.dart';

class TimetableList extends StatelessWidget {
  const TimetableList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 32),
            Row(
              children: [
                Text(
                  '2023년 2학기',
                  style: TextStyle(
                    color: GRAYSCALE_GRAY_03,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            TimetableListWidget(),
            TimetableListWidget(),
            TimetableListWidget(),
          ],
        ),
      ),
    );
  }
}
