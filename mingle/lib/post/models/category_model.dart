import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  final String categoryName;

  CategoryModel({required this.categoryName});

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  String convertName(String name) {
    switch (name) {
      case "FREE":
        return "자유";
      case "QNA":
        return "질문";
      case "KSA":
        return "학생회";
      case "MINGLE":
        return "밍글소식";
      default:
        return "";
    }
  }
}
