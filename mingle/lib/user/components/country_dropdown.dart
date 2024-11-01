import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/user/repository/auth_repository.dart';
import 'package:mingle/user/view/signup_screen/model/country_model.dart';
import 'package:mingle/user/view/signup_screen/provider/country_selected_provider.dart';

class CountryDropdownList extends ConsumerStatefulWidget {
  final double width;
  const CountryDropdownList({
    super.key,
    this.width = 170,
  });

  @override
  ConsumerState<CountryDropdownList> createState() => _DropdownListState();
}

class _DropdownListState extends ConsumerState<CountryDropdownList> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ref.watch(authRepositoryProvider).getCountries(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
                height: 44,
                width: widget.width,
                padding: const EdgeInsets.only(left: 12.09),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: GRAYSCALE_GRAY_03,
                    ),
                    color: Colors.white),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("국가 선택"),
                ));
          }

          final items = snapshot.data as List<CountryModel>;
          return DropdownButtonHideUnderline(
            child: DropdownButton2(
              // isExpanded: true,
              items: items
                  .map<DropdownMenuItem<String>>(
                      (CountryModel country) => DropdownMenuItem<String>(
                            value: country.name,
                            child: Text(
                              country.name,
                              style: const TextStyle(
                                  fontSize: 14.0,
                                  letterSpacing: -0.01,
                                  height: 1.4,
                                  fontWeight: FontWeight.w400),
                            ),
                          ))
                  .toList(),
              value: selectedValue,
              onChanged: (String? value) {
                if (value != null) {
                  ref
                      .read(selectedCountryProvider.notifier)
                      .update((state) => value);
                }
                setState(() {
                  selectedValue = value;
                });
              },
              hint: const Text(
                "국가 선택",
                style: TextStyle(fontSize: 14.0),
              ),
              dropdownStyleData: const DropdownStyleData(
                  decoration: BoxDecoration(color: Colors.white)),
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
        });
  }
}
