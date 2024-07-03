import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mingle/common/component/next_button.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/module/provider/freshman_identification_upload_provider.dart';
import 'package:mingle/point_shop/view/freshman_verification_success_screen.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';

class FreshmanUploadIdentificationScreen extends ConsumerStatefulWidget {
  const FreshmanUploadIdentificationScreen({super.key});

  @override
  ConsumerState<FreshmanUploadIdentificationScreen> createState() =>
      _FreshmanUploadIdentificationScreenState();
}

class _FreshmanUploadIdentificationScreenState
    extends ConsumerState<FreshmanUploadIdentificationScreen> {
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
                    .read(freshmanIdentificationUploadProvider.notifier)
                    .update((state) => null);
              },
            ),
          ),
          title: const Text(
            "새내기 인증",
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        body: Column(
          children: [
            DefaultPadding(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 24.0,
                  ),
                  const Text(
                    "학교 합격증을 업로드해 주세요.",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 24.0,
                        letterSpacing: -0.96),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  const Text(
                    "새내기 인증을 위해 필요해요.",
                    style: TextStyle(
                        fontSize: 16.0,
                        color: GRAYSCALE_GRAY_04,
                        letterSpacing: -0.32),
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
                  const SizedBox(
                    height: 24.0,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              color: GRAYSCALE_GRAY_01,
              child: const Text(
                "허위, 합격증과 관련 없는 이미지 등을 업로드했을 때 서비스 이용에 제한을 받을 수 있습니다.",
                style: TextStyle(
                    fontSize: 12.0,
                    letterSpacing: -0.06,
                    color: GRAYSCALE_GRAY_04),
              ),
            ),
            const Spacer(),
            DefaultPadding(
              child: NextButton(
                buttonName: "다음으로",
                isSelectedProvider: [freshmanIdentificationUploadProvider],
                nextScreen: const FreshmanVerificationSuccessScreen(),
              ),
            ),
            const SizedBox(
              height: 40.0,
            )
          ],
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
            .read(freshmanIdentificationUploadProvider.notifier)
            .update((state) => selectedFile);
      });
    }
  }
}
