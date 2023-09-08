import 'package:flutter/material.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/user/view/signup_screen/first_signup_screen.dart';

class AppStartScreen extends StatelessWidget {
  const AppStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(top: 105, bottom: 65.67, left: 5),
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                  "asset/img/login_screen/ios_illust_gradationApply.jpg"),
              fit: BoxFit.cover,
            )),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100, left: 39),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Column(
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
                            fontSize: 24.0, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 486,
                      ),
                    ]),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                  (MaterialPageRoute(builder: (_) => FirstSignupScreen()))),
              child: Container(
                width: 296,
                height: 48,
                decoration: BoxDecoration(
                    border: Border.all(color: PRIMARY_COLOR_LIGHT),
                    borderRadius: BorderRadius.circular(20.0),
                    color: PRIMARY_COLOR_LIGHT),
                child: const Center(
                  child: Text(
                    "회원가입",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            SizedBox(
              height: 32.0,
              width: 167.0,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text("이미 계정이 있나요?"),
                SizedBox(
                  width: 13.0,
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    "로그인",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: PRIMARY_COLOR_DARK,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400),
                  ),
                )
              ]),
            )
          ],
        ),
      ]),
    );
  }
}
