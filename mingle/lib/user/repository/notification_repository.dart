import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:mingle/user/model/notification_model.dart';

part 'notification_repository.g.dart';

final notificationRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  final notificationRepository =
      NotificationRepository(dio, baseUrl: "https://$baseUrl/notification");
  return notificationRepository;
});

@RestApi()
abstract class NotificationRepository {
  factory NotificationRepository(Dio dio, {String baseUrl}) =
      _NotificationRepository;

  @GET('')
  @Headers({'accessToken': 'true'})
  Future<List<NotificationModel>> getNotifications();

  @PATCH('/{notificationId}')
  @Headers({'accessToken': 'true'})
  Future<bool> markNotificationAsRead(
      @Path('notificationId') String notificationId);
}
