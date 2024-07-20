import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/module/components/module_review_card.dart';
import 'package:mingle/module/model/course_evaluation_model.dart';
import 'package:mingle/module/repository/course_evaluation_repository.dart';
import 'package:mingle/module/util/module_satisfaction_enum.dart';
import 'package:mingle/module/view/module_details_screen.dart';
import 'package:mingle/user/view/signup_screen/default_padding.dart';

class MyModuleReviewsScreen extends ConsumerWidget {
  const MyModuleReviewsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          "내가 작성한 강의평",
          style: TextStyle(
              fontSize: 16.0,
              letterSpacing: -0.02,
              height: 1.5,
              color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            width: double.infinity,
            color: GRAYSCALE_GRAY_01,
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            child: const Text(
              "강의평은 수정하거나 삭제할 수 없습니다.",
              style: TextStyle(
                  fontSize: 12.0,
                  letterSpacing: -0.005,
                  height: 1.3,
                  color: GRAYSCALE_GRAY_04),
            ),
          ),
          FutureBuilder(
            future: ref
                .watch(courseEvalutationRepositoryProvider)
                .getMyCourseEvaluations(),
            builder:
                (context, AsyncSnapshot<CourseEvaluationResponseDto> snapshot) {
              if (!snapshot.hasData) {
                return const Padding(
                  padding: EdgeInsets.only(top: 200.0),
                  child: CircularProgressIndicator(
                    color: PRIMARY_COLOR_ORANGE_01,
                  ),
                );
              }
              if (snapshot.hasError) {
                return const Text(generalErrorMsg);
              }
              final data = snapshot.data!.courseEvaluationList;

              return DefaultPadding(
                child: Column(children: [
                  ...List.generate(
                    data.length,
                    (index) => ModuleReviewCard(
                      reivew: data[index].comment,
                      semester: data[index].convertSemesterString(),
                      likes: 0,
                      satisfaction: data[index].convertRatingToSatisfaction(),
                      isFromMypageScreen: true,
                      isMine: data[index].isMine,
                      courseId: data[index].courseId,
                    ),
                  )
                ]),
              );
            },
          ),
          // ...List.generate(
          //     author.length,
          //     (index) => reviewCard(reviews[index], author[index], likes[index],
          //         satisfactions[index]))
        ],
      )),
    );
  }
}
