import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/common/model/cursor_pagination_model.dart';
import 'package:mingle/common/model/pagination_params.dart';
import 'package:mingle/module/model/course_detail_model.dart';
import 'package:mingle/module/repository/course_repository.dart';
import 'package:mingle/post/models/category_model.dart';
import 'package:mingle/post/models/post_model.dart';
import 'package:mingle/post/repository/post_repository.dart';
import 'package:retrofit/retrofit.dart';
import 'package:collection/collection.dart';

class ModuleStateNotifier extends StateNotifier<CursorPaginationBase> {
  final CourseRepository moduleRepository;
  final String keyword;
  ModuleStateNotifier({required this.moduleRepository, required this.keyword})
      : super(CursorPaginationLoading()) {
    paginate();
  }
  // paginate() async {
  //   final resp = await postRepository.paginate(
  //       boardType: boardType, categoryType: categoryType);

  //   state = resp.data;
  // }
  Future<void> paginate(
      {int fetchCount = 20,
      // true면 추가로 데이터 더 가져옴
      // false면 새로고침(현재 상태 덮어씌움)
      bool fetchMore = false,
      // 강제로 다시 로딩하기
      // true - CursorPaginationLoading()
      bool forceRefetch = false,
      bool normalRefetch = false}) async {
    try {
      // 5 가지 가능성
      // State의 상태
      // [상태가]
      // 1) CursorPagination - 정상적으로 데이터가 있는 상태
      // 2) CursorPaginationLoading - 데이터가 로딩중인 상태 (현재 캐시 없음)
      // 3) CursorPaginationError - 에러가 있는 상태
      // 4) CursorPaginationRefetching - 첫번째 페이지부터 다시 데이터를 가져올떄
      // 5) CursorPaginationFetchMore - 추가 데이터를 paginate 해오라는 요청을 받았을때

      //바로 반환하는 상황
      // 1) hasmore = false (기존 상태에서 더 데이터가 없다는 값을 들고있다면)
      // 2) 로딩중 - fetchMore : true
      //    fetchMore가 아닐때 - 새로고침의 의도가 있다
      if (state is CursorPagination && !forceRefetch && !normalRefetch) {
        final pState = state as CursorPagination;
        print(pState.meta);
        if (!pState.meta!.hasMore) {
          return;
        }
      }

      final isLoading = state is CursorPaginationLoading;
      final isRefetching = state is CursorPaginationRefetching;
      final isFetchingMore = state is CursorPaginationFetchingMore;

      // 2번 상황
      if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
        return;
      }

      PaginationParams paginationParams = const PaginationParams(size: 20);

      //fetchMore
      // 데이터를 추가로 더 가져오는 상황
      if (fetchMore) {
        final pState = state as CursorPagination;
        state = CursorPaginationFetchingMore(
            meta: pState.meta,
            data: pState.data,
            totalCount: pState.totalCount);

        paginationParams =
            paginationParams.copyWith(page: pState.meta!.page + 1);
      }
      // 데이터를 처음부터 가져오는 상황
      else {
        //만약에 데이터가 있는 상황이라면
        // 기존 데이터를 보존한태로 Fetch (API요청)를 진행
        if (state is CursorPagination && !forceRefetch) {
          final pState = state as CursorPagination;
          state = CursorPaginationRefetching(
              meta: pState.meta,
              data: pState.data,
              totalCount: pState.totalCount);
        } else {
          print("force refetching");
          state = CursorPaginationLoading();
        }
      }
      final CursorPagination<CourseDetailModel> resp = await moduleRepository
          .search(keyword: keyword, paginationParams: paginationParams);

      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore;
        print("pstate: ${pState.data.length}");
        print("resp: ${resp.data.length}");
        //기존 데이터에 새로운 데이터 추가

        state = resp.copyWith(
            data: [...pState.data, ...resp.data],
            meta: pState.meta!.copyWith(
                page: pState.meta!.page + 1, hasMore: resp.data.length == 20));
      } else {
        resp.meta = CursorPaginationMeta(
            page: 0, size: resp.data.length, hasMore: resp.data.length == 20);
        print("I'm here");
        state = resp;
      }
    } catch (e) {
      print(e);
      state = CursorPaginationError(message: '데이터를 가져오지 못했습니다');
    }
  }
}
