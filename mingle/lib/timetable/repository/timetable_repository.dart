import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/dio/dio.dart';
import 'package:mingle/post/repository/post_repository.dart';
import 'package:retrofit/http.dart';

final timetableRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  final timetableRepository = timetableRepository(dio, baseUrl: "https://$baseUrl");
  return timetableRepository;
});
 


// @RestApi()
// abstract class PostRepository {
//   // factory PostRepository(Dio dio, {String baseUrl}) = _timetableRepository;

//   // @GET('')
//   // @Headers({'accessToken': 'true'})
  
// }


