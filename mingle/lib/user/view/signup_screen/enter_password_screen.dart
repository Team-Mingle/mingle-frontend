import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mingle/common/component/next_button.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/dio/dio.dart';
import 'package:mingle/module/components/toast_message_card.dart';
import 'package:mingle/user/view/my_page_screen/password_change_success_screen.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';
import 'package:mingle/user/view/signup_screen/provider/email_extension_selected_provider.dart';
import 'package:mingle/user/view/signup_screen/provider/email_selected_provider.dart';
import 'package:mingle/user/view/signup_screen/provider/password_selected_provider.dart';
import 'package:mingle/user/view/signup_screen/provider/retype_password_selected_provider.dart';
import 'package:mingle/user/view/signup_screen/provider/verification_number_entered_provider.dart';
import 'package:mingle/user/view/signup_screen/service_agreement_screen.dart';

class EnterPasswordScreen extends ConsumerStatefulWidget {
  final bool isPasswordReset;
  const EnterPasswordScreen({super.key, this.isPasswordReset = false});

  @override
  ConsumerState<EnterPasswordScreen> createState() =>
      _EnterPasswordScreenState();
}

class _EnterPasswordScreenState extends ConsumerState<EnterPasswordScreen> {
  String? errorMsg;
  String? newPassword;
  String? newPasswordConfirm;
  late FToast fToast;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  void setErrorMsg(String msg) {
    setState(() {
      errorMsg = msg;
    });
  }

  void submitPassword() {
    // print("password submit");
    // print(ref.watch(selectedPasswordProvider.notifier).state);
    // print(ref.watch(selectedRetypePasswordProvider.notifier).state);
    ref.watch(selectedPasswordProvider.notifier).state ==
            ref.watch(selectedRetypePasswordProvider.notifier).state
        ? Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => widget.isPasswordReset
                ? const PasswordChangeSuccessScreen()
                : const ServiceAgreementScreen()))
        : setErrorMsg("비밀번호가 일치하지 않습니다");
  }

  void submitPasswordChange() async {
    if (newPassword != newPasswordConfirm) {
      setErrorMsg("비밀번호가 일치하지 않습니다");
      return;
    }
    try {
      final dio = ref.watch(dioProvider);
      //   final credentials = {
      //   "email": emailController.text,
      //   "password": passwordController.text,
      //   "fcmToken": "string"
      // };
      // print(credentials);
      // try {
      // final resp = await dio.post(
      //   'https://$baseUrl/auth/login',
      //   options: Options(headers: {
      //     HttpHeaders.contentTypeHeader: "application/json",
      //   }),
      //   data: jsonEncode(credentials),
      // );
      final data = {
        "email":
            "${ref.read(selectedEmailProvider)}@${ref.read(selectedEmailExtensionProvider)}",
        "updatePassword": newPassword,
        "verificationCode": ref.watch(enteredVerificationNumberProvider)
      };
      final resp = await dio.post(
        'https://$baseUrl/auth/password',
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(data),
      );
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => const PasswordChangeSuccessScreen()));
    } on DioException catch (e) {
      fToast.showToast(
        child: ToastMessage(message: e.response?.data["message"]),
        gravity: ToastGravity.CENTER,
        toastDuration: const Duration(seconds: 2),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      .read(selectedPasswordProvider.notifier)
                      .update((state) => "");
                  ref
                      .read(selectedRetypePasswordProvider.notifier)
                      .update((state) => "");
                  Navigator.pop(context);
                },
              ),
            ),
            title: SvgPicture.asset(
              widget.isPasswordReset
                  ? "assets/img/signup_screen/fourth_indicator.svg"
                  : "assets/img/signup_screen/second_indicator.svg",
            )),
        body: DefaultPadding(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.isPasswordReset ? "새로운 비밀번호를" : "비밀번호를",
                            style: const TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.w400),
                          ),
                          const Text(
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
                  SizedBox(
                    height: 44,
                    child: TextField(
                      obscureText: true,
                      onChanged: (password) {
                        widget.isPasswordReset
                            ? newPassword = password
                            : ref
                                .read(selectedPasswordProvider.notifier)
                                .update((state) => password);
                      },
                      decoration: const InputDecoration(
                          hintText: "영문, 숫자 포함 6자리 이상*",
                          hintStyle: TextStyle(color: GRAYSCALE_GRAY_02),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: PRIMARY_COLOR_ORANGE_01)),
                          border: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: GRAYSCALE_GRAY_03))),
                    ),
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  SizedBox(
                    height: 44,
                    child: TextFormField(
                      obscureText: true,
                      onChanged: (password) {
                        setState(() {
                          errorMsg = null;
                        });
                        widget.isPasswordReset
                            ? newPasswordConfirm = password
                            : ref
                                .read(selectedRetypePasswordProvider.notifier)
                                .update((state) => password);
                      },
                      decoration: InputDecoration(
                          errorText: errorMsg,
                          hintText: "비밀번호 재입력",
                          hintStyle: const TextStyle(color: GRAYSCALE_GRAY_02),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: PRIMARY_COLOR_ORANGE_01)),
                          border: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: GRAYSCALE_GRAY_03))),
                    ),
                  ),
                  Expanded(child: Container()),
                  NextButton(
                    buttonName: "다음으로",
                    isSelectedProvider: widget.isPasswordReset
                        ? []
                        : [
                            selectedPasswordProvider,
                            selectedRetypePasswordProvider
                          ],
                    validators: [
                      widget.isPasswordReset
                          ? submitPasswordChange
                          : submitPassword
                    ],
                    isReplacement: widget.isPasswordReset,
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
