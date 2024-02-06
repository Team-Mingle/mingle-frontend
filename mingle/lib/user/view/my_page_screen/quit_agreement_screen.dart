import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mingle/common/component/next_button.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/user/view/my_page_screen/quit_enter_credential_screen.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';

class QuitAgreementScreen extends StatefulWidget {
  const QuitAgreementScreen({super.key});

  @override
  State<QuitAgreementScreen> createState() => _QuitAgreementScreenState();
}

class _QuitAgreementScreenState extends State<QuitAgreementScreen> {
  bool selected = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 13.0),
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
      ),
      body: SafeArea(
        child: Column(
          children: [
            DefaultPadding(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 16.0,
                    ),
                    const Text(
                      "밍글 탈퇴 전",
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w400),
                    ),
                    const Text(
                      "확인하세요.",
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/img/my_page_screen/sad_mingkki.png",
                      ),
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    const Row(
                      children: [
                        Text(
                          "1.",
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: PRIMARY_COLOR_ORANGE_02),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          "탈퇴하시면 재가입이 불가능합니다.",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    const Row(
                      children: [
                        Text(
                          "2.",
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: PRIMARY_COLOR_ORANGE_02),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          "작성한 모든 게시글, 댓글이 삭제됩니다.",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w600),
                        )
                      ],
                    )
                  ]),
            ),
            const SizedBox(
              height: 56.0,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(
                height: 0.0,
                thickness: 1.0,
                color: GRAYSCALE_GRAY_02,
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      selected = !selected;
                    });
                  },
                  child: selected
                      ? SvgPicture.asset(
                          "assets/img/signup_screen/check_filled.svg",
                        )
                      : SvgPicture.asset(
                          "assets/img/signup_screen/check_blank.svg",
                        ),
                ),
                const SizedBox(
                  width: 24.0,
                ),
                const Text(
                  "안내사항을 모두 확인하였으며,이에 동의합니다.",
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
                )
              ],
            ),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: NextButton(
                  nextScreen: const QuitEnterCredentialScreen(),
                  checkSelected: selected,
                  buttonName: "다음으로"),
            )
          ],
        ),
      ),
    );
  }
}
