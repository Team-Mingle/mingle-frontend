// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_evaluation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseEvaluationModel _$CourseEvaluationModelFromJson(
        Map<String, dynamic> json) =>
    CourseEvaluationModel(
      courseEvaluationId: (json['courseEvaluationId'] as num).toInt(),
      semester: json['semester'] as String,
      comment: json['comment'] as String,
      rating: json['rating'] as String,
    );

Map<String, dynamic> _$CourseEvaluationModelToJson(
        CourseEvaluationModel instance) =>
    <String, dynamic>{
      'courseEvaluationId': instance.courseEvaluationId,
      'semester': instance.semester,
      'comment': instance.comment,
      'rating': instance.rating,
    };
