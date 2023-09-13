import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
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
import 'package:mingle/user/view/signup_screen/select_nickname_screen.dart';

class ServiceAgreementScreen extends StatefulWidget {
  const ServiceAgreementScreen({super.key});

  @override
  State<ServiceAgreementScreen> createState() => _ServiceAgreementScreenState();
}

class _ServiceAgreementScreenState extends State<ServiceAgreementScreen> {
  List<bool> selected = [false, false, false, false];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void toggleAll() {
      setState(() {
        selected = selected[0]
            ? [false, false, false, false]
            : [true, true, true, true];
      });
    }

    void toggleCurr(int index) {
      setState(() {
        selected[index] = !selected[index];
      });
    }

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
            "assets/img/signup_screen/third_indicator.svg",
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
                      "밍글 서비스 약관에",
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "동의해 주세요.",
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    toggleAll();
                  },
                  child: selected[0]
                      ? SvgPicture.asset(
                          "assets/img/signup_screen/check_filled.svg",
                        )
                      : SvgPicture.asset(
                          "assets/img/signup_screen/check_blank.svg",
                        ),
                ),
                const SizedBox(
                  width: 24.0,
                ),
                const Text(
                  "약관 전체동의",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            const Divider(
              height: 0,
              thickness: 1,
              color: GRAYSCALE_GRAY_02,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    toggleCurr(1);
                  },
                  child: selected[1]
                      ? SvgPicture.asset(
                          "assets/img/signup_screen/check_filled.svg",
                        )
                      : SvgPicture.asset(
                          "assets/img/signup_screen/check_blank.svg",
                        ),
                ),
                const SizedBox(
                  width: 24.0,
                ),
                const Text(
                  "만 14세 이상입니다.",
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
                )
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    toggleCurr(2);
                  },
                  child: selected[2]
                      ? SvgPicture.asset(
                          "assets/img/signup_screen/check_filled.svg",
                        )
                      : SvgPicture.asset(
                          "assets/img/signup_screen/check_blank.svg",
                        ),
                ),
                const SizedBox(
                  width: 24.0,
                ),
                RichText(
                  text: TextSpan(
                      style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                      children: [
                        const TextSpan(
                          text: "(필수)",
                        ),
                        const TextSpan(text: " "),
                        TextSpan(
                            text: "서비스 이용약관",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                showModalBottomSheet<void>(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: 786,
                                      color: Colors.amber,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            const Text('Modal BottomSheet'),
                                            ElevatedButton(
                                              child: const Text(
                                                  'Close BottomSheet'),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            style: const TextStyle(
                                decoration: TextDecoration.underline)),
                        const TextSpan(text: " "),
                        const TextSpan(text: "동의")
                      ]),
                ),
                // Text(
                //   "(필수) 서비스 이용약관 동의",
                // style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
                // )
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    toggleCurr(3);
                  },
                  child: selected[3]
                      ? SvgPicture.asset(
                          "assets/img/signup_screen/check_filled.svg",
                        )
                      : SvgPicture.asset(
                          "assets/img/signup_screen/check_blank.svg",
                        ),
                ),
                const SizedBox(
                  width: 24.0,
                ),
                RichText(
                  text: TextSpan(
                      style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                      children: [
                        const TextSpan(
                          text: "(필수)",
                        ),
                        const TextSpan(text: " "),
                        TextSpan(
                            text: "개인정보 처리방침",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                showModalBottomSheet<void>(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: 786,
                                      color: Colors.amber,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            const Text('Modal BottomSheet'),
                                            ElevatedButton(
                                              child: const Text(
                                                  'Close BottomSheet'),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            style: const TextStyle(
                                decoration: TextDecoration.underline)),
                        const TextSpan(text: " "),
                        const TextSpan(text: "동의")
                      ]),
                ),
              ],
            ),
            const SizedBox(
              height: 302.0,
            ),
            NextButton(
              nextScreen: const SelectNicknameScreen(),
              buttonName: "다음으로",
              isSelectedProvider: selectedEmailExtensionProvider,
            )
          ]),
        ),
      ),
    );
  }
}
