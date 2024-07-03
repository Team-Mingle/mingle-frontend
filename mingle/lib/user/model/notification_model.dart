import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  final int notificationId;
  final int contentId;
  final String contentType;
  final String content;
  final String notificationType;
  final String boardType;
  final String categoryType;
  bool isRead;
  final String createAt;

  NotificationModel({
    required this.notificationId,
    required this.contentId,
    required this.contentType,
    required this.content,
    required this.notificationType,
    required this.boardType,
    required this.categoryType,
    required this.isRead,
    required this.createAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
  NotificationModel copyWith({bool? isRead}) {
    return NotificationModel(
      notificationId: notificationId,
      contentId: contentId,
      contentType: contentType,
      content: content,
      notificationType: notificationType,
      boardType: boardType,
      categoryType: categoryType,
      isRead: isRead ?? this.isRead,
      createAt: createAt,
    );
  }
}
