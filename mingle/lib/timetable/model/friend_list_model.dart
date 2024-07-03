import 'package:json_annotation/json_annotation.dart';
import 'package:mingle/timetable/model/friend_model.dart';

part 'friend_list_model.g.dart';

@JsonSerializable()
class FriendListModel {
  final List<FriendModel> friendList;
  FriendListModel({required this.friendList});

  factory FriendListModel.fromJson(Map<String, dynamic> json) =>
      _$FriendListModelFromJson(json);
}
