import 'package:flutter/cupertino.dart';
import 'package:mingle/common/const/colors.dart';

class ReportedComponent extends StatelessWidget {
  final String reportedTitle;
  final String reportedReason;
  const ReportedComponent(
      {super.key, required this.reportedTitle, required this.reportedReason});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(reportedTitle),
          Text(
            reportedReason,
            style: const TextStyle(color: PRIMARY_COLOR_ORANGE_01),
          )
        ],
      ),
    );
  }
}
