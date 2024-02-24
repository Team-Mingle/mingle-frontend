// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'university_domain_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UniversityDomainModel _$UniversityDomainModelFromJson(
        Map<String, dynamic> json) =>
    UniversityDomainModel(
      universityId: json['universityId'] as int,
      displayUniversityName: json['displayUniversityName'] as String,
      domain: json['domain'] as String,
    );

Map<String, dynamic> _$UniversityDomainModelToJson(
        UniversityDomainModel instance) =>
    <String, dynamic>{
      'universityId': instance.universityId,
      'displayUniversityName': instance.displayUniversityName,
      'domain': instance.domain,
    };
