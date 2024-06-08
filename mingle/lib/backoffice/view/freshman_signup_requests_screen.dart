import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/backoffice/components/signup_request_preview_card.dart';
import 'package:mingle/backoffice/model/temp_signup_request_list_model.dart';
import 'package:mingle/backoffice/model/temp_signup_request_model.dart';
import 'package:mingle/backoffice/rpeository/backoffice_repository.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';

class FreshmanSignupRequestScreen extends ConsumerStatefulWidget {
  const FreshmanSignupRequestScreen({super.key});

  @override
  ConsumerState<FreshmanSignupRequestScreen> createState() =>
      _FreshmanSignupRequestScreenState();
}

class _FreshmanSignupRequestScreenState
    extends ConsumerState<FreshmanSignupRequestScreen> {
  List<TempSignupRequestModel> signupRequests = [];
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeRequests();
  }

  void initializeRequests() async {
    setState(() {
      isLoading = true;
    });
    try {
      final requests = (await ref
              .read(backofficeRepositoryProvider)
              .getTempSignupRequestList())
          .tempSignUpApplyList;
      setState(() {
        signupRequests = requests;
        isLoading = false;
      });
    } on DioException catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void removeFromList(String nickname) {
    List<TempSignupRequestModel> newRequests = signupRequests;
    newRequests.removeWhere((member) => member.nickname == nickname);
    setState(() {
      signupRequests = newRequests;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "신입생 회원가입 요청",
          style: TextStyle(
              fontSize: 16.0,
              letterSpacing: -0.02,
              height: 1.5,
              fontWeight: FontWeight.w400,
              color: Colors.black),
        ),
      ),
      body: isLoading
          ? Container(
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(
                  color: PRIMARY_COLOR_ORANGE_02,
                ),
              ),
            )
          : SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: signupRequests.isEmpty
                    ? [
                        const SizedBox(
                          height: 300.0,
                        ),
                        const SizedBox(
                            width: double.infinity,
                            child: Center(child: Text("회원가입 요청이 없습니다")))
                      ]
                    : [
                        ...List.generate(
                            signupRequests.length,
                            (index) => SignupRequestPreviewCard(
                                  currentIndex: index,
                                  members: signupRequests,
                                  removeFromList: removeFromList,
                                )),
                        const SizedBox(
                          height: 10.0,
                        )
                      ],
              ),
            ),
    );
  }
}
