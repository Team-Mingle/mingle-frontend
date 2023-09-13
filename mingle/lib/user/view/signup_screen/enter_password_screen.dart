import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/component/countdown_timer.dart';
import 'package:mingle/common/component/dropdown_list.dart';
import 'package:mingle/common/component/next_button.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';
import 'package:mingle/user/view/signup_screen/enter_email_screen.dart';
import 'package:mingle/user/view/signup_screen/provider/country_selected_provider.dart';
import 'package:mingle/user/view/signup_screen/provider/email_extension_selected_provider.dart';
import 'package:mingle/user/view/signup_screen/provider/school_selected_provider.dart';
import 'package:mingle/user/view/signup_screen/service_agreement_screen.dart';

class EnterPasswordScreen extends ConsumerStatefulWidget {
  const EnterPasswordScreen({super.key});

  @override
  ConsumerState<EnterPasswordScreen> createState() =>
      _EnterPasswordScreenState();
}

class _EnterPasswordScreenState extends ConsumerState<EnterPasswordScreen> {
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
                AssetImage("assets/img/signup_screen/previous_screen_icon.png"),
                color: GRAYSCALE_BLACK,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: SvgPicture.asset(
            "assets/img/signup_screen/second_indicator.svg",
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
                      "비밀번호를",
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "입력해 주세요.",
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const SizedBox(
              height: 44,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "영문, 숫자 포함 6자리 이상*",
                    hintStyle: TextStyle(color: GRAYSCALE_GRAY_02),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: PRIMARY_COLOR_ORANGE_01)),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: GRAYSCALE_GRAY_03))),
              ),
            ),
            const SizedBox(
              height: 33,
            ),
            const SizedBox(
              height: 44,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "비밀번호 재입력",
                    hintStyle: TextStyle(color: GRAYSCALE_GRAY_02),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: PRIMARY_COLOR_ORANGE_01)),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: GRAYSCALE_GRAY_03))),
              ),
            ),
            const SizedBox(
              height: 393,
            ),
            NextButton(
              nextScreen: const ServiceAgreementScreen(),
              buttonName: "다음으로",
              isSelectedProvider: selectedEmailExtensionProvider,
            )
          ]),
        ),
      ),
    );
  }
}
