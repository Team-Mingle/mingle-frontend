import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/component/next_button.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/user/view/app_start_screen.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';

class FinishTempSinupScreen extends ConsumerStatefulWidget {
  const FinishTempSinupScreen({super.key});

  @override
  ConsumerState<FinishTempSinupScreen> createState() =>
      _FinishTempSinupScreenState();
}

class _FinishTempSinupScreenState extends ConsumerState<FinishTempSinupScreen> {
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
          // leading: Padding(
          //   padding: const EdgeInsets.only(left: 17.0),
          //   child: IconButton(
          //     icon: const ImageIcon(
          //       AssetImage("assets/img/signup_screen/previous_screen_icon.png"),
          //       color: GRAYSCALE_BLACK,
          //     ),
          //     onPressed: () {
          //       Navigator.pop(context);
          //       ref
          //           .read(selectedFullEmailProvider.notifier)
          //           .update((state) => "");
          //     },
          //   ),
          // ),
          // title: const Text(
          //   "회원가입",
          //   style: TextStyle(fontSize: 16.0),
          // ),
        ),
        body: DefaultPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24.0,
              ),
              const Text(
                "가입이 완료되었어요!",
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.96),
              ),
              const SizedBox(
                height: 12.0,
              ),
              const Text(
                "학생 인증이 완료되면 입력하신 이메일과 푸시 알림으로 안내드릴게요.",
                style: TextStyle(
                    fontSize: 16.0,
                    letterSpacing: -0.32,
                    color: GRAYSCALE_GRAY_04),
              ),
              const SizedBox(
                height: 150.0,
              ),
              Center(
                  child: SvgPicture.asset(
                      "assets/img/signup_screen/welcome_icon.svg")),
              const Spacer(),
              NextButton(
                nextScreen: const AppStartScreen(),
                buttonName: "완료하기",
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
