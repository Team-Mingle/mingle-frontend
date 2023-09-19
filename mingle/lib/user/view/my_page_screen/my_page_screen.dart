import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/component/next_button.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/user/components/my_page_tile.dart';
import 'package:mingle/user/view/my_page_screen/manage_account_screen.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> activityTitles = [
      "스크랩한 글",
      "좋아요 누른 글",
      "내가 작성한 글",
      "내가 작성한 댓글"
    ];

    List<String> secondHandMarketTitles = ["판매 내역", "찜한 내역"];

    List<String> userUtilTitles = ["이용약관", "개인정보 처리방침", "밍글에 문의하기"];

    List<Widget> activityScreens = [
      Container(),
      Container(),
      Container(),
      Container()
    ];

    List<Widget> secondHandMarketScreens = [Container(), Container()];

    List<Widget> userUtilScreens = [Container(), Container(), Container()];

    return Scaffold(
      backgroundColor: BACKGROUND_COLOR_GRAY,
      appBar: AppBar(
        backgroundColor: BACKGROUND_COLOR_GRAY,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: InkWell(
            child: SvgPicture.asset("assets/img/signup_screen/cross_icon.svg",
                fit: BoxFit.scaleDown),
            onTap: () => Navigator.of(context).pop(),
          ),
        ),
        title: const Text(
          "마이페이지",
          style: TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left: 20.0, right: 20.0, top: 16.0, bottom: 34.0),
        child: SingleChildScrollView(
          child: SizedBox(
              // height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 114.0,
                    // width: 335.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 28.0, bottom: 30.0, left: 20.0, right: 18.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "홍콩대학교 재학중인",
                              style: TextStyle(
                                  color: GRAYSCALE_GRAY_04,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "익명님",
                                  style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                InkWell(
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const ManageAccountScreen())),
                                  child: const Text(
                                    "계정관리",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xFFFE6C60),
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            )
                          ]),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "활동 내역",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    height: 216.0,
                    // width: 335.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: MyPageTile(
                      titles: activityTitles,
                      screens: activityScreens,
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "중고 거래",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    height: 120.0,
                    // width: 335.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: MyPageTile(
                      titles: secondHandMarketTitles,
                      screens: secondHandMarketScreens,
                    ),
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                  Container(
                    height: 168.0,
                    // width: 335.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: MyPageTile(
                      titles: userUtilTitles,
                      screens: userUtilScreens,
                    ),
                  ),
                  const SizedBox(
                    height: 21.0,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 20.0,
                      ),
                      InkWell(
                        child: const Text(
                          "로그아웃",
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              color: GRAYSCALE_GRAY_04),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 101,
                  )
                ],
              )),
        ),
      ),
    );
  }
}
