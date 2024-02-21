import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

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
    print(options.headers['X-Refresh-Token']);
    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      print(token);
      options.headers.addAll({'authorization': 'Bearer $token'});
      // options.headers.addAll({'authorization': 'Bearer mingle-user'});
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    print(response);
    print(response.data);
    return super.onResponse(response, handler);
  }

  // @override
  // void onError(DioException err, ErrorInterceptorHandler handler) async {
  //   super.onError(err, handler);
  //   //401 에러가 났을때 토큰을 재발급 받는 시도를 하고 토큰이 재발급되면 다시 새로운 토큰으로 요청한다.
  //   print(err);
  //   print("error error");
  //   final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
  //   final encryptedEmail = await storage.read(key: ENCRYPTED_EMAIL_KEY);
  //   print("encrypted email: $encryptedEmail");

  //   //refresh token이 없으면 에러 던짐
  //   if (refreshToken == null) {
  //     return handler.reject(err);
  //   }

  //   final isStatus401 = err.response?.statusCode == 401;
  //   final isPathRefresh = err.requestOptions.path == '/refresh-token';
  //   print(err.requestOptions.path);
  //   final dio = Dio();

  //   // if (isStatus401 && !isPathRefresh) {
  //   //   try {
  //   //     // print("refreshing token");
  // final resp = await dio.post('https://$baseUrl/auth/refresh-token',
  //     options: Options(headers: {
  //       'X-Refresh-Token': refreshToken,
  //       'Content-Type': "application/json",
  //     }),
  //     data: jsonEncode({"encryptedEmail": encryptedEmail}));
  // print('refresh successful');
  // final accessToken = resp.data['accessToken'];
  // final newRefreshToken = resp.data['refreshToken'];

  // final options = err.requestOptions;
  // options.headers.addAll({'authorization': 'Bearer mingle-user'});
  // await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);
  // await storage.write(key: REFRESH_TOKEN_KEY, value: newRefreshToken);

  //   //     final response = await dio.fetch(options);
  //   //     if (response.statusCode == 200) {
  //   //       print("${err.requestOptions.path} resolved");
  //   //       return handler.resolve(response);
  //   //     }
  //   //   } on DioException catch (e) {
  //   //     print("${err.requestOptions.path} rejected at catch");
  //   //     return handler.reject(e);
  //   //   }
  //   // }
  //   if (isStatus401 && !isPathRefresh) {
  //     try {
  // final options = err.requestOptions;
  // options.headers.addAll({'authorization': 'Bearer mingle-user'});

  // final response = await dio.fetch(options);
  // if (response.statusCode == 200) {
  //   print("${err.requestOptions.path} resolved");
  //   // if (err.type != DioExceptionType.cancel) {
  //   return handler.resolve(response);
  //   // }
  // }
  //     } on DioException catch (e) {
  //       print("${err.requestOptions.path} rejected1");
  //       // if (e.type != DioExceptionType.cancel) {
  //       return handler.reject(e);
  //       // }
  //     }
  //   }
  //   print("${err.requestOptions.path} rejected");
  //   return handler.reject(err);
  //   // return null;
  // }
  // @override
  // void onError(DioException err, ErrorInterceptorHandler handler) async {
  //   super.onError(err, handler);
  //   final dio = Dio();

  //   final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

  //   if (refreshToken == null) {
  //     return handler.reject(err);
  //   }

  //   final isStatus401 = err.response?.statusCode == 401;
  //   final isPathRefresh = err.requestOptions.path == '/refresh-token';

  //   if (isStatus401 && !isPathRefresh) {
  //     try {
  //       final options = err.requestOptions;
  //       options.headers.addAll({'authorization': 'Bearer mingle-user'});

  //       final response = await dio.fetch(options);
  //       if (response.statusCode == 200) {
  //         print("${err.requestOptions.path} resolved");
  //         // if (err.type != DioExceptionType.cancel) {
  //         return handler.resolve(response);
  //         // }
  //       }
  //     } on DioException catch (e) {
  //       print("${err.requestOptions.path} rejected: $e");
  //       return handler.reject(e);
  //     }
  //   }

  //   print("${err.requestOptions.path} rejected");
  //   return handler.reject(err);
  // }
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print("error error");
    print(err);
    // 401에러가 났을때 (status code)
    // 토큰을 재발급 받는 시도를하고 토큰이 재발급되면
    // 다시 새로운 토큰으로 요청을한다.
    // print('[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}');

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final encryptedEmail = await storage.read(key: ENCRYPTED_EMAIL_KEY);
    // refreshToken 아예 없으면
    // 당연히 에러를 던진다
    if (refreshToken == null) {
      // 에러를 던질때는 handler.reject를 사용한다.
      return handler.reject(err);
    }

    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    print("isStatus401: $isStatus401");
    print("path: ${err.requestOptions.path}");

    if (isStatus401 && !isPathRefresh) {
      final dio = Dio();

      try {
        print("trying refetching");
        final resp = await dio.post('https://$baseUrl/auth/refresh-token',
            options: Options(headers: {
              'X-Refresh-Token': refreshToken,
              'Content-Type': "application/json",
            }),
            data: jsonEncode({"encryptedEmail": encryptedEmail}));
        print('refresh successful');
        final accessToken = resp.data['accessToken'];
        final newRefreshToken = resp.data['refreshToken'];

        final options = err.requestOptions;
        print(options.data);
        options.headers.addAll({'authorization': 'Bearer $accessToken'});
        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);
        await storage.write(key: REFRESH_TOKEN_KEY, value: newRefreshToken);
        final data = options.data;
        final newOptions =
            options.copyWith(data: data is FormData ? data.clone() : data);
        final response = await dio.fetch(newOptions);

        return handler.resolve(response);
      } on DioException catch (e) {
        return handler.reject(e);
      }
    }

    return handler.reject(err);
  }
}
