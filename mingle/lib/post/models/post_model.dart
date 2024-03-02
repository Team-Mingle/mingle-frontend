import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel {
  final int postId;
  String title;
  String content;
  final String nickname;
  final String createdAt;
  final String boardType;
  String categoryType;
  final String memberRole;
  final String status;
  int likeCount;
  int commentCount;
  final int viewCount;
  final bool fileAttached;
  final bool blinded;

  PostModel({
    required this.postId,
    required this.title,
    required this.content,
    required this.nickname,
    required this.createdAt,
    required this.boardType,
    required this.categoryType,
    required this.memberRole,
    required this.status,
    required this.likeCount,
    required this.commentCount,
    required this.viewCount,
    required this.fileAttached,
    required this.blinded,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  static convertUTCtoLocalPreview(String utc) {
    DateTime dateTime = DateFormat('yy/MM/dd hh:mm').parse(utc, true).toLocal();
    DateTime now = DateFormat('yyyy-MM-dd hh:mm:ss')
        .parse(DateTime.now().toString(), false);
    int yearDiff = now.year - dateTime.year;
    int monthDiff = yearDiff > 0
        ? (12 + now.month - dateTime.month)
        : (now.month - dateTime.month);
    int dayDiff = now.day - dateTime.day;
    int hourDiff = now.hour - dateTime.hour;
    int minutesDiff = now.minute - dateTime.minute;

    if (yearDiff > 0 && monthDiff >= 12) {
      return '$yearDiff년 전';
    } else if (monthDiff > 0) {
      return '$monthDiff달 전';
    } else if (dayDiff > 0) {
      return '$dayDiff일 전';
    } else if (hourDiff > 0) {
      return '$hourDiff시간 전';
    } else if (minutesDiff > 0) {
      return '$minutesDiff분 전';
    } else {
      return '방금 전';
    }
  }

  static convertUTCtoLocal(String utc) {
    DateTime dateTime = DateFormat('yy/MM/dd hh:mm').parse(utc, true).toLocal();
    String year = (dateTime.year % 100).toString();
    String month = dateTime.month.toString();
    String date = dateTime.day.toString();
    String hour = dateTime.hour.toString();
    String minute = dateTime.minute.toString();
    year = year.length == 1 ? '0$year' : year;
    month = month.length == 1 ? '0$month' : month;
    date = date.length == 1 ? '0$date' : date;
    hour = hour.length == 1 ? '0$hour' : hour;
    minute = minute.length == 1 ? '0$minute' : minute;
    return '$year/$month/$date $hour:$minute';
  }
}

// "postId": 0,
//     "title": "string",
//     "content": "string",
//     "nickname": "string",
//     "createdAt": "string",
//     "boardType": "TOTAL",
//     "categoryType": "FREE",
//     "memberRole": "USER",
//     "likeCount": 0,
//     "commentCount": 0,
//     "viewCount": 0,
//     "fileAttached": true,
//     "blinded": true