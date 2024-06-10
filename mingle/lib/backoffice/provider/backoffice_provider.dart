import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/backoffice/rpeository/backoffice_repository.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/common/model/cursor_pagination_model.dart';
import 'package:mingle/common/model/pagination_params.dart';
import 'package:mingle/post/models/category_model.dart';
import 'package:mingle/post/models/post_model.dart';
import 'package:mingle/post/repository/post_repository.dart';
import 'package:retrofit/retrofit.dart';
import 'package:collection/collection.dart';

StateNotifierProvider<BackofficePostStateNotifier, CursorPaginationBase>
    countryAllPostProvider(String countryId) {
  return StateNotifierProvider<BackofficePostStateNotifier,
      CursorPaginationBase>((ref) {
    final postRepository = ref.watch(postRepositoryProvider);
    final backofficeRepository = ref.watch(backofficeRepositoryProvider);

    final notifier = CountryAllBackofficePostStateNotifier(
        postRepository: postRepository,
        backofficeRepository: backofficeRepository,
        countryId: countryId);

    return notifier;
  });
}

StateNotifierProvider<BackofficePostStateNotifier, CursorPaginationBase>
    universityAllPostProvider(int univId) {
  return StateNotifierProvider<BackofficePostStateNotifier,
      CursorPaginationBase>((ref) {
    final postRepository = ref.watch(postRepositoryProvider);
    final backofficeRepository = ref.watch(backofficeRepositoryProvider);

    final notifier = UniversityAllBackofficePostStateNotifier(
        postRepository: postRepository,
        backofficeRepository: backofficeRepository,
        univId: univId);

    return notifier;
  });
}

final worldwideAllPostProvider = countryAllPostProvider("ALL");

final hongkongAllPostProvider = countryAllPostProvider("HONGKONG");

final chinaAllPostProvider = countryAllPostProvider("CHINA");

final singaporeAllPostProvider = countryAllPostProvider("SINGAPORE");

final worldwideAllPostProviderDetailProvider =
    countryAllPostProviderDetailProvider("ALL");

final hongkongAllPostProviderDetailProvider =
    countryAllPostProviderDetailProvider("HONGKONG");

final chinaAllPostProviderDetailProvider =
    countryAllPostProviderDetailProvider("CHINA");

final singaporeAllPostProviderDetailProvider =
    countryAllPostProviderDetailProvider("SINGAPORE");

final universityAllPostProviderList =
    List.generate(28, (index) => universityAllPostProvider(index));

final universityAllPostDetailProviderList =
    List.generate(28, (index) => universityAllPostDetailProvider(index));

ProviderFamily<PostModel?, int> countryAllPostProviderDetailProvider(
    String countryId) {
  return Provider.family<PostModel?, int>((ref, id) {
    CursorPaginationBase state = ref.watch(countryAllPostProvider(countryId));
    switch (countryId) {
      case "ALL":
        state = ref.watch(worldwideAllPostProvider);
      case "HONGKONG":
        state = ref.watch(hongkongAllPostProvider);
      case "CHINA":
        state = ref.watch(chinaAllPostProvider);
      case "SINGAPORE":
        state = ref.watch(singaporeAllPostProvider);
      default:
        state = ref.watch(hongkongAllPostProvider);
    }
    if (state is! CursorPagination) {
      return null;
    }

    return state.data.firstWhereOrNull((e) => e.postId == id);
  });
}

ProviderFamily<PostModel?, int> universityAllPostDetailProvider(int univId) {
  return Provider.family<PostModel?, int>((ref, id) {
    final state = ref.watch(universityAllPostProviderList[univId]);

    if (state is! CursorPagination) {
      return null;
    }

    return state.data.firstWhereOrNull((e) => e.postId == id);
  });
}

class BackofficePostStateNotifier extends StateNotifier<CursorPaginationBase> {
  final PostRepository postRepository;
  final BackofficeRepository backofficeRepository;
  final String? countryId;
  final int? univId;

  BackofficePostStateNotifier({
    required this.postRepository,
    required this.backofficeRepository,
    this.countryId,
    this.univId,
  }) : super(CursorPaginationLoading()) {
    paginate();
  }
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
        state =
            CursorPaginationFetchingMore(meta: pState.meta, data: pState.data);

        paginationParams =
            paginationParams.copyWith(page: pState.meta!.page + 1);
      }
      // 데이터를 처음부터 가져오는 상황
      else {
        //만약에 데이터가 있는 상황이라면
        // 기존 데이터를 보존한태로 Fetch (API요청)를 진행
        if (state is CursorPagination && !forceRefetch) {
          final pState = state as CursorPagination;
          state =
              CursorPaginationRefetching(meta: pState.meta, data: pState.data);
        } else {
          print("force refetching");
          state = CursorPaginationLoading();
        }
      }
      final CursorPagination<PostModel> resp;
      if (countryId != null) {
        resp =
            await backofficeRepository.getAllTotalPosts(countryId: countryId!);
        print("fetching data from all posts");
      } else {
        resp =
            await backofficeRepository.getAllUnivPosts(universityId: univId!);
      }

      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore;

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

  void getDetail({required int postId}) async {
    if (state is! CursorPagination) {
      await paginate();
    }

    if (state is! CursorPagination) {
      return;
    }

    final pState = state as CursorPagination;
    try {
      final resp = await postRepository.getPostDetails(postId: postId);
      print("likeCount: ${resp.likeCount}");
      state = pState.copyWith(
          data: pState.data
              .map<PostModel>((e) => e.postId == postId ? resp : e)
              .toList());
    } on DioException catch (e) {
      print(e);
    }
  }

  void addPost({required int postId}) async {
    if (state is! CursorPagination) {
      await paginate();
    }

    if (state is! CursorPagination) {
      return;
    }
    final resp = await postRepository.getPostDetails(postId: postId);
    final pState = state as CursorPagination;
    state = pState.copyWith(data: <PostModel>[resp, ...pState.data]);
  }

  void deletePost({required int postId}) async {
    if (state is! CursorPagination) {
      await paginate();
    }

    if (state is! CursorPagination) {
      return;
    }
    final pState = state as CursorPagination;
    pState.data.removeWhere((e) => e.postId == postId);
    state = pState.copyWith(data: pState.data);
  }
}

class CountryAllBackofficePostStateNotifier
    extends BackofficePostStateNotifier {
  CountryAllBackofficePostStateNotifier(
      {required super.postRepository,
      required super.backofficeRepository,
      required super.countryId});
}

class UniversityAllBackofficePostStateNotifier
    extends BackofficePostStateNotifier {
  UniversityAllBackofficePostStateNotifier(
      {required super.postRepository,
      required super.backofficeRepository,
      required super.univId});
}
