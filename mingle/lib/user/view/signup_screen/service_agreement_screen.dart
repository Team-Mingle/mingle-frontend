import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/component/next_button.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/dio/dio.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';
import 'package:mingle/user/view/signup_screen/provider/email_extension_selected_provider.dart';
import 'package:mingle/user/view/signup_screen/select_nickname_screen.dart';

class ServiceAgreementScreen extends ConsumerStatefulWidget {
  const ServiceAgreementScreen({super.key});

  @override
  ConsumerState<ServiceAgreementScreen> createState() =>
      _ServiceAgreementScreenState();
}

class _ServiceAgreementScreenState
    extends ConsumerState<ServiceAgreementScreen> {
  List<bool> selected = [false, false, false, false];

  late String termsAnsConditions;
  late String privacyPolicy;

  @override
  void initState() {
    super.initState();
    setTermsAnsConditionsAndPrivacyPolicy();
  }

  void setTermsAnsConditionsAndPrivacyPolicy() async {
    final dio = Dio();
    try {
      final termsAndConditionResp = await dio.get(
        'https://$baseUrl/auth/terms-and-conditions',
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );
      if (termsAndConditionResp.statusCode == 200) {
        setState(() {
          termsAnsConditions = termsAndConditionResp.data['policy'];
        });
      }
      final privacyPolicyResp = await dio.get(
        'https://$baseUrl/auth/privacy-policy',
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );
      if (privacyPolicyResp.statusCode == 200) {
        setState(() {
          privacyPolicy = privacyPolicyResp.data['policy'];
        });
      }
    } catch (e) {
      print(e);
    }
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
                          fontSize: 24.0,
                          letterSpacing: -0.04,
                          height: 1.4,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "동의해 주세요.",
                      style: TextStyle(
                          fontSize: 24.0,
                          letterSpacing: -0.04,
                          height: 1.4,
                          fontWeight: FontWeight.w400),
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
                  style: TextStyle(
                      fontSize: 16.0,
                      letterSpacing: -0.02,
                      height: 1.5,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            const Divider(
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
                  style: TextStyle(
                      fontSize: 14.0,
                      letterSpacing: -0.01,
                      height: 1.4,
                      fontWeight: FontWeight.w400),
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
                          letterSpacing: -0.01,
                          height: 1.4,
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
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height -
                                              48.0,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 21.0, left: 24.0),
                                              child: GestureDetector(
                                                onTap: () =>
                                                    Navigator.of(context).pop(),
                                                child: const Text(
                                                  "닫기",
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      letterSpacing: -0.02,
                                                      height: 1.5,
                                                      color:
                                                          PRIMARY_COLOR_ORANGE_02),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 6.0,
                                          ),
                                          const Text(
                                            "서비스 이용약관",
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                letterSpacing: -0.03,
                                                height: 1.5,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Divider(
                                              thickness: 1.0,
                                              height: 32.0,
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    Text(termsAnsConditions)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
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
                // style: TextStyle(fontSize: 14.0,
//letterSpacing: -0.01,
// height: 1.4, fontWeight: FontWeight.w400),
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
                          letterSpacing: -0.01,
                          height: 1.4,
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
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height -
                                              48.0,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 21.0, left: 24.0),
                                              child: GestureDetector(
                                                onTap: () =>
                                                    Navigator.of(context).pop(),
                                                child: const Text(
                                                  "닫기",
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      letterSpacing: -0.02,
                                                      height: 1.5,
                                                      color:
                                                          PRIMARY_COLOR_ORANGE_02),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 6.0,
                                          ),
                                          const Text(
                                            "개인정보 처리방침",
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                letterSpacing: -0.03,
                                                height: 1.5,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Divider(
                                              thickness: 1.0,
                                              height: 32.0,
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    Text(privacyPolicy)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
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
            Expanded(child: Container()),
            NextButton(
              nextScreen: const SelectNicknameScreen(),
              buttonName: "다음으로",
              checkSelected: selected[2] && selected[3],
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
