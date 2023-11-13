import 'package:flutter/material.dart';

class TimeTableGrid extends StatelessWidget {
  const TimeTableGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 351, // 그리드의 전체 너비
      height: 456, // 그리드의 전체 높이
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFCFCFCF),
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          childAspectRatio: 20 / 20,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.white,
          );
        },
        itemCount: 6 * 8,
      ),
    );
  }
}
