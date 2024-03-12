import 'package:flutter/material.dart';
import 'package:mingle/common/const/colors.dart';

class DeleteTimetableWidget extends StatefulWidget {
  const DeleteTimetableWidget({super.key});

  @override
  State<DeleteTimetableWidget> createState() => _DeleteTimetableWidgetState();
}

class _DeleteTimetableWidgetState extends State<DeleteTimetableWidget> {
  String? selectedItem1;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.only(
            top: 32.0, left: 20.0, right: 20.0, bottom: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '시간표를 삭제하시겠습니까?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                letterSpacing: -0.02,
                height: 1.5,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            const Text(
              '이 작업은 되돌릴 수 없습니다.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: GRAYSCALE_GRAY_04,
                fontSize: 14.0,
                letterSpacing: -0.01,
                height: 1.4,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 27.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all(const Size(0, 40)),
                        backgroundColor:
                            MaterialStateProperty.all(GRAYSCALE_GRAY_01_5),
                        foregroundColor:
                            MaterialStateProperty.all(GRAYSCALE_GRAY_04),
                        elevation: MaterialStateProperty.all(0),
                      ),
                      child: const Text('유지하기'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all(const Size(0, 40)),
                        backgroundColor:
                            MaterialStateProperty.all(PRIMARY_COLOR_ORANGE_02),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        elevation: MaterialStateProperty.all(0),
                      ),
                      child: const Text('삭제하기'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
