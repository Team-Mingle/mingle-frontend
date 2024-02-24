import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mingle/common/component/next_button.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/module/components/toast_message_card.dart';
import 'package:mingle/user/provider/user_provider.dart';
import 'package:mingle/user/repository/member_repository.dart';
import 'package:mingle/user/view/my_page_screen/manage_account_screen.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';

class ChangeNicknameScreen extends ConsumerStatefulWidget {
  const ChangeNicknameScreen({super.key});

  @override
  ConsumerState<ChangeNicknameScreen> createState() =>
      _ChangeNicknameScreenState();
}

class _ChangeNicknameScreenState extends ConsumerState<ChangeNicknameScreen> {
  String currentNickname = "";
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  void submitNickname() async {
    try {
      final resp = await ref.watch(memberRepositoryProvider).changeNickname(
          newNickname: ChangeNicknameDto(newNickname: currentNickname));
      ref
          .read(currentUserProvider.notifier)
          .update((state) => state!.copyWith(nickName: currentNickname));
      fToast.showToast(
        child: const ToastMessage(message: "닉네임 변경에 성공했습니다."),
        gravity: ToastGravity.CENTER,
        toastDuration: const Duration(seconds: 2),
      );
      Navigator.of(context).pop();
    } on DioException catch (e) {
      print(e);
      print(e.response?.data['message']);
      fToast.showToast(
        child:
            ToastMessage(message: e.response?.data['message'] ?? "다시 시도해주세요"),
        gravity: ToastGravity.CENTER,
        toastDuration: const Duration(seconds: 2),
      );
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
          "닉네임 변경",
          style: TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: DefaultPadding(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 56.0,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              height: 44,
              decoration: const BoxDecoration(color: GRAYSCALE_GRAY_01),
              child: TextFormField(
                decoration: InputDecoration(
                  enabled: false,
                  hintText: ref.watch(currentUserProvider)!.univName,
                  hintStyle: const TextStyle(color: GRAYSCALE_GRAY_02),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: PRIMARY_COLOR_ORANGE_01)),
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: GRAYSCALE_GRAY_03),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            const Text(
              "학교는 변경할 수 없습니다",
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  color: GRAYSCALE_GRAY_04),
            ),
            const SizedBox(
              height: 25.0,
            ),
            SizedBox(
              // width: 144,
              height: 44,
              child: TextFormField(
                autofocus: true,
                onChanged: (value) {
                  setState(() {
                    currentNickname = value;
                  });
                },
                maxLength: 10,
                decoration: InputDecoration(
                    hintText: "닉네임 작성",
                    suffix: Text("${currentNickname.length}/10"),
                    hintStyle: const TextStyle(color: GRAYSCALE_GRAY_02),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: PRIMARY_COLOR_ORANGE_01)),
                    border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: GRAYSCALE_GRAY_03))),
              ),
            ),
            const Spacer(),
            NextButton(
              buttonName: "저장하기",
              validators: [submitNickname],
            )
          ],
        )),
      ),
    );
  }
}
