import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/component/anonymous_textfield.dart';
import 'package:mingle/common/component/character_count_textfield.dart';
import 'package:mingle/common/const/colors.dart';

class ModifyTimetableNameWidget extends StatefulWidget {
  const ModifyTimetableNameWidget({super.key});

  @override
  State<ModifyTimetableNameWidget> createState() =>
      _ModifyTimetableNameWidgetState();
}

class _ModifyTimetableNameWidgetState extends State<ModifyTimetableNameWidget> {
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
              '시간표 이름 변경하기',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: GRAYSCALE_GRAY_03),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: CharacterCountTextField(
                          maxCharacterCount: 10, hint: '시간표 1'),
                    ),
                  ],
                ),
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
                      child: const Text('취소하기'),
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
                      child: const Text('변경하기'),
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
