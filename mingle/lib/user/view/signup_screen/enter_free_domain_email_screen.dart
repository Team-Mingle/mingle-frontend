import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mingle/common/component/next_button.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/dio/dio.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';
import 'package:mingle/user/view/signup_screen/enter_verifiction_number_screen.dart';
import 'package:mingle/user/view/signup_screen/provider/full_email_selected_provider.dart';
import 'package:mingle/user/view/signup_screen/provider/uploaded_identification_provider.dart';

class EnterFreeDomainEmailScreen extends ConsumerStatefulWidget {
  const EnterFreeDomainEmailScreen({super.key});

  @override
  ConsumerState<EnterFreeDomainEmailScreen> createState() =>
      _EnterFreeDomainEmailScreenState();
}

class _EnterFreeDomainEmailScreenState
    extends ConsumerState<EnterFreeDomainEmailScreen> {
  final ImagePicker imagePicker = ImagePicker();
  File? multipartFile;
  bool isLoading = false;
  String? errorMsg;

  @override
  Widget build(BuildContext context) {
    final dio = ref.watch(dioProvider);
    void validateForm() async {
      final email = {
        "email": ref.read(selectedFullEmailProvider),
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

        print(resp.statusCode);
        print("verified: ${resp.data['verified'] as bool == true}");
        if (resp.data['verified'] as bool) {
          print(resp.data);
          await dio.post(
            'https://$baseUrl/auth/sendcode',
            options: Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            }),
            data: jsonEncode(email),
          );
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
            default:
              error = generalErrorMsg;
          }
          setState(() {
            isLoading = false;
            errorMsg = error;
          });
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
          surfaceTintColor: Colors.transparent,
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
                ref
                    .read(selectedFullEmailProvider.notifier)
                    .update((state) => "");
              },
            ),
          ),
          title: const Text(
            "회원가입",
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        body: DefaultPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24.0,
              ),
              const Text(
                "이메일을\n입력해주세요.",
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.96),
              ),
              const SizedBox(
                height: 12.0,
              ),
              const Text(
                "이메일로 인증번호가 발송돼요.",
                style: TextStyle(fontSize: 16.0, color: GRAYSCALE_GRAY_04),
              ),
              const SizedBox(
                height: 72.0,
              ),
              SizedBox(
                // height: 51,
                child: Center(
                  child: TextField(
                    // textAlignVertical: TextAlignVertical.bottom,
                    onChanged: (String val) {
                      setState(() {
                        errorMsg = null;
                      });
                      ref
                          .read(selectedFullEmailProvider.notifier)
                          .update((state) => val);
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 13.5, horizontal: 12.0),
                      errorText: errorMsg,
                      hintText: "이메일 작성",
                      hintStyle: const TextStyle(
                          color: GRAYSCALE_GRAY_03, fontSize: 16.0),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(
                          color: PRIMARY_COLOR_ORANGE_01,
                        ),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(
                          color: GRAYSCALE_GRAY_03,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              NextButton(
                nextScreen: const EnterVerificationNumberScreen(),
                buttonName: "인증번호 받기",
                buttonIcon: const ImageIcon(
                  AssetImage("assets/img/signup_screen/email_icon.png"),
                  color: GRAYSCALE_GRAY_04,
                ),
                isSelectedProvider: [selectedFullEmailProvider],
                validators: [validateForm],
                isLoading: isLoading,
              ),
              // NextButton(
              //   buttonName: "다음으로",
              //   isSelectedProvider: [selectedFullEmailProvider],
              //   validators: [validateForm],
              // ),
              const SizedBox(
                height: 40.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
