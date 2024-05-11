import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';

class AddTimeDropdownsWidget extends StatefulWidget {
  final Function onDayChange;
  final Function onStartTimeChange;
  final Function onEndTimeChange;
  final String? initialDay;
  final String? initialStartTime;
  final String? initialEndTime;
  final int index;
  final Function delete;
  const AddTimeDropdownsWidget(
      {Key? key,
      required this.onDayChange,
      required this.onStartTimeChange,
      required this.onEndTimeChange,
      required this.index,
      required this.delete,
      this.initialDay,
      this.initialStartTime,
      this.initialEndTime})
      : super(key: key);

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
    '00:00',
    '00:10',
    '00:20',
    '00:30',
    '00:40',
    '00:50',
    '01:00',
    '01:10',
    '01:20',
    '01:30',
    '01:40',
    '01:50',
    '02:00',
    '02:10',
    '02:20',
    '02:30',
    '02:40',
    '02:50',
    '03:00',
    '03:10',
    '03:20',
    '03:30',
    '03:40',
    '03:50',
    '04:00',
    '04:10',
    '04:20',
    '04:30',
    '04:40',
    '04:50',
    '05:00',
    '05:10',
    '05:20',
    '05:30',
    '05:40',
    '05:50',
    '06:00',
    '06:10',
    '06:20',
    '06:30',
    '06:40',
    '06:50',
    '07:00',
    '07:10',
    '07:20',
    '07:30',
    '07:40',
    '07:50',
    '08:00',
    '08:10',
    '08:20',
    '08:30',
    '08:40',
    '08:50',
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
    '18:00',
    '18:10',
    '18:20',
    '18:30',
    '18:40',
    '18:50',
    '19:00',
    '19:10',
    '19:20',
    '19:30',
    '19:40',
    '19:50',
    '20:00',
    '20:10',
    '20:20',
    '20:30',
    '20:40',
    '20:50',
    '21:00',
    '21:10',
    '21:20',
    '21:30',
    '21:40',
    '21:50',
    '22:00',
    '22:10',
    '22:20',
    '22:30',
    '22:40',
    '22:50',
    '23:00',
    '23:10',
    '23:20',
    '23:30',
    '23:40',
    '23:50',
  ];

  final List<String> items3 = [
    '00:00',
    '00:10',
    '00:20',
    '00:30',
    '00:40',
    '00:50',
    '01:00',
    '01:10',
    '01:20',
    '01:30',
    '01:40',
    '01:50',
    '02:00',
    '02:10',
    '02:20',
    '02:30',
    '02:40',
    '02:50',
    '03:00',
    '03:10',
    '03:20',
    '03:30',
    '03:40',
    '03:50',
    '04:00',
    '04:10',
    '04:20',
    '04:30',
    '04:40',
    '04:50',
    '05:00',
    '05:10',
    '05:20',
    '05:30',
    '05:40',
    '05:50',
    '06:00',
    '06:10',
    '06:20',
    '06:30',
    '06:40',
    '06:50',
    '07:00',
    '07:10',
    '07:20',
    '07:30',
    '07:40',
    '07:50',
    '08:00',
    '08:10',
    '08:20',
    '08:30',
    '08:40',
    '08:50',
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
    '18:00',
    '18:10',
    '18:20',
    '18:30',
    '18:40',
    '18:50',
    '19:00',
    '19:10',
    '19:20',
    '19:30',
    '19:40',
    '19:50',
    '20:00',
    '20:00',
    '20:10',
    '20:20',
    '20:30',
    '20:40',
    '20:50',
    '21:00',
    '21:10',
    '21:20',
    '21:30',
    '21:40',
    '21:50',
    '22:00',
    '22:10',
    '22:20',
    '22:30',
    '22:40',
    '22:50',
    '23:00',
    '23:10',
    '23:20',
    '23:30',
    '23:40',
    '23:50',
  ];

  String? selectedItem1, selectedItem2, selectedItem3;

  @override
  void initState() {
    // TODO: implement initState
    selectedItem1 = widget.initialDay;
    selectedItem2 = widget.initialStartTime;
    selectedItem3 = widget.initialEndTime;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                // width: 160,
                height: 48,
                decoration: BoxDecoration(
                  border: Border.all(color: GRAYSCALE_GRAY_03),
                  borderRadius: BorderRadius.circular(8),
                ),
                // padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        underline: const SizedBox.shrink(),
                        hint: const Text('요일 선택'),
                        alignment: Alignment.centerLeft,
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 250.0,
                          // width: 160.0,
                          padding: EdgeInsets.zero,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0)),
                        ),
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
                          widget.onDayChange(value, widget.index);
                          setState(() {
                            selectedItem1 = value;
                          });
                        },
                        iconStyleData: IconStyleData(
                          icon: Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              'assets/img/common/ic_dropdown.svg',
                              width: 24,
                              height: 24,
                            ),
                          ),
                          openMenuIcon: null,
                          iconSize: 14,
                        ),
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.only(right: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            // const Spacer(),
            widget.index > 0
                ? Expanded(
                    child: GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: SvgPicture.asset(
                            'assets/img/post_screen/cross_icon.svg',
                            width: 18,
                            height: 18,
                          ),
                        ),
                      ),
                      onTap: () => widget.delete(widget.index),
                    ),
                  )
                : const Spacer(),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                // width: 160,
                height: 48,
                decoration: BoxDecoration(
                  border: Border.all(color: GRAYSCALE_GRAY_03),
                  borderRadius: BorderRadius.circular(8),
                ),
                // padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        underline: const SizedBox.shrink(),
                        hint: const Text('시작 시간'),

                        dropdownStyleData: DropdownStyleData(
                          // offset: const Offset(0, 9 * 48.0),
                          maxHeight: 250.0,
                          // width: 160.0,
                          padding: EdgeInsets.zero,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0)),
                        ),
                        // borderRadius: BorderRadius.circular(8.0),
                        // dropdownColor: Colors.white,
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
                          widget.onStartTimeChange(value, widget.index);
                          setState(() {
                            selectedItem2 = value;
                          });
                        },

                        iconStyleData: IconStyleData(
                          icon: Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              'assets/img/common/ic_dropdown.svg',
                              width: 24,
                              height: 24,
                            ),
                          ),
                          openMenuIcon: null,
                          iconSize: 14,
                        ),
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.only(right: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Container(
                // width: 160,
                height: 48,
                decoration: BoxDecoration(
                  border: Border.all(color: GRAYSCALE_GRAY_03),
                  borderRadius: BorderRadius.circular(8),
                ),
                // padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        underline: const SizedBox.shrink(),
                        hint: const Text('끝나는 시간'),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 250.0,
                          // width: 160.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0)),
                        ),
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
                          widget.onEndTimeChange(value, widget.index);
                          setState(() {
                            selectedItem3 = value;
                          });
                        },
                        iconStyleData: IconStyleData(
                          icon: Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              'assets/img/common/ic_dropdown.svg',
                              width: 24,
                              height: 24,
                            ),
                          ),
                          openMenuIcon: null,
                          iconSize: 14,
                        ),
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.only(right: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
