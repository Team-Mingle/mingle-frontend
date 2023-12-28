import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/component/countdown_timer.dart';
import 'package:mingle/common/component/next_button.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/dio/dio.dart';
import 'package:mingle/user/view/login_screen.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';
import 'package:mingle/user/view/signup_screen/enter_password_screen.dart';
import 'package:mingle/user/view/signup_screen/provider/email_extension_selected_provider.dart';
import 'package:mingle/user/view/signup_screen/provider/email_selected_provider.dart';
import 'package:mingle/user/view/signup_screen/provider/nickname_selected_provider.dart';
import 'package:mingle/user/view/signup_screen/provider/password_selected_provider.dart';

class SelectNicknameScreen extends ConsumerStatefulWidget {
  const SelectNicknameScreen({super.key});

  @override
  ConsumerState<SelectNicknameScreen> createState() =>
      _SelectNicknameScreenState();
}

class _SelectNicknameScreenState extends ConsumerState<SelectNicknameScreen> {
  bool isLoading = false;
  String? errorMsg;
  @override
  void initState() {
    super.initState();
  }

  void validateForm() async {
    final dio = ref.watch(dioProvider);
    final userInfo = {
      "univId": 1,
      "email":
          "${ref.read(selectedEmailProvider)}@${ref.read(selectedEmailExtensionProvider)}",
      "password": ref.read(selectedPasswordProvider),
      "nickname": ref.read(selectedNicknameProvider)
    };
    try {
      setState(() {
        isLoading = true;
      });
      final resp = await dio.post(
        'https://$baseUrl/auth/verifyemail',
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(userInfo),
      );
      print(resp.data['verified'] as bool == true);
      if (resp.data['verified'] as bool) {
        print(resp.data);
        // final sendCodeResp =
        await dio.post(
          'https://$baseUrl/auth/sign-up',
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
          data: jsonEncode(userInfo),
        );
        // print(sendCodeResp);
        setState(() {
          isLoading = false;
        });
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const LoginScreen()));
      } else {
        String? error;
        switch (resp.data['code']) {
          case "CODE_MATCH_FAILED":
            error = resp.data['message'];
          case "CODE_VALIDITY_EXPIRED":
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
            "assets/img/signup_screen/fourth_indicator.svg",
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
                      "다 왔어요",
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "닉네임을 지어주세요.",
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Text("닉네임과 상관없이 익명으로 활동할 수 있어요.",
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
              // width: 144,
              height: 44,
              child: TextFormField(
                onChanged: (nickname) {
                  ref
                      .read(selectedNicknameProvider.notifier)
                      .update((state) => nickname);
                },
                decoration: InputDecoration(
                    hintText: "닉네임 작성",
                    suffix: Text(
                        "${ref.watch(selectedNicknameProvider).length}/10"),
                    hintStyle: const TextStyle(color: GRAYSCALE_GRAY_02),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: PRIMARY_COLOR_ORANGE_01)),
                    border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: GRAYSCALE_GRAY_03))),
                maxLength: 10,
              ),
            ),
            Expanded(
              child: Container(),
            ),
            NextButton(
              validators: [validateForm],
              buttonName: "다음으로",
              isReplacement: true,
              isSelectedProvider: [selectedNicknameProvider],
            )
          ]),
        ),
      ),
    );
  }
}
