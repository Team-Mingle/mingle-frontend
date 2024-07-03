import 'package:json_annotation/json_annotation.dart';
import 'package:mingle/module/util/module_satisfaction_enum.dart';

part 'course_evaluation_model.g.dart';

@JsonSerializable()
class CourseEvaluationModel {
  final int courseEvaluationId;
  final String semester;
  final String comment;
  final String rating;

  CourseEvaluationModel(
      {required this.courseEvaluationId,
      required this.semester,
      required this.comment,
      required this.rating});

  factory CourseEvaluationModel.fromJson(Map<String, dynamic> json) =>
      _$CourseEvaluationModelFromJson(json);

  String convertSemesterString() {
    List<String> splitted = semester.split("_");
    int firstOrSecond = splitted[0] == 'FIRST' ? 1 : 2;
    String year = splitted[2].substring(2);
    String result = "$year년 ${firstOrSecond.toString()}학기";
    return result;
  }

  moduleSatisfaction convertRatingToSatisfaction() {
    switch (rating) {
      case "RECOMMENDED":
        return moduleSatisfaction.satisfied;
      case "NORMAL":
        return moduleSatisfaction.meh;
      case "NOT_RECOMMENDED":
        return moduleSatisfaction.unsatisfied;
      // case ""
      default:
        return moduleSatisfaction.satisfied;
    }
  }
}

// "courseEvaluationId": 0,
//       "semester": "FIRST_SEMESTER_2019",
//       "comment": "string",
//       "rating": "RECOMMENDED"