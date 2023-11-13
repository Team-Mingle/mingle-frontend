import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/module/components/my_points_card.dart';
import 'package:mingle/module/view/add_module_review_screen.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';

class PointShopScreen extends StatelessWidget {
  const PointShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int pointsOwned = 800;
    Future bottomSheet(String validity, int pointsRequired) =>
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            bool isPurchasable = pointsOwned >= pointsRequired;
            return Container(
              height: 480.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 24.0,
                  ),
                  Row(
                    children: [
                      const Spacer(
                        flex: 3,
                      ),
                      const Center(
                        child: Text(
                          "이용권 구매",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: SvgPicture.asset(
                            "assets/img/module_review_screen/close_icon.svg"),
                      ),
                      const SizedBox(
                        width: 24.0,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                  Expanded(
                    child: DefaultPadding(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: GRAYSCALE_GRAY_01_5),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "강의평가 $validity 이용권",
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  "$validity동안 모든 강의평가를 제한 없이 볼 수 있습니다.",
                                  style: const TextStyle(
                                      fontSize: 12.0, color: GRAYSCALE_GRAY_04),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  "${pointsRequired}p",
                                  style: const TextStyle(fontSize: 16.0),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 28.0,
                          ),
                          Row(
                            children: [
                              const Text(
                                "보유 포인트",
                                style: TextStyle(fontSize: 16.0),
                              ),
                              const Spacer(),
                              Text(
                                "${pointsOwned}p",
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Row(
                            children: [
                              const Text(
                                "사용할 포인트",
                                style: TextStyle(fontSize: 16.0, color: RED),
                              ),
                              const Spacer(),
                              Text(
                                "-${pointsRequired}p",
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                    color: RED),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          const Divider(
                            height: 24.0,
                            color: GRAYSCALE_GRAY_02,
                          ),
                          Row(
                            children: [
                              const Text(
                                "잔여 포인트",
                                style: TextStyle(fontSize: 16.0),
                              ),
                              const Spacer(),
                              Text(
                                "${pointsOwned - pointsRequired}p",
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 11.5,
                          ),
                          !isPurchasable
                              ? Row(
                                  children: [
                                    const Text(
                                      "포인트가 부족합니다.",
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  const AddModuleReviewScreen())),
                                      child: const Text(
                                        "강의평가 작성하기",
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w500,
                                            color: PRIMARY_COLOR_ORANGE_01),
                                      ),
                                    )
                                  ],
                                )
                              : Container(),
                          const Spacer(),
                          InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              // width: 296,
                              height: 48,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: isPurchasable
                                          ? PRIMARY_COLOR_ORANGE_02
                                          : GRAYSCALE_GRAY_02),
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: isPurchasable
                                      ? PRIMARY_COLOR_ORANGE_02
                                      : GRAYSCALE_GRAY_02),
                              child: const Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "구매하기",
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
          backgroundColor: Colors.transparent,
        );
    Widget modulePassCard(String validity, int pointsRequired) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.transparent),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.06),
                  offset: Offset(1, 1),
                  blurRadius: 10.0)
            ],
            borderRadius: BorderRadius.circular(8.0)),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Row(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "강의평가 $validity 이용권",
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                "$validity동안 모든 강의평가를 제한 없이 볼 수 있습니다.",
                style:
                    const TextStyle(fontSize: 12.0, color: GRAYSCALE_GRAY_04),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                "${pointsRequired}p",
                style: const TextStyle(fontSize: 16.0),
              )
            ],
          ),
          const Spacer(),
          const SizedBox(
            height: 68.0,
            child: VerticalDivider(
              width: 24.0,
              thickness: 1.0,
              indent: 0.0,
              endIndent: 0.0,
              color: GRAYSCALE_GRAY_01_5,
            ),
          ),
          GestureDetector(
            onTap: () => bottomSheet(validity, pointsRequired),
            child: const Text(
              "구매",
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: PRIMARY_COLOR_ORANGE_01),
            ),
          )
        ]),
      );
    }

    return Scaffold(
      appBar: AppBar(
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
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Column(
        children: [
          DefaultPadding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: double.infinity,
                  height: 87.0,
                ),
                const Text(
                  "포인트샵",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Text(
                  "강의평가를 작성하여 얻은 포인트로 다른 사용자가 쓴\n    강의평가를 조회하는 이용권을 구매할 수 있어요.",
                  style: TextStyle(color: GRAYSCALE_GRAY_03),
                ),
                const SizedBox(
                  height: 56.0,
                ),
                modulePassCard("30일", 300),
                const SizedBox(
                  height: 14.0,
                ),
                modulePassCard("1년", 1000)
              ],
            ),
          ),
          const Divider(
            height: 64.0,
            color: GRAYSCALE_GRAY_01,
          ),
          const DefaultPadding(child: MyPointsCard())
        ],
      ),
    );
  }
}
