import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/component/dropdown_list.dart';
import 'package:mingle/common/component/next_button.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/user/repository/auth_repository.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';
import 'package:mingle/user/view/signup_screen/model/country_model.dart';
import 'package:mingle/user/view/signup_screen/provider/country_selected_provider.dart';
import 'package:mingle/user/view/signup_screen/select_school_screen.dart';

class SelectCountryScreen extends ConsumerStatefulWidget {
  final bool isPasswordReset;
  const SelectCountryScreen({
    super.key,
    this.isPasswordReset = false,
  });

  @override
  ConsumerState<SelectCountryScreen> createState() =>
      _SelectCountryScreenState();
}

class _SelectCountryScreenState extends ConsumerState<SelectCountryScreen> {
  late List<CountryModel> countryList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void setCountryList() async {
    setState(() {
      // countryList = ref.watch(authRepositoryProvider).getCountries();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 17.0),
            child: IconButton(
              icon: const ImageIcon(
                AssetImage("assets/img/signup_screen/cross_icon.png"),
                color: GRAYSCALE_BLACK,
              ),
              onPressed: () {
                ref
                    .read(selectedCountryProvider.notifier)
                    .update((state) => "");
                Navigator.pop(context);
              },
            ),
          ),
          title: SvgPicture.asset(
            "assets/img/signup_screen/first_indicator.svg",
          )),
      body: DefaultPadding(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "재학 중인 학교가",
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w400),
                    ),
                    const Text(
                      "어디에 위치해 있나요?",
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Text(
                        widget.isPasswordReset
                            ? "비밀번호 재설정을 위해 본인인증이 필요해요."
                            : "원활한 앱 이용을 위해 재학 정보가 필요해요",
                        style: const TextStyle(
                            color: GRAYSCALE_GRAY_03,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SvgPicture.asset("assets/img/signup_screen/globe_icon.svg"),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: 170,
              child: DropdownList(
                itemList: COUNTRY_LIST,
                hintText: "국가 선택",
                isSelectedProvider: selectedCountryProvider,
              ),
            ),
            Expanded(child: Container()),
            NextButton(
              nextScreen: SelectSchoolScreen(
                isPasswordReset: widget.isPasswordReset,
              ),
              buttonName: "다음으로",
              isSelectedProvider: [selectedCountryProvider],
            ),
            const SizedBox(
              height: 40.0,
            )
          ]),
        ),
      ),
    );
  }
}
