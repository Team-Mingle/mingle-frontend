import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mingle/backoffice/view/simple_image_detail_screen.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/module/components/toast_message_card.dart';

class FreshmanSignupRequestDetailScreen extends ConsumerStatefulWidget {
  final List<String> memberIds;
  final int currentIndex;
  const FreshmanSignupRequestDetailScreen(
      {super.key, required this.memberIds, required this.currentIndex});

  @override
  ConsumerState<FreshmanSignupRequestDetailScreen> createState() =>
      _FreshmanSignupRequestDetailScreenState();
}

class _FreshmanSignupRequestDetailScreenState
    extends ConsumerState<FreshmanSignupRequestDetailScreen> {
  late FToast fToast;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  void authenticate() async {
    try {
      // await ref.read(backofficeRepositoryProvider).authenticateTempSignup(memberId: );
      navigateToNextRequest();
    } on DioException catch (e) {
      fToast.showToast(
          child: const ToastMessage(message: generalErrorMsg),
          gravity: ToastGravity.CENTER,
          toastDuration: const Duration(seconds: 2));
    }
  }

  void reject() async {
    try {
      // await ref.read(backofficeRepositoryProvider).rejectTempSignup(memberId: );
      navigateToNextRequest();
    } on DioException catch (e) {
      fToast.showToast(
          child: const ToastMessage(message: generalErrorMsg),
          gravity: ToastGravity.CENTER,
          toastDuration: const Duration(seconds: 2));
    }
  }

  void navigateToNextRequest() {
    if (widget.currentIndex == widget.memberIds.length - 1) {
      fToast.showToast(
          child: const ToastMessage(message: "마지막 요청입니다."),
          gravity: ToastGravity.CENTER,
          toastDuration: const Duration(seconds: 2));
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => FreshmanSignupRequestDetailScreen(
            memberIds: widget.memberIds,
            currentIndex: widget.currentIndex + 1,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
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
          "신입생님의 회원가입 요청",
          style: TextStyle(
              fontSize: 16.0,
              letterSpacing: -0.02,
              height: 1.5,
              fontWeight: FontWeight.w400,
              color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 40.0,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              height: 300.0,
              child: GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const SimpleImageDetailScreen(
                        imgLink:
                            "https://images.unsplash.com/photo-1716222350384-763cc1ec344a?q=80&w=3538&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"))),
                child: const Image(
                  fit: BoxFit.contain,
                  image: NetworkImage(
                      "https://images.unsplash.com/photo-1716222350384-763cc1ec344a?q=80&w=3538&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text(
                    "이름: ",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: GRAYSCALE_GRAY_03),
                  ),
                  Text(
                    "홍길동",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 4.0,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text(
                    "이메일: ",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: GRAYSCALE_GRAY_03),
                  ),
                  Text(
                    "gildonghong@gmail.com",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 4.0,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text(
                    "학번: ",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: GRAYSCALE_GRAY_03),
                  ),
                  Text(
                    "24",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            // const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: authenticate,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: PRIMARY_COLOR_ORANGE_02),
                      height: 50.0,
                      width: 120.0,
                      child: const Center(
                        child: Text(
                          "승인",
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  GestureDetector(
                    onTap: reject,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: GRAYSCALE_GRAY_02),
                      height: 50.0,
                      width: 120.0,
                      child: const Center(
                        child: Text(
                          "반려",
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: GRAYSCALE_GRAY_04),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            )
          ],
        ),
      ),
    );
  }
}
