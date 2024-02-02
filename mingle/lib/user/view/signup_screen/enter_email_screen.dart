import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/component/dropdown_list.dart';
import 'package:mingle/common/component/next_button.dart';
import 'package:mingle/common/component/showup_animation.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/dio/dio.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';
import 'package:mingle/user/view/signup_screen/enter_verifiction_number_screen.dart';
import 'package:mingle/user/view/signup_screen/provider/country_selected_provider.dart';
import 'package:mingle/user/view/signup_screen/provider/email_extension_selected_provider.dart';
import 'package:mingle/user/view/signup_screen/provider/email_selected_provider.dart';

class EnterEmailScreen extends ConsumerStatefulWidget {
  final bool isPasswordReset;
  const EnterEmailScreen({super.key, this.isPasswordReset = false});

  @override
  ConsumerState<EnterEmailScreen> createState() => _EnterEmailScreenState();
}

class _EnterEmailScreenState extends ConsumerState<EnterEmailScreen> {
  String? errorMsg;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String currentCountry = ref.read(selectedCountryProvider);
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
        final resp = await dio.post(
          'https://$baseUrl/auth/verifyemail',
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
          data: jsonEncode(email),
        );
        print(resp.data['verified'] as bool == true);
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
              builder: (_) => const EnterVerificationNumberScreen()));
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
      } catch (e) {
        setState(() {
          isLoading = false;
          errorMsg = generalErrorMsg;
        });
      }
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
                ref.read(selectedEmailProvider.notifier).update((state) => "");
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
                          fontSize: 24.0, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      widget.isPasswordReset ? "학교 이메일을 입력해 주세요." : "입력해 주세요.",
                      style: const TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w400),
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
                            fontWeight: FontWeight.w400))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 136,
                  height: 44,
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.bottom,
                    onChanged: (email) {
                      ref
                          .read(selectedEmailProvider.notifier)
                          .update((state) => email);
                    },
                    maxLines: null,
                    decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: PRIMARY_COLOR_ORANGE_01)),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: GRAYSCALE_GRAY_03))),
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
            Expanded(child: Container()),
            NextButton(
              nextScreen: EnterVerificationNumberScreen(
                isPasswordReset: widget.isPasswordReset,
              ),
              buttonName: "인증번호 받기",
              buttonIcon: const ImageIcon(
                AssetImage("assets/img/signup_screen/email_icon.png"),
                color: GRAYSCALE_GRAY_04,
              ),
              isSelectedProvider: [
                selectedEmailExtensionProvider,
                selectedEmailProvider
              ],
              // validators: [validateForm],
              isLoading: isLoading,
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
