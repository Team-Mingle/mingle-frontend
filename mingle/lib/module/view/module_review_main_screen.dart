import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/utils.dart';
import 'package:mingle/module/components/viewing_pass_card.dart';
import 'package:mingle/module/view/add_module_review_screen.dart';
import 'package:mingle/module/view/module_search_screen.dart';
import 'package:mingle/point_shop/model/coupon_model.dart';
import 'package:mingle/point_shop/provider/my_coupon_provider.dart';
import 'package:mingle/point_shop/repository/point_shop_repository.dart';
import 'package:mingle/point_shop/view/point_shop_screen.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';

class ModuleReviewMainScreen extends ConsumerStatefulWidget {
  const ModuleReviewMainScreen({super.key});

  @override
  ConsumerState<ModuleReviewMainScreen> createState() =>
      _ModuleReviewMainScreenState();
}

class _ModuleReviewMainScreenState
    extends ConsumerState<ModuleReviewMainScreen> {
  CouponModel? myCoupon;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isLoading = true;
    });
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
    ref.listen(myCouponProvider, (prev, next) {
      setState(() {
        myCoupon = ref.read(myCouponProvider);
      });
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: Padding(
        //   padding: const EdgeInsets.only(left: 16.0),
        //   child: IconButton(
        //     icon: const ImageIcon(
        //       AssetImage("assets/img/signup_screen/cross_icon.png"),
        //       color: GRAYSCALE_BLACK,
        //     ),
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        // ),
      ),
      body: Builder(builder: (context) {
        return DefaultPadding(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                  Scaffold.of(context).appBarMaxHeight!,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 87.0,
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "강의평가",
                        style: TextStyle(
                            fontSize: 24.0,
                            letterSpacing: -0.04,
                            height: 1.4,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const ModuleSearchScreen())),
                      child: Container(
                        height: 48.0,
                        decoration: BoxDecoration(
                            color: GRAYSCALE_GRAY_01,
                            border: Border.all(color: GRAYSCALE_GRAY_01),
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Row(children: [
                            const Text(
                              "강의명을 입력하세요.",
                              style: TextStyle(
                                  color: GRAYSCALE_GRAY_03, fontSize: 16.0),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 8.0),
                              child: Hero(
                                tag: "search",
                                child: SvgPicture.asset(
                                  "assets/img/module_review_screen/search_icon.svg",
                                  height: 24.0,
                                  width: 24.0,
                                  colorFilter: const ColorFilter.mode(
                                      Colors.black, BlendMode.srcIn),
                                ),
                              ),
                            ),
                          ]),
                          // child: TextFormField(
                          //   textAlignVertical: TextAlignVertical.center,
                          //   obscureText: false,
                          //   decoration: InputDecoration(
                          //       hintText: "강의명을 입력하세요.",
                          // hintStyle: const TextStyle(
                          //     color: GRAYSCALE_GRAY_03, fontSize: 16.0),
                          //       border: InputBorder.none,
                          // suffixIcon: Padding(
                          //   padding: const EdgeInsets.symmetric(vertical: 12.0),
                          //   child: Hero(
                          //     tag: "search",
                          //     child: SvgPicture.asset(
                          //       "assets/img/module_review_screen/search_icon.svg",
                          //       height: 24.0,
                          //       width: 24.0,
                          //       colorFilter: const ColorFilter.mode(
                          //           Colors.black, BlendMode.srcIn),
                          //     ),
                          //   ),
                          // )),
                          // ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 80.0,
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
                                    border:
                                        Border.all(color: GRAYSCALE_GRAY_01_5),
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
                                          builder: (_) =>
                                              const PointShopScreen(),
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
                                purchaseDate: convertDateToValidityDate(
                                    myCoupon!.startDate),
                                expiryDate: convertDateToValidityDate(
                                    myCoupon!.endDate),
                              ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => const AddModuleReviewScreen())),
                        child: Container(
                            width: 99.0,
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16.0),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: PRIMARY_COLOR_ORANGE_02),
                                borderRadius: BorderRadius.circular(8.0),
                                color: PRIMARY_COLOR_ORANGE_02),
                            child: Row(children: [
                              SvgPicture.asset(
                                "assets/img/module_review_screen/plus_icon.svg",
                                height: 14.0,
                                width: 14.0,
                              ),
                              const SizedBox(
                                width: 1.0,
                              ),
                              const Text(
                                "평가하기",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              )
                            ])),
                      ),
                    ),
                    const SizedBox(
                      height: 60.0,
                    )
                  ]),
            ),
          ),
        );
      }),
    );
  }
}
