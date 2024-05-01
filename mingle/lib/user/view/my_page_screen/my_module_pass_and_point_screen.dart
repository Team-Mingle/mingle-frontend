import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/utils.dart';
import 'package:mingle/module/components/my_points_card.dart';
import 'package:mingle/module/components/viewing_pass_card.dart';
import 'package:mingle/point_shop/model/coupon_model.dart';
import 'package:mingle/point_shop/provider/my_coupon_provider.dart';
import 'package:mingle/point_shop/provider/remaining_points_provider.dart';
import 'package:mingle/point_shop/view/point_shop_screen.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';

class MyModulePassAndPointScreen extends ConsumerStatefulWidget {
  const MyModulePassAndPointScreen({super.key});

  @override
  ConsumerState<MyModulePassAndPointScreen> createState() =>
      _MyModulePassAndPointScreenState();
}

class _MyModulePassAndPointScreenState
    extends ConsumerState<MyModulePassAndPointScreen> {
  bool isLoading = false;
  CouponModel? myCoupon;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCoupon();
  }

  void fetchCoupon() async {
    await ref.read(myCouponProvider.notifier).getCoupon();
    setState(() {
      myCoupon = ref.read(myCouponProvider);
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        shape: const Border(
            bottom: BorderSide(color: GRAYSCALE_GRAY_01, width: 1)),
        backgroundColor: Colors.white,
        titleSpacing: 0.0,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: const ImageIcon(
              AssetImage("assets/img/module_review_screen/back_tick_icon.png"),
              color: GRAYSCALE_BLACK,
            ),
            color: GRAYSCALE_BLACK,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: const Text(
          "이용권 및 포인트",
          style: TextStyle(
              fontSize: 16.0,
              letterSpacing: -0.02,
              height: 1.5,
              color: Colors.black),
        ),
      ),
      body: Column(children: [
        DefaultPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24.0,
              ),
              const Text(
                "나의 이용권",
                style: TextStyle(color: GRAYSCALE_GRAY_04),
              ),
              const SizedBox(
                height: 8.0,
              ),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: PRIMARY_COLOR_ORANGE_01,
                      ),
                    )
                  : myCoupon == null
                      ? Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: GRAYSCALE_GRAY_01_5),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Row(
                            children: [
                              const Text(
                                "보유 중인 이용권이 없어요.",
                                style: TextStyle(letterSpacing: -0.14),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const PointShopScreen(),
                                  ),
                                ),
                                child: const Text(
                                  "이용권 구매하기",
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -0.06,
                                      color: PRIMARY_COLOR_ORANGE_01),
                                ),
                              ),
                            ],
                          ),
                        )
                      : ViewingPassCard(
                          title: myCoupon!.name,
                          purchaseDate:
                              convertDateToValidityDate(myCoupon!.startDate),
                          expiryDate:
                              convertDateToValidityDate(myCoupon!.endDate),
                        ),
            ],
          ),
        ),
        const Divider(
          height: 48.0,
        ),
        DefaultPadding(
            child: MyPointsCard(
          pointsOwned: ref.read(remainingPointsProvider),
        ))
      ]),
    );
  }
}
