import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/user/repository/auth_repository.dart';
import 'package:mingle/user/view/signup_screen/model/country_model.dart';
import 'package:mingle/user/view/signup_screen/model/university_domain_model.dart';
import 'package:mingle/user/view/signup_screen/provider/country_selected_provider.dart';
import 'package:mingle/user/view/signup_screen/provider/email_extension_selected_provider.dart';
import 'package:mingle/user/view/signup_screen/provider/selected_univ_id_provider.dart';
import 'package:mingle/user/view/signup_screen/provider/selected_university_domain_provider.dart';

class UniversityDomainDropdownList extends ConsumerStatefulWidget {
  final double width;
  const UniversityDomainDropdownList({
    super.key,
    this.width = 170,
  });

  @override
  ConsumerState<UniversityDomainDropdownList> createState() =>
      _DropdownListState();
}

class _DropdownListState extends ConsumerState<UniversityDomainDropdownList> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(selectedUnivDomainProvider);

    return items.length == 1
        ? Container(
            height: 44,
            width: widget.width,
            padding: const EdgeInsets.only(left: 12.09),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: GRAYSCALE_GRAY_03,
                ),
                color: Colors.white),
            child:
                Align(alignment: Alignment.centerLeft, child: Text(items[0])),
          )
        : DropdownButtonHideUnderline(
            child: DropdownButton2(
              // isExpanded: true,
              items: items
                  .map<DropdownMenuItem<String>>(
                      (String domain) => DropdownMenuItem<String>(
                            value: domain,
                            child: Text(
                              domain,
                              style: const TextStyle(
                                  fontSize: 14.0,
                                  letterSpacing: -0.01,
                                  height: 1.4,
                                  fontWeight: FontWeight.w400),
                            ),
                          ))
                  .toList(),
              value: selectedValue,
              dropdownStyleData: const DropdownStyleData(
                  decoration: BoxDecoration(color: Colors.white)),
              onChanged: (String? value) {
                if (value != null) {
                  ref
                      .read(selectedEmailExtensionProvider.notifier)
                      .update((state) => value);
                }
                setState(() {
                  selectedValue = value;
                });
              },
              hint: const Text(
                "선택",
                style: TextStyle(fontSize: 14.0),
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
