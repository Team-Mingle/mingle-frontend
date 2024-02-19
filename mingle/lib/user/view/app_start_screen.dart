import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:mingle/common/component/next_button.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/user/view/login_screen.dart';
import 'package:mingle/user/view/signup_screen/select_country_screen.dart';

class AppStartScreen extends StatelessWidget {
  const AppStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(top: 105, bottom: 65.67, left: 5),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  // image: Svg(
                  //     "assets/img/login_screen/ios_illust_gradationApply.svg",
                  //     color: Colors.transparent),
                  // fit: BoxFit.cover),

                  image: AssetImage(
                      "assets/img/login_screen/ios_illust_gradationApply.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 100, left: 39),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "내 유학생활의 종착지,",
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "mingle",
                          style: TextStyle(
                            fontFamily: "Aggro",
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                ),
              ),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.only(left: 39, right: 40),
                child: NextButton(
                  nextScreen: const SelectCountryScreen(),
                  buttonName: "회원가입",
                  validators: [
                    () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const SelectCountryScreen()))
                  ],
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              SizedBox(
                height: 32.0,
                width: 167.0,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("이미 계정이 있나요?"),
                      const SizedBox(
                        width: 13.0,
                      ),
                      InkWell(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const LoginScreen(
                                      isFromSplash: true,
                                    ))),
                        child: const Text(
                          "로그인",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: PRIMARY_COLOR_ORANGE_01,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ]),
              ),
              const SizedBox(
                height: 72.0,
              )
            ],
          ),
        ]),
      ),
    );
  }
}
