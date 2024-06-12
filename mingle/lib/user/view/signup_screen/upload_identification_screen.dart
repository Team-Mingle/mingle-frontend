import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mingle/common/component/next_button.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';
import 'package:mingle/user/view/signup_screen/enter_free_domain_email_screen.dart';
import 'package:mingle/user/view/signup_screen/provider/uploaded_identification_provider.dart';

class UploadIdentificationScreen extends ConsumerStatefulWidget {
  const UploadIdentificationScreen({super.key});

  @override
  ConsumerState<UploadIdentificationScreen> createState() =>
      _UploadIdentificationScreenState();
}

class _UploadIdentificationScreenState
    extends ConsumerState<UploadIdentificationScreen> {
  final ImagePicker imagePicker = ImagePicker();
  File? multipartFile;
  @override
  Widget build(BuildContext context) {
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
                    .read(uploadedIdentificationProvider.notifier)
                    .update((state) => null);
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
                "학생증 혹은 Offer Letter 사진을\n첨부해 주세요.",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24.0,
                    letterSpacing: -0.96),
              ),
              const SizedBox(
                height: 12.0,
              ),
              const Text(
                "본교 학생 인증을 위해 필요해요.",
                style: TextStyle(fontSize: 16.0, color: GRAYSCALE_GRAY_04),
              ),
              const SizedBox(
                height: 40.0,
              ),
              GestureDetector(
                onTap: selectImage,
                child: Container(
                  height: 160.0,
                  decoration: BoxDecoration(
                      border: Border.all(color: GRAYSCALE_GRAY_02),
                      borderRadius: BorderRadius.circular(8.0),
                      color: GRAYSCALE_GRAY_0_5),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          multipartFile == null
                              ? "assets/img/post_screen/image_picker_icon_coloured.svg"
                              : "assets/img/signup_screen/check_icon.svg",
                          // colorFilter: const ColorFilter.mode(
                          //     PRIMARY_COLOR_ORANGE_02, BlendMode.srcIn
                          //     ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        multipartFile == null
                            ? const Text(
                                "이미지 업로드하기",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: PRIMARY_COLOR_ORANGE_02),
                              )
                            : const Text(
                                "이미지가 업로드되었습니다.",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: GRAYSCALE_GRAY_04),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 24.0,
              // ),
              // const Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text(
              //       "  •  ",
              //       style: TextStyle(fontWeight: FontWeight.w700),
              //     ),
              //     Expanded(
              //       child: Text(
              //         "첨부한 사진에서 얼굴 사진 등 민감한 부분은 가린 후 제출해주세요.",
              //         style: TextStyle(
              //             fontWeight: FontWeight.w700, letterSpacing: -0.28),
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "  •  ",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                            color: Colors.black, letterSpacing: -0.38),
                        children: [
                          TextSpan(
                            text: "Offer Letter를 통한 학생 인증은 ",
                          ),
                          TextSpan(
                              text: "*신입생 가입 기간",
                              style: TextStyle(fontWeight: FontWeight.w700)),
                          TextSpan(
                            text: "에만 가능해요. 그 외의 기간에 가입할 경우, ",
                          ),
                          TextSpan(
                              text: "학생증을 통해 인증",
                              style: TextStyle(fontWeight: FontWeight.w700)),
                          TextSpan(text: "해 주세요.")
                        ],
                      ),
                    ),
                  ),
                ],
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
                isSelectedProvider: [uploadedIdentificationProvider],
                nextScreen: const EnterFreeDomainEmailScreen(),
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

  void selectImage() async {
    final XFile? selectedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    final File? selectedFile =
        selectedImage != null ? File(selectedImage.path) : null;
    if (selectedFile != null) {
      setState(() {
        multipartFile = selectedFile;
        ref
            .read(uploadedIdentificationProvider.notifier)
            .update((state) => selectedFile);
      });
    }
  }
}
