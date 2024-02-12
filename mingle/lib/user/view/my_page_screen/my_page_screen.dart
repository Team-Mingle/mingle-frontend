import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/component/next_button.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/secure_storage/secure_storage.dart';
import 'package:mingle/user/components/my_page_tile.dart';
import 'package:mingle/user/provider/is_fresh_login_provider.dart';
import 'package:mingle/user/view/login_screen.dart';
import 'package:mingle/user/view/my_page_screen/commented_posts_screen.dart';
import 'package:mingle/user/view/my_page_screen/liked_posts_screen.dart';
import 'package:mingle/user/view/my_page_screen/liked_second_hand_posts_screen.dart';
import 'package:mingle/user/view/my_page_screen/manage_account_screen.dart';
import 'package:mingle/user/view/my_page_screen/market_liked_screen.dart';
import 'package:mingle/user/view/my_page_screen/market_selling_screen.dart';
import 'package:mingle/user/view/my_page_screen/my_module_pass_and_point_screen.dart';
import 'package:mingle/user/view/my_page_screen/my_module_reviews_screen.dart';
import 'package:mingle/user/view/my_page_screen/my_posts_screen.dart';
import 'package:mingle/user/view/my_page_screen/privacy_policy_screen.dart';
import 'package:mingle/user/view/my_page_screen/scrapped_posts_screen.dart';
import 'package:mingle/user/view/my_page_screen/terms_and_conditions_screen.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';

class MyPageScreen extends ConsumerWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> activityTitles = [
      "스크랩한 글",
      "좋아요 누른 글",
      "내가 작성한 글",
      "내가 작성한 댓글"
    ];

    List<String> secondHandMarketTitles = ["판매 내역", "찜한 내역"];

    List<String> moduleReviewTitles = ["이용권 및 포인트", "내가 작성한 강의평"];

    List<String> userUtilTitles = ["이용약관", "개인정보 처리방침", "밍글에 문의하기"];

    List<Widget> activityScreens = [
      const ScrappedPostsScreen(),
      const LikedPostsScreen(),
      const MyPostsScreen(),
      const CommentedPostsScreen()
    ];

    List<Widget> secondHandMarketScreens = [
      MarketSellingScreen(),
      const LikedSecondHandPostsScreen(),
    ];

    List<Widget> moduleReviewScreens = [
      const MyModulePassAndPointScreen(),
      const MyModuleReviewsScreen()
    ];

    List<Widget> userUtilScreens = [
      const TermsAndConditionsScreen(),
      const PrivacyPolicyScreen(),
      Container()
    ];

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
                    height: 21.0,
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
                    height: 21.0,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "강의평가",
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
                      titles: moduleReviewTitles,
                      screens: moduleReviewScreens,
                    ),
                  ),
                  const SizedBox(
                    height: 21.0,
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
                      GestureDetector(
                        child: const Text(
                          "로그아웃",
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              color: GRAYSCALE_GRAY_04),
                        ),
                        onTap: () {
                          FlutterSecureStorage storage =
                              ref.watch(secureStorageProvider);
                          ref
                              .watch(isFreshLoginProvider.notifier)
                              .update((_) => true);
                          // storage.delete(key: ACCESS_TOKEN_KEY);
                          // storage.delete(key: REFRESH_TOKEN_KEY);
                          storage.deleteAll();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (_) => const LoginScreen()));
                        },
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
