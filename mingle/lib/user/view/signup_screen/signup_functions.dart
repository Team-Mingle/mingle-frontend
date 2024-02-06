// import 'dart:convert';
// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:mingle/dio/dio.dart';
// import 'package:mingle/user/view/signup_screen/provider/country_selected_provider.dart';
// import 'package:mingle/user/view/signup_screen/provider/email_extension_selected_provider.dart';
// import 'package:mingle/user/view/signup_screen/provider/email_selected_provider.dart';

// final String currentCountry = ref.read(selectedCountryProvider);
//     final dio = ref.watch(dioProvider);
//     void validateForm() async {
//       final email = {
//         "email":
//             "${ref.read(selectedEmailProvider)}@${ref.read(selectedEmailExtensionProvider)}",
//       };
//       print(email);
//       try {
//         final resp = await dio.post(
//           'https://$baseUrl/auth/verifyemail',
//           options: Options(headers: {
//             HttpHeaders.contentTypeHeader: "application/json",
//           }),
//           data: jsonEncode(email),
//         );
//         print(resp.data['verified'] as bool == true);
//         if (resp.data['verified'] as bool) {
//           print(resp.data);
//           // final sendCodeResp =
//           await dio.post(
//             'https://$baseUrl/auth/sendcode',
//             options: Options(headers: {
//               HttpHeaders.contentTypeHeader: "application/json",
//             }),
//             data: jsonEncode(email),
//           );
//           // print(sendCodeResp);
//         } else {
//           String? error;
//           switch (resp.data['code']) {
//             case 2010:
//               error = "이메일을 입력해주세요.";
//             case 2011:
//               error = "이메일 형식을 확인해주세요.";
//             case 2012:
//               error = "이미 존재하는 이메일 주소입니다.";
//             case 3017:
//               error = "탈퇴한 사용자입니다.";
//           }
//         }
//       } catch (e) {
//         print(e);
//         print("error error");
        
//       }
//     }