import 'package:json_annotation/json_annotation.dart';
import 'package:mingle/timetable/model/timetable_model.dart';

part 'friend_timetable_list_model.g.dart';

@JsonSerializable()
class FriendTimetableListModel {
  final List<TimetableModel> friendTimetableDetailList;
  FriendTimetableListModel({required this.friendTimetableDetailList});

  factory FriendTimetableListModel.fromJson(Map<String, dynamic> json) =>
      _$FriendTimetableListModelFromJson(json);
}
