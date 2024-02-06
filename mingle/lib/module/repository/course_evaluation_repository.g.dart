// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_evaluation_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseEvaluationResponseDto _$CourseEvaluationResponseDtoFromJson(
        Map<String, dynamic> json) =>
    CourseEvaluationResponseDto(
      courseEvaluationList: (json['courseEvaluationList'] as List<dynamic>)
          .map((e) => CourseEvaluationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CourseEvaluationResponseDtoToJson(
        CourseEvaluationResponseDto instance) =>
    <String, dynamic>{
      'courseEvaluationList': instance.courseEvaluationList,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _CourseEvaluationRepository implements CourseEvaluationRepository {
  _CourseEvaluationRepository(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<CourseEvaluationResponseDto> getCourseEvaluations(
      {required int courseId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'accessToken': 'true'};
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CourseEvaluationResponseDto>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/${courseId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = CourseEvaluationResponseDto.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
