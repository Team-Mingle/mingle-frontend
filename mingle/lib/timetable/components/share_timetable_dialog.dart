import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mingle/common/const/colors.dart';

class ShareTimetableDialog extends StatelessWidget {
  const ShareTimetableDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0, right: 12.0),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child:
                      SvgPicture.asset("assets/img/timetable_screen/close.svg"),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 32.0, right: 32.0, left: 32.0, bottom: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "시간표를 공유하고 친구 되기",
                      style: TextStyle(
                          fontSize: 16.0,
                          letterSpacing: -0.02,
                          height: 1.5,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const Text(
                      "링크를 공유하여 친구가 되면\n   시간표를 볼 수 있습니다.",
                      style: TextStyle(color: GRAYSCALE_GRAY_04),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: GRAYSCALE_GRAY_02),
                          borderRadius: BorderRadius.circular(8.0)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 16.0),
                      child: const Row(children: [
                        Text("공유 링크"),
                        Spacer(),
                        Text(
                          "복사",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: PRIMARY_COLOR_ORANGE_01),
                        )
                      ]),
                    )
                  ],
                ),
              ),
            )
          ]),
        ],
      ),
    );
  }
}
