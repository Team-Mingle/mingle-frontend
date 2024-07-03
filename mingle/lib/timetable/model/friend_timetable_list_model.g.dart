// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_timetable_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendTimetableListModel _$FriendTimetableListModelFromJson(
        Map<String, dynamic> json) =>
    FriendTimetableListModel(
      friendTimetableDetailList:
          (json['friendTimetableDetailList'] as List<dynamic>)
              .map((e) => TimetableModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$FriendTimetableListModelToJson(
        FriendTimetableListModel instance) =>
    <String, dynamic>{
      'friendTimetableDetailList': instance.friendTimetableDetailList,
    };
