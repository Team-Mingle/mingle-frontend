import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mingle/common/component/next_button.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/module/view/point_shop_screen.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';

class FreshmanVerificationSuccessScreen extends StatelessWidget {
  const FreshmanVerificationSuccessScreen({super.key});

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
              padding: const EdgeInsets.only(left: 16.0),
              child: IconButton(
                icon: const ImageIcon(
                  AssetImage("assets/img/module_review_screen/close_icon.png"),
                  color: GRAYSCALE_BLACK,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const PointShopScreen()));
                },
              ),
            ),
            title: const Text(
              "새내기 인증",
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
                  "합격증이 전송되었습니다.",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24.0,
                      letterSpacing: -0.96),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                const Text(
                  "새내기 인증까지 최대 3일이 소요될 수 있습니다.\n인증 여부는 푸시알림으로 전송됩니다.",
                  style: TextStyle(
                      fontSize: 16.0,
                      color: GRAYSCALE_GRAY_04,
                      letterSpacing: -0.32),
                ),
                const Spacer(),
                NextButton(
                  buttonName: "포인트샵으로",
                  nextScreen: const PointShopScreen(),
                ),
                const SizedBox(
                  height: 40.0,
                )
              ],
            ),
          )),
    );
  }
}
