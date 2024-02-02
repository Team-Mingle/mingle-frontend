import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';

class TermsAndConditionsScreen extends ConsumerStatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  ConsumerState<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState
    extends ConsumerState<TermsAndConditionsScreen> {
  late String termsAndConditions;
  bool isLoading = true;

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
          termsAndConditions = termsAndConditionResp.data['policy'];
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const ImageIcon(
              AssetImage("assets/img/signup_screen/previous_screen_icon.png"),
              color: GRAYSCALE_BLACK,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            "이용약관",
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                color: Colors.black),
          ),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: PRIMARY_COLOR_ORANGE_01,
              ))
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0)
                      .copyWith(top: 16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [Text(termsAndConditions)],
                    ),
                  ),
                ),
              ));
  }
}
