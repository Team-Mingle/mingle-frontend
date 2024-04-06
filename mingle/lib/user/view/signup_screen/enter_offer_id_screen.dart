import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/component/next_button.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';
import 'package:mingle/user/view/signup_screen/provider/offer_id_selected_provider.dart';
import 'package:mingle/user/view/signup_screen/upload_identification_screen.dart';

class EnterOfferIdScreen extends ConsumerWidget {
  const EnterOfferIdScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                "학번 혹은 Offer Letter ID를\n입력해 주세요.",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 12.0,
              ),
              const Text(
                "본교 학생 인증을 위해 필요해요.",
                style: TextStyle(fontSize: 16.0, color: GRAYSCALE_GRAY_04),
              ),
              const SizedBox(
                height: 72.0,
              ),
              SizedBox(
                height: 51,
                child: Center(
                  child: TextField(
                    textAlignVertical: TextAlignVertical.bottom,
                    onChanged: (String val) {
                      ref
                          .read(selectedOfferIdProvider.notifier)
                          .update((state) => val);
                    },
                    decoration: const InputDecoration(
                      hintText: "학번 혹은 Offer Letter ID 작성",
                      hintStyle:
                          TextStyle(color: GRAYSCALE_GRAY_03, fontSize: 16.0),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(
                          color: PRIMARY_COLOR_ORANGE_01,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(
                          color: GRAYSCALE_GRAY_03,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 32.0,
              ),
              const Text(
                "🤔Offer Letter 인증?",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 4.0,
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: "Offer Letter를 통한 학생 인증은 ",
                    ),
                    TextSpan(
                        text: "*신입생 가입 기간",
                        style: TextStyle(fontWeight: FontWeight.w700)),
                    TextSpan(
                      text: "에만 \n가능해요. 그 외의 기간에 가입할 경우, 학번을 통해 인증해 \n주세요.",
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                "*신입생 가입 기간",
                style: TextStyle(
                    fontWeight: FontWeight.w700, color: GRAYSCALE_GRAY_04),
              ),
              const Text(
                "  •  9월 학기 시작인 학교 : 5월 ~ 9월\n  •  3월 학기 시작인 학교 : 12월 ~ 3월",
                style: TextStyle(color: GRAYSCALE_GRAY_04),
              ),
              const Spacer(),
              NextButton(
                buttonName: "다음으로",
                isSelectedProvider: [selectedOfferIdProvider],
                nextScreen: const UploadIdentificationScreen(),
              ),
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
