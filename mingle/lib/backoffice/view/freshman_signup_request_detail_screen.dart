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
  String rejectReason = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  void authenticate(int memberId) async {
    try {
      // await ref.read(backofficeRepositoryProvider).authenticateTempSignup(memberId: );
      setState(() {
        isAuthLoading = true;
      });
      await ref
          .read(backofficeRepositoryProvider)
          .authenticateTempSignup(memberId: memberId);
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

  void reject(int memberId) async {
    try {
      setState(() {
        isRejectLoading = true;
      });
      if (rejectReason.isEmpty) {
        fToast.showToast(
            child: const ToastMessage(message: "반려 사유를 입력해주세요"),
            gravity: ToastGravity.CENTER,
            toastDuration: const Duration(seconds: 2));
      }
      await ref.read(backofficeRepositoryProvider).rejectTempSignup(
          memberId: memberId,
          rejectReasonDto: RejectReasonDto(rejectReason: rejectReason));
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
      widget.removeFromList(widget.members[widget.currentIndex].nickname);
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
                  isAuthLoading
                      ? const SizedBox(
                          height: 50.0,
                          width: 120.0,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: PRIMARY_COLOR_ORANGE_01,
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () => authenticate(currentUser.memberId),
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
                  isRejectLoading
                      ? const SizedBox(
                          height: 50.0,
                          width: 120.0,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: PRIMARY_COLOR_ORANGE_01,
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: showEnterRejectReasonDialog,
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

  void showEnterRejectReasonDialog() {
    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            insetPadding: EdgeInsets.zero,
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0)),
                  // width: 343,
                  padding: const EdgeInsets.only(
                      top: 32.0, left: 32.0, right: 32.0, bottom: 24.0),
                  child: Column(
                    children: [
                      const Text(
                        "시간표 이름 변경하기",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.32),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Container(
                        height: 48.0,
                        width: 279.0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: GRAYSCALE_GRAY_02),
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                          child: TextFormField(
                            onChanged: (reason) {
                              setState(
                                () {
                                  rejectReason = reason;
                                },
                              );
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "반려 사유를 입력해주세요",
                              hintStyle: TextStyle(
                                  color: GRAYSCALE_GRAY_03, fontSize: 16.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              height: 40.0,
                              width: 120.0,
                              decoration: BoxDecoration(
                                  color: GRAYSCALE_GRAY_01,
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: const Center(
                                child: Text(
                                  "취소하기",
                                  style: TextStyle(
                                      color: GRAYSCALE_GRAY_04,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                              reject(
                                  widget.members[widget.currentIndex].memberId);
                            },
                            child: Container(
                              height: 40.0,
                              width: 120.0,
                              decoration: BoxDecoration(
                                  color: PRIMARY_COLOR_ORANGE_02,
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: const Center(
                                child: Text(
                                  "반려하기",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
