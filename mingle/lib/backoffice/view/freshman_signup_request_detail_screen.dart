import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mingle/backoffice/model/temp_signup_request_model.dart';
import 'package:mingle/backoffice/rpeository/backoffice_repository.dart';
import 'package:mingle/backoffice/view/simple_image_detail_screen.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/module/components/toast_message_card.dart';

class FreshmanSignupRequestDetailScreen extends ConsumerStatefulWidget {
  final List<TempSignupRequestModel> members;
  final int currentIndex;
  final Function removeFromList;
  const FreshmanSignupRequestDetailScreen(
      {super.key,
      required this.members,
      required this.currentIndex,
      required this.removeFromList});

  @override
  ConsumerState<FreshmanSignupRequestDetailScreen> createState() =>
      _FreshmanSignupRequestDetailScreenState();
}

class _FreshmanSignupRequestDetailScreenState
    extends ConsumerState<FreshmanSignupRequestDetailScreen> {
  late FToast fToast;
  bool isAuthLoading = false;
  bool isRejectLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  void authenticate(String memberId) async {
    try {
      // await ref.read(backofficeRepositoryProvider).authenticateTempSignup(memberId: );
      setState(() {
        isAuthLoading = true;
      });
      setState(() {
        isAuthLoading = false;
      });
      navigateToNextRequest();
    } on DioException catch (e) {
      setState(() {
        isAuthLoading = false;
      });
      fToast.showToast(
          child: const ToastMessage(message: generalErrorMsg),
          gravity: ToastGravity.CENTER,
          toastDuration: const Duration(seconds: 2));
    }
  }

  void reject(String memberId) async {
    try {
      setState(() {
        isRejectLoading = true;
      });
      // await ref.read(backofficeRepositoryProvider).rejectTempSignup(memberId: memberId)
      setState(() {
        isRejectLoading = false;
      });
      // await ref.read(backofficeRepositoryProvider).rejectTempSignup(memberId: );
      navigateToNextRequest();
    } on DioException catch (e) {
      setState(() {
        isRejectLoading = false;
      });
      fToast.showToast(
          child: const ToastMessage(message: generalErrorMsg),
          gravity: ToastGravity.CENTER,
          toastDuration: const Duration(seconds: 2));
    }
  }

  void navigateToNextRequest() {
    if (widget.currentIndex == widget.members.length - 1) {
      widget.removeFromList(widget.members[widget.currentIndex].nickname);
      fToast.showToast(
          child: const ToastMessage(message: "마지막 요청입니다."),
          gravity: ToastGravity.CENTER,
          toastDuration: const Duration(seconds: 2));
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => FreshmanSignupRequestDetailScreen(
            members: widget.members,
            currentIndex: widget.currentIndex,
            removeFromList: widget.removeFromList,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    TempSignupRequestModel currentUser = widget.members[widget.currentIndex];
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
        title: Text(
          "${currentUser.nickname}님의 회원가입 요청",
          style: const TextStyle(
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
                    builder: (_) => SimpleImageDetailScreen(
                        imgLink: currentUser.photoUrl))),
                child: Image(
                  fit: BoxFit.contain,
                  image: NetworkImage(currentUser.photoUrl),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  const Text(
                    "이름: ",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: GRAYSCALE_GRAY_03),
                  ),
                  Text(
                    currentUser.nickname,
                    style: const TextStyle(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  const Text(
                    "이메일: ",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: GRAYSCALE_GRAY_03),
                  ),
                  Text(
                    currentUser.email ?? "",
                    style: const TextStyle(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  const Text(
                    "학번: ",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: GRAYSCALE_GRAY_03),
                  ),
                  Text(
                    currentUser.studentId ?? "",
                    style: const TextStyle(
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
                    // onTap: () => authenticate(currentUser.),
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
                    // onTap: reject,
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
