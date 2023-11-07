import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';

class AddTimeDropdownsWidget extends StatefulWidget {
  const AddTimeDropdownsWidget({Key? key}) : super(key: key);

  @override
  State<AddTimeDropdownsWidget> createState() => _AddTimeDropdownsWidgetState();
}

class _AddTimeDropdownsWidgetState extends State<AddTimeDropdownsWidget> {
  final List<String> items1 = [
    '월요일',
    '화요일',
    '수요일',
    '목요일',
    '금요일',
    '토요일',
    '일요일',
  ];

  final List<String> items2 = [
    '09:00',
    '09:10',
    '09:20',
    '09:30',
    '09:40',
    '09:50',
    '10:00',
    '10:10',
    '10:20',
    '10:30',
    '10:40',
    '10:50',
    '11:00',
    '11:10',
    '11:20',
    '11:30',
    '11:40',
    '11:50',
    '12:00',
    '12:10',
    '12:20',
    '12:30',
    '12:40',
    '12:50',
    '13:00',
    '13:10',
    '13:20',
    '13:30',
    '13:40',
    '13:50',
    '14:00',
    '14:10',
    '14:20',
    '14:30',
    '14:40',
    '14:50',
    '15:00',
    '15:10',
    '15:20',
    '15:30',
    '15:40',
    '15:50',
    '16:00',
    '16:10',
    '16:20',
    '16:30',
    '16:40',
    '16:50',
    '17:00',
    '17:10',
    '17:20',
    '17:30',
    '17:40',
    '17:50',
    '18:00'
  ];

  final List<String> items3 = [
    '09:00',
    '09:10',
    '09:20',
    '09:30',
    '09:40',
    '09:50',
    '10:00',
    '10:10',
    '10:20',
    '10:30',
    '10:40',
    '10:50',
    '11:00',
    '11:10',
    '11:20',
    '11:30',
    '11:40',
    '11:50',
    '12:00',
    '12:10',
    '12:20',
    '12:30',
    '12:40',
    '12:50',
    '13:00',
    '13:10',
    '13:20',
    '13:30',
    '13:40',
    '13:50',
    '14:00',
    '14:10',
    '14:20',
    '14:30',
    '14:40',
    '14:50',
    '15:00',
    '15:10',
    '15:20',
    '15:30',
    '15:40',
    '15:50',
    '16:00',
    '16:10',
    '16:20',
    '16:30',
    '16:40',
    '16:50',
    '17:00',
    '17:10',
    '17:20',
    '17:30',
    '17:40',
    '17:50',
    '18:00'
  ];

  String? selectedItem1, selectedItem2, selectedItem3;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 160,
              height: 48,
              decoration: BoxDecoration(
                border: Border.all(color: GRAYSCALE_GRAY_03),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: const SizedBox.shrink(),
                      hint: const Text('요일 선택'),
                      value: selectedItem1,
                      items: items1.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(
                              color: selectedItem1 == item
                                  ? Colors.black
                                  : GRAYSCALE_GRAY_03,
                              fontWeight: selectedItem1 == item
                                  ? FontWeight.w500
                                  : FontWeight.w400,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedItem1 = value;
                        });
                      },
                      icon: Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          'assets/img/common/ic_dropdown.svg',
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Container(
              width: 160,
              height: 48,
              decoration: BoxDecoration(
                border: Border.all(color: GRAYSCALE_GRAY_03),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: const SizedBox.shrink(),
                      hint: const Text('시작 시간'),
                      value: selectedItem2,
                      items: items2.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(
                              color: selectedItem2 == item
                                  ? Colors.black
                                  : GRAYSCALE_GRAY_03,
                              fontWeight: selectedItem2 == item
                                  ? FontWeight.w500
                                  : FontWeight.w400,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedItem2 = value;
                        });
                      },
                      icon: Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          'assets/img/common/ic_dropdown.svg',
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8.0),
            Container(
              width: 160,
              height: 48,
              decoration: BoxDecoration(
                border: Border.all(color: GRAYSCALE_GRAY_03),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: const SizedBox.shrink(),
                      hint: const Text('끝나는 시간'),
                      value: selectedItem3,
                      items: items3.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(
                              color: selectedItem3 == item
                                  ? Colors.black
                                  : GRAYSCALE_GRAY_03,
                              fontWeight: selectedItem3 == item
                                  ? FontWeight.w500
                                  : FontWeight.w400,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedItem3 = value;
                        });
                      },
                      icon: Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          'assets/img/common/ic_dropdown.svg',
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
