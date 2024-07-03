// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      notificationId: json['notificationId'] as int,
      contentId: json['contentId'] as int,
      contentType: json['contentType'] as String,
      content: json['content'] as String,
      notificationType: json['notificationType'] as String,
      boardType: json['boardType'] as String,
      categoryType: json['categoryType'] as String,
      isRead: json['isRead'] as bool,
      createAt: json['createAt'] as String,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'notificationId': instance.notificationId,
      'contentId': instance.contentId,
      'contentType': instance.contentType,
      'content': instance.content,
      'notificationType': instance.notificationType,
      'boardType': instance.boardType,
      'categoryType': instance.categoryType,
      'isRead': instance.isRead,
      'createAt': instance.createAt,
    };
