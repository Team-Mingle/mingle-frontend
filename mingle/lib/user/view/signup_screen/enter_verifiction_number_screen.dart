import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/component/countdown_timer.dart';
import 'package:mingle/common/component/dropdown_list.dart';
import 'package:mingle/common/component/next_button.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/user/view/my_page_screen/password_change_success_screen.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';
import 'package:mingle/user/view/signup_screen/enter_email_screen.dart';
import 'package:mingle/user/view/signup_screen/enter_password_screen.dart';
import 'package:mingle/user/view/signup_screen/provider/country_selected_provider.dart';
import 'package:mingle/user/view/signup_screen/provider/email_extension_selected_provider.dart';
import 'package:mingle/user/view/signup_screen/provider/school_selected_provider.dart';

class EnterVerificationNumberScreen extends ConsumerStatefulWidget {
  final bool isPasswordReset;
  const EnterVerificationNumberScreen(
      {super.key, this.isPasswordReset = false});

  @override
  ConsumerState<EnterVerificationNumberScreen> createState() =>
      _EnterVerificationNumberScreenState();
}

class _EnterVerificationNumberScreenState
    extends ConsumerState<EnterVerificationNumberScreen> {
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
            widget.isPasswordReset
                ? "assets/img/signup_screen/third_indicator.svg"
                : "assets/img/signup_screen/first_indicator.svg",
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
                      "인증번호를",
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
                    Text("메일함을 확인하세요.",
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
            const SizedBox(
              // width: 144,
              height: 44,
              child: TextField(
                decoration: InputDecoration(
                    hintText: "인증번호 작성",
                    hintStyle: TextStyle(color: GRAYSCALE_GRAY_02),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: PRIMARY_COLOR_ORANGE_01)),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: GRAYSCALE_GRAY_03))),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const SizedBox(
              height: 44,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "잔여시간",
                          style: TextStyle(
                              color: GRAYSCALE_GRAY_03,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        CountdownTimer()
                      ],
                    ),
                    InkWell(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "인증문자 재발송",
                            style: TextStyle(
                                color: GRAYSCALE_GRAY_05,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400),
                          ),
                          ImageIcon(
                            AssetImage(
                                "assets/img/signup_screen/next_screen_icon.png"),
                            color: GRAYSCALE_GRAY_03,
                          ),
                        ],
                      ),
                    )
                  ]),
            ),
            Expanded(
              child: Container(),
            ),
            NextButton(
              nextScreen: EnterPasswordScreen(
                isPasswordReset: widget.isPasswordReset,
              ),
              buttonName: "다음으로",
              isSelectedProvider: [selectedEmailExtensionProvider],
            )
          ]),
        ),
      ),
    );
  }
}
