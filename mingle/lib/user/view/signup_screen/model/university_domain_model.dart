import 'package:json_annotation/json_annotation.dart';

part 'university_domain_model.g.dart';

@JsonSerializable()
class UniversityDomainModel {
  final int universityId;
  final String displayUniversityName;
  final String domain;

  UniversityDomainModel({
    required this.universityId,
    required this.displayUniversityName,
    required this.domain,
  });

  factory UniversityDomainModel.fromJson(Map<String, dynamic> json) =>
      _$UniversityDomainModelFromJson(json);
} 

// "universityId": 0,
//     "displayUniversityName": "string",
//     "domain": "string"