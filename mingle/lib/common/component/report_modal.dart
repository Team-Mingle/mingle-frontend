import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/dio/dio.dart';
import 'package:mingle/module/components/toast_message_card.dart';

CupertinoActionSheetAction reportModal(String contentType, int contentId,
    BuildContext context, WidgetRef ref, FToast fToast) {
  return CupertinoActionSheetAction(
    isDestructiveAction: true,
    child: const Text('신고하기'),
    onPressed: () {
      Navigator.of(context).pop();

      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('취소하기'),
          ),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                report(contentType, "INAPPROPRIATE", contentId, ref, fToast);
                Navigator.pop(context);
              },
              child: const Text('게시판 성격에 부적절함'),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                report(contentType, "SWEAR", contentId, ref, fToast);
                Navigator.pop(context);
              },
              child: const Text('욕설/인신공격/혐오/비하'),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                report(contentType, "AD", contentId, ref, fToast);
                Navigator.pop(context);
              },
              child: const Text('상업적 광고 및 판매'),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                report(contentType, "FRAUD", contentId, ref, fToast);
                Navigator.pop(context);
              },
              child: const Text('유출/사칭/사기'),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                report(contentType, "OBSCENE", contentId, ref, fToast);
                Navigator.pop(context);
              },
              child: const Text('음란물/불건전한 대화'),
            )
          ],
        ),
      );
    },
  );
}

report(String contentType, String reportType, int contentId, WidgetRef ref,
    FToast fToast) async {
  final dio = ref.watch(dioProvider);
  try {
    final reqBody = {
      "contentType": contentType,
      "contentId": contentId,
      "reportType": reportType,
    };
    await dio.post(
      "https://$baseUrl/report",
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      ),
      data: jsonEncode(reqBody),
    );
    fToast.showToast(
      child: const ToastMessage(message: "신고가 접수되었습니다"),
      gravity: ToastGravity.CENTER,
      toastDuration: const Duration(seconds: 2),
    );
  } on DioException catch (e) {
    fToast.showToast(
      child: ToastMessage(message: e.response?.data['message'] ?? "다시 시도해주세요"),
      gravity: ToastGravity.CENTER,
      toastDuration: const Duration(seconds: 2),
    );
  }
}
