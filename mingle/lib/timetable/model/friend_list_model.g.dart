// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendListModel _$FriendListModelFromJson(Map<String, dynamic> json) =>
    FriendListModel(
      friendList: (json['friendList'] as List<dynamic>)
          .map((e) => FriendModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FriendListModelToJson(FriendListModel instance) =>
    <String, dynamic>{
      'friendList': instance.friendList,
    };
