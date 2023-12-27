import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/secure_storage/secure_storage.dart';

final dioProvider = Provider((ref) {
  final dio = Dio();
  final storage = ref.watch(secureStorageProvider);
  dio.interceptors.add(CustomInterceptor(storage: storage));
  return dio;
});

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({required this.storage});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      print(token);
      // options.headers.addAll({'authorization': 'Bearer $token'});
      options.headers.addAll({'authorization': 'Bearer mingle-user'});
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    print(response);
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    super.onError(err, handler);
    //401 에러가 났을때 토큰을 재발급 받는 시도를 하고 토큰이 재발급되면 다시 새로운 토큰으로 요청한다.
    print(err);
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    //refresh token이 없으면 에러 던짐
    if (refreshToken == null) {
      return handler.reject(err);
    }

    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    if (isStatus401 && !isPathRefresh) {
      final dio = Dio();
      try {
        final resp = await dio.post('http://$baseUrl/auth/token',
            options:
                Options(headers: {'authorization': 'Bearer $refreshToken'}));
        final accessToken = resp.data['accessToken'];
        final options = err.requestOptions;
        options.headers.addAll({'authorization': 'Bearer $refreshToken'});
        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);
        final response = await dio.fetch(options);
        return handler.resolve(response);
      } on DioException catch (e) {
        return handler.reject(e);
      }
    }

    return handler.next(err);
    // return null;
  }
}
