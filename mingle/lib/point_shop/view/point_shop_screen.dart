import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mingle/common/component/expanded_section.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/module/components/my_points_card.dart';
import 'package:mingle/module/components/toast_message_card.dart';
import 'package:mingle/module/view/add_module_review_screen.dart';
import 'package:mingle/point_shop/model/shop_coupon_list_model.dart';
import 'package:mingle/point_shop/model/shop_coupon_model.dart';
import 'package:mingle/point_shop/provider/remaining_points_provider.dart';
import 'package:mingle/point_shop/repository/point_shop_repository.dart';
import 'package:mingle/point_shop/view/freshman_upload_identification_screen.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';

class PointShopScreen extends ConsumerStatefulWidget {
  const PointShopScreen({super.key});

  @override
  ConsumerState<PointShopScreen> createState() => _PointShopScreenState();
}

class _PointShopScreenState extends ConsumerState<PointShopScreen> {
  bool isExpanded = false;
  int pointsOwned = 0;
  List<ShopCouponModel> shopCouponList = [];
  late FToast fToast;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPoints();
    fetchShopCouponList();
    fToast = FToast();
    fToast.init(context);
  }

  void fetchPoints() {
    setState(() {
      pointsOwned = ref.read(remainingPointsProvider);
    });
  }

  void purchaseCoupon(ShopCouponModel shopCouponModel) async {
    try {
      ref.watch(pointShopRepositoryProvider).createCoupon(
          createCouponDto:
              CreateCouponDto(couponProductId: shopCouponModel.id));
    } on DioException catch (e) {
      print(e);
      fToast.showToast(
          child: const ToastMessage(message: generalErrorMsg),
          gravity: ToastGravity.CENTER,
          toastDuration: const Duration(seconds: 2));
    }
  }

  void fetchShopCouponList() async {
    try {
      final shopCouponListModel =
          await ref.read(pointShopRepositoryProvider).getShopCouponList();
      setState(() {
        shopCouponList = shopCouponListModel.couponProductResponse;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(remainingPointsProvider, (prev, next) {
      if (prev != next) {
        fetchPoints();
      }
      /* do something, for example, call the method doSomething */
    });
    Future bottomSheet(ShopCouponModel shopCouponModel) => showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            bool isPurchasable = pointsOwned >= shopCouponModel.cost;
            return Container(
              height: 505.0,
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
                              color: Colors.white,
                              border: Border.all(color: GRAYSCALE_GRAY_01_5),
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.2),
                                    offset: Offset(-1, -2),
                                    blurRadius: 10.0)
                              ],
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  shopCouponModel.name,
                                  // "강의평가 $validity 이용권",
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      letterSpacing: -0.02,
                                      height: 1.5,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  shopCouponModel.description,
                                  // "$validity동안 모든 강의평가를 제한 없이 볼 수 있습니다.",
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      letterSpacing: -0.005,
                                      height: 1.3,
                                      color: GRAYSCALE_GRAY_04),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  "${shopCouponModel.cost}p",
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
                                    letterSpacing: -0.02,
                                    height: 1.5,
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
                                style: TextStyle(
                                    fontSize: 16.0,
                                    letterSpacing: -0.02,
                                    height: 1.5,
                                    color: RED),
                              ),
                              const Spacer(),
                              Text(
                                "-${shopCouponModel.cost}p",
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    letterSpacing: -0.02,
                                    height: 1.5,
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
                                "${pointsOwned - shopCouponModel.cost}p",
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    letterSpacing: -0.02,
                                    height: 1.5,
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
                                            letterSpacing: -0.005,
                                            height: 1.3,
                                            fontWeight: FontWeight.w500,
                                            color: PRIMARY_COLOR_ORANGE_01),
                                      ),
                                    )
                                  ],
                                )
                              : Container(),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              purchaseCoupon(shopCouponModel);
                              Navigator.of(context).pop();
                            },
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
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "구매하기",
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          letterSpacing: -0.01,
                                          height: 1.4,
                                          color: isPurchasable
                                              ? Colors.white
                                              : GRAYSCALE_GRAY_03,
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
    Widget modulePassCard(ShopCouponModel shopCouponModel) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.transparent),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                  offset: Offset(-1, -2),
                  blurRadius: 10.0)
            ],
            borderRadius: BorderRadius.circular(8.0)),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Row(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                shopCouponModel.name
                // "강의평가 $validity 이용권"
                ,
                style: const TextStyle(
                    fontSize: 16.0,
                    letterSpacing: -0.02,
                    height: 1.5,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                // "$validity동안 모든 강의평가를 제한 없이 볼 수 있습니다.",
                shopCouponModel.description,
                style: const TextStyle(
                    fontSize: 12.0,
                    letterSpacing: -0.005,
                    height: 1.3,
                    color: GRAYSCALE_GRAY_04),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                "${shopCouponModel.cost}p",
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
            onTap: () => bottomSheet(shopCouponModel),
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
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                    style: TextStyle(
                        fontSize: 24.0,
                        letterSpacing: -0.04,
                        height: 1.4,
                        fontWeight: FontWeight.w500),
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
                  ...shopCouponList.map((shopCoupon) => Padding(
                        padding: const EdgeInsets.only(bottom: 14.0),
                        child: modulePassCard(shopCoupon),
                      )),

                  // modulePassCard("30일", 300),
                  // const SizedBox(
                  //   height: 14.0,
                  // ),
                  // modulePassCard("1년", 1000),
                  const SizedBox(
                    height: 14.0,
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: GRAYSCALE_GRAY_02),
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "새내기이신가요?",
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                const Spacer(),
                                SvgPicture.asset(isExpanded
                                    ? "assets/img/module_review_screen/up_tick_icon.svg"
                                    : "assets/img/module_review_screen/down_tick_icon.svg")
                              ],
                            ),
                            ExpandedSection(
                                expand: isExpanded,
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 16.0,
                                      ),
                                      const Text(
                                        "새내기 첫학기의 경우, 강의평가를 남길 수 없으므로 1학기 무제한 이용권을 지급해 드립니다. 합격증 업로드를 통해 새내기를 인증하고 강의평가를 볼 수 있습니다.",
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: GRAYSCALE_GRAY_04_5,
                                            letterSpacing: -0.06),
                                      ),
                                      const SizedBox(
                                        height: 17.0,
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: GestureDetector(
                                          onTap: () => Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (_) =>
                                                      const FreshmanUploadIdentificationScreen())),
                                          child: const Text(
                                            "새내기 인증하고 이용권 받기",
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w500,
                                                color: PRIMARY_COLOR_ORANGE_01),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            const Divider(
              height: 64.0,
              color: GRAYSCALE_GRAY_01,
            ),
            const DefaultPadding(child: MyPointsCard()),
            const SizedBox(
              height: 106.0,
            )
          ],
        ),
      ),
    );
  }
}
