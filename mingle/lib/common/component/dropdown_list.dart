import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';

class DropdownList extends ConsumerStatefulWidget {
  final List<String> itemList;
  final String hintText;
  final StateProvider<String>? isSelectedProvider;
  final double width;
  const DropdownList(
      {super.key,
      required this.itemList,
      required this.hintText,
      this.width = 170,
      this.isSelectedProvider});

  @override
  ConsumerState<DropdownList> createState() => _DropdownListState();
}

class _DropdownListState extends ConsumerState<DropdownList> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        // isExpanded: true,
        items: widget.itemList
            .map((String country) => DropdownMenuItem<String>(
                  value: country,
                  child: Text(
                    country,
                    style: const TextStyle(
                        fontSize: 14.0, fontWeight: FontWeight.w400),
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (String? value) {
          if (value != null) {
            if (widget.isSelectedProvider != null) {
              ref
                  .read(widget.isSelectedProvider!.notifier)
                  .update((state) => value);
            }
          }
          setState(() {
            selectedValue = value;
          });
        },
        hint: Text(
          widget.hintText,
          style: const TextStyle(fontSize: 14.0),
        ),
        buttonStyleData: ButtonStyleData(
          height: 44,
          width: widget.width,
          padding: const EdgeInsets.only(left: 12.09),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: GRAYSCALE_GRAY_03,
              ),
              color: Colors.white),
          // elevation: 2,
        ),
        iconStyleData: IconStyleData(
          icon: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: SvgPicture.asset(
                "assets/img/signup_screen/dropdown_button_icon.svg"),
          ),
          openMenuIcon: null,
          iconSize: 14,
          iconEnabledColor: Colors.yellow,
          iconDisabledColor: Colors.grey,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 32,
          padding: EdgeInsets.only(left: 12.09, top: 7, bottom: 8),
        ),
      ),
    );
  }
}
