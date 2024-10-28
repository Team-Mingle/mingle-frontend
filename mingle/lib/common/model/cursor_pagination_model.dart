import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

abstract class CursorPaginationBase {
  // final CursorPaginationMeta meta = CursorPaginationMeta(page: 1, size: 20);
}

class CursorPaginationError extends CursorPaginationBase {
  final String message;
  CursorPaginationError({required this.message});
}

@JsonSerializable(genericArgumentFactories: true)
class CursorPagination<T> extends CursorPaginationBase {
  final List<T> data;
  @JsonKey(includeFromJson: false, includeToJson: false)
  CursorPaginationMeta? meta;

  CursorPagination({required this.data, this.meta});

  factory CursorPagination.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CursorPaginationFromJson(json, fromJsonT);

  CursorPagination<T> copyWith({List<T>? data, CursorPaginationMeta? meta}) {
    return CursorPagination<T>(
        data: data ?? this.data, meta: meta ?? this.meta);
  }
}

class CursorPaginationLoading extends CursorPaginationBase {}

class CursorPaginationMeta {
  final int page;
  final int size;
  final bool hasMore;

  CursorPaginationMeta(
      {required this.page, required this.size, required this.hasMore});

  CursorPaginationMeta copyWith({int? page, int? size, bool? hasMore}) {
    return CursorPaginationMeta(
        page: page ?? this.page,
        size: size ?? this.size,
        hasMore: hasMore ?? this.hasMore);
  }
}

class CursorPaginationRefetching<T> extends CursorPagination<T> {
  CursorPaginationRefetching({required super.data, required super.meta});
}

class CursorPaginationFetchingMore<T> extends CursorPagination<T> {
  CursorPaginationFetchingMore({required super.data, required super.meta});
}
