import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mingle/common/component/dropdown_list.dart';
import 'package:mingle/common/component/expanded_section.dart';
import 'package:mingle/common/component/next_button.dart';
import 'package:mingle/common/component/showup_animation.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/dio/dio.dart';
import 'package:mingle/module/components/toast_message_card.dart';
import 'package:mingle/user/components/university_domain_dropdown.dart';
import 'package:mingle/user/repository/member_repository.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';
import 'package:mingle/user/view/signup_screen/enter_offer_id_screen.dart';
import 'package:mingle/user/view/signup_screen/enter_verifiction_number_screen.dart';
import 'package:mingle/user/view/signup_screen/provider/country_selected_provider.dart';
import 'package:mingle/user/view/signup_screen/provider/email_extension_selected_provider.dart';
import 'package:mingle/user/view/signup_screen/provider/email_selected_provider.dart';
import 'package:mingle/user/view/signup_screen/upload_identification_screen.dart';

class EnterEmailScreen extends ConsumerStatefulWidget {
  final bool isPasswordReset;
  final bool isConvertEmail;
  const EnterEmailScreen(
      {super.key, this.isPasswordReset = false, this.isConvertEmail = false});

  @override
  ConsumerState<EnterEmailScreen> createState() => _EnterEmailScreenState();
}

