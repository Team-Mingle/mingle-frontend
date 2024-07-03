import 'package:json_annotation/json_annotation.dart';

part 'pagination_params.g.dart';

@JsonSerializable()
class PaginationParams {
  final int? page;
  final int? size;
  final Map<String, List<String>>? sort;

  PaginationParams copyWith({
    int? page,
    int? size,
    Map<String, List<String>>? sort,
  }) {
    return PaginationParams(
        page: page ?? this.page,
        size: size ?? this.size,
        sort: sort ?? this.sort);
  }

  const PaginationParams({this.page, this.size, this.sort});
  factory PaginationParams.fromJson(Map<String, dynamic> json) =>
      _$PaginationParamsFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationParamsToJson(this);
}
