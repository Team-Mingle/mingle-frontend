import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/component/dropdown_list.dart';
import 'package:mingle/common/component/next_button.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';
import 'package:mingle/user/view/signup_screen/enter_email_screen.dart';
import 'package:mingle/user/view/signup_screen/enter_verifiction_number_screen.dart';
import 'package:mingle/user/view/signup_screen/provider/country_selected_provider.dart';
import 'package:mingle/user/view/signup_screen/provider/email_extension_selected_provider.dart';
import 'package:mingle/user/view/signup_screen/provider/school_selected_provider.dart';

class EnterEmailScreen extends ConsumerStatefulWidget {
  const EnterEmailScreen({super.key});

  @override
  ConsumerState<EnterEmailScreen> createState() => _EnterEmailScreenState();
}

class _EnterEmailScreenState extends ConsumerState<EnterEmailScreen> {
  @override
  Widget build(BuildContext context) {
    final String currentCountry = ref.read(selectedCountryProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 17.0),
            child: IconButton(
              icon: const ImageIcon(
                AssetImage("assets/img/signup_screen/previous_screen_icon.png"),
                color: GRAYSCALE_BLACK,
              ),
              onPressed: () {
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "학교 이메일을",
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "입력해 주세요.",
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Text("인증번호가 발송돼요.",
                        style: TextStyle(
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
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 136,
                    height: 44,
                    child: TextField(
                      maxLines: null,
                      expands: true,
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: PRIMARY_COLOR_ORANGE_01)),
                          border: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: GRAYSCALE_GRAY_03))),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("@"),
                  ),
                  DropdownList(
                    itemList: currentCountry == "홍콩"
                        ? HONG_KONG_EMAIL_LIST
                        : currentCountry == "싱가포르"
                            ? SINGAPORE_EMAIL_LIST
                            : ENGLAND_EMAIL_LIST,
                    hintText: "선택",
                    isSelectedProvider: selectedEmailExtensionProvider,
                    width: 144,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 437,
            ),
            NextButton(
              nextScreen: const EnterVerificationNumberScreen(),
              buttonName: "인증번호 받기",
              buttonIcon: const ImageIcon(
                AssetImage("assets/img/signup_screen/email_icon.png"),
                color: GRAYSCALE_GRAY_04,
              ),
              isSelectedProvider: selectedEmailExtensionProvider,
            )
          ]),
        ),
      ),
    );
  }
}