class _EnterEmailScreenState extends ConsumerState<EnterEmailScreen> {
  String? errorMsg;
  bool isLoading = false;
  bool _isFreshieExpanded = false;
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    print("isconvertemail: ${widget.isConvertEmail}");
    final dio = ref.watch(dioProvider);
    void validateForm() async {
      final email = {
        "email":
            "${ref.read(selectedEmailProvider)}@${ref.read(selectedEmailExtensionProvider)}",
      };
      print(email);
      try {
        setState(() {
          isLoading = true;
        });
        String stat = widget.isPasswordReset.toString();
        print('상태 $stat');
        if (widget.isPasswordReset) {
          print("email sent");
          final sendCodeResp = await dio.post(
            'https://$baseUrl/auth/sendcode/pwd',
            options: Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            }),
            data: jsonEncode(email),
          );
          if (sendCodeResp.statusCode == 200) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => EnterVerificationNumberScreen(
                      isConvertEmail: widget.isConvertEmail,
                      isPasswordReset: true,
                    )));
          } else {
            throw Exception(
                "Failed to send verification code for password reset");
          }
        } else {
          final resp = await dio.post(
            'https://$baseUrl/auth/verifyemail',
            options: Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            }),
            data: jsonEncode(email),
          );

          print(resp.statusCode);
          print("verified: ${resp.data['verified'] as bool == true}");
          if (resp.data['verified'] as bool) {
            print(resp.data);
            // final sendCodeResp =
            await dio.post(
              'https://$baseUrl/auth/sendcode',
              options: Options(headers: {
                HttpHeaders.contentTypeHeader: "application/json",
              }),
              data: jsonEncode(email),
            );
            // print(sendCodeResp);
            setState(() {
              isLoading = false;
            });
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => EnterVerificationNumberScreen(
                      isConvertEmail: widget.isConvertEmail,
                    )));
          } else {
            String? error;
            switch (resp.data['code']) {
              case "EMAIL_DUPLICATED":
                error = resp.data['message'];
            }
            setState(() {
              isLoading = false;
              errorMsg = error;
            });
          }
        }
      } on DioException catch (e) {
        setState(() {
          isLoading = false;
          errorMsg = e.response?.data['message'];
        });
      }
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 17.0),
              child: IconButton(
                icon: const ImageIcon(
                  AssetImage(
                      "assets/img/signup_screen/previous_screen_icon.png"),
                  color: GRAYSCALE_BLACK,
                ),
                onPressed: () {
                  ref
                      .read(selectedEmailProvider.notifier)
                      .update((state) => "");
                  ref
                      .read(selectedEmailExtensionProvider.notifier)
                      .update((state) => "");
                  Navigator.pop(context);
                },
              ),
            ),
            title: SvgPicture.asset(
              widget.isPasswordReset
                  ? "assets/img/signup_screen/second_indicator.svg"
                  : "assets/img/signup_screen/first_indicator.svg",
            )),
        body: DefaultPadding(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.isPasswordReset ? "인증번호를 보낼" : "학교 이메일을",
                        style: const TextStyle(
                            fontSize: 24.0,
                            letterSpacing: -0.04,
                            height: 1.4,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        widget.isPasswordReset
                            ? "학교 이메일을 입력해 주세요."
                            : "입력해 주세요.",
                        style: const TextStyle(
                            fontSize: 24.0,
                            letterSpacing: -0.04,
                            height: 1.4,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                          widget.isPasswordReset
                              ? "비밀번호 재설정을 위해 본인인증이 필요해요."
                              : "인증번호가 발송돼요.",
                          style: const TextStyle(
                              color: GRAYSCALE_GRAY_03,
                              fontSize: 14.0,
                              letterSpacing: -0.01,
                              height: 1.4,
                              fontWeight: FontWeight.w400)),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 136,
                            height: 44,
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.bottom,
                              onChanged: (email) {
                                setState(() {
                                  errorMsg = "";
                                });
                                ref
                                    .read(selectedEmailProvider.notifier)
                                    .update((state) => email);
                              },
                              textAlign: TextAlign.center,
                              // maxLines: null,
                              decoration: const InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: PRIMARY_COLOR_ORANGE_01)),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: GRAYSCALE_GRAY_03))),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text("@"),
                          ),
                          UniversityDomainDropdownList(
                            isConvertEmail: widget.isConvertEmail,
                          )
                          // DropdownList(
                          //   itemList: currentCountry == "홍콩"
                          //       ? HONG_KONG_EMAIL_LIST
                          //       : SINGAPORE_EMAIL_LIST,
                          //   // currentCountry == "싱가포르"
                          //   //     ? SINGAPORE_EMAIL_LIST
                          //   //     : ENGLAND_EMAIL_LIST,
                          //   hintText: "선택",
                          //   isSelectedProvider: selectedEmailExtensionProvider,
                          // ),
                        ],
                      ),
                      const SizedBox(
                        height: 11.0,
                      ),
                      ShowUp(
                        delay: 0,
                        child: Text(
                          errorMsg != null ? errorMsg! : "",
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.red,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              if (!widget.isConvertEmail)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isFreshieExpanded = !_isFreshieExpanded;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        top: 12.0,
                        bottom: _isFreshieExpanded ? 20.0 : 12.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: GRAYSCALE_GRAY_02),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              "아직 학교 이메일이 없으신가요?",
                              style: TextStyle(
                                  fontSize: 12.0, fontWeight: FontWeight.w500),
                            ),
                            const Spacer(),
                            SvgPicture.asset(_isFreshieExpanded
                                ? "assets/img/module_review_screen/up_tick_icon.svg"
                                : "assets/img/module_review_screen/down_tick_icon.svg")
                          ],
                        ),
                        ExpandedSection(
                          expand: _isFreshieExpanded,
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "아직 학교 이메일을 발급받지 못한 예비 합격생일 경우, Offer Letter 인증을 통해서 신입생 계정을 만들 수 있어요.\n\n임시 계정으로 회원가입 한 유저는 학교 이메일을 발급받은 후 \"마이페이지” > “신입생 계정에서 정규 계정으로 전환하기” 에서 재학생 인증을 다시 진행해야 돼요.\n\n개강 후에도 정규 계정으로 전환되지 않은 유저는 밍글 이용에제재가 있을 수 있는 점 확인 부탁드려요.",
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: GRAYSCALE_GRAY_04_5,
                                      letterSpacing: -0.06),
                                ),
                                const SizedBox(
                                  height: 17.0,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const EnterOfferIdScreen())),
                                    child: const Text(
                                      "Offer Letter 인증하고 신입생 계정 만들기",
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w500,
                                          color: PRIMARY_COLOR_ORANGE_01),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              Expanded(child: Container()),
              // widget.isConvertEmail
              // ? NextButton(
              //     buttonName: "다음으로",
              //     isSelectedProvider: [
              //       selectedEmailExtensionProvider,
              //       selectedEmailProvider
              //     ],
              //     validators: [convertEmail],
              //     isLoading: isLoading,
              //   )
              // :
              NextButton(
                // nextScreen: EnterVerificationNumberScreen(
                //   isConvertEmail: widget.isConvertEmail,
                //   isPasswordReset: widget.isPasswordReset,
                // ),
                buttonName: "인증번호 받기",
                buttonIcon: const ImageIcon(
                  AssetImage("assets/img/signup_screen/email_icon.png"),
                  color: GRAYSCALE_GRAY_04,
                ),
                isSelectedProvider: [
                  selectedEmailExtensionProvider,
                  selectedEmailProvider
                ],
                validators: [validateForm],
                isLoading: isLoading,
              ),
              const SizedBox(
                height: 40.0,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
