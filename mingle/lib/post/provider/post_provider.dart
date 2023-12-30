import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/model/cursor_pagination_model.dart';
import 'package:mingle/common/model/pagination_params.dart';
import 'package:mingle/post/models/category_model.dart';
import 'package:mingle/post/models/post_model.dart';
import 'package:mingle/post/repository/post_repository.dart';
import 'package:retrofit/retrofit.dart';
import 'package:collection/collection.dart';

final totalAllPostProvider =
    StateNotifierProvider<PostStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(postRepositoryProvider);

  final notifier = TotalAllPostStateNotifier(postRepository: repository);

  return notifier;
});

final totalFreePostProvider =
    StateNotifierProvider<PostStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(postRepositoryProvider);

  final notifier = TotalFreePostStateNotifier(postRepository: repository);

  return notifier;
});

final totalQnAPostProvider =
    StateNotifierProvider<PostStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(postRepositoryProvider);

  final notifier = TotalQnAPostStateNotifier(postRepository: repository);

  return notifier;
});

final totalMinglePostProvider =
    StateNotifierProvider<PostStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(postRepositoryProvider);

  final notifier = TotalMinglePostStateNotifier(postRepository: repository);

  return notifier;
});

final univAllPostProvider =
    StateNotifierProvider<PostStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(postRepositoryProvider);

  final notifier = UnivAllPostStateNotifier(postRepository: repository);

  return notifier;
});

final univFreePostProvider =
    StateNotifierProvider<PostStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(postRepositoryProvider);

  final notifier = UnivFreePostStateNotifier(postRepository: repository);

  return notifier;
});

final univQnAPostProvider =
    StateNotifierProvider<PostStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(postRepositoryProvider);

  final notifier = UnivQnAPostStateNotifier(postRepository: repository);

  return notifier;
});

final univKsaPostProvider =
    StateNotifierProvider<PostStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(postRepositoryProvider);

  final notifier = UnivKsaPostStateNotifier(postRepository: repository);

  return notifier;
});

final postCategoryProvider =
    StateNotifierProvider<PostCategoryStateNotifier, List<CategoryModel>>(
        (ref) {
  final repository = ref.watch(postRepositoryProvider);

  final notifier = PostCategoryStateNotifier(postRepository: repository);

  return notifier;
});

final totalRecentPostProvider =
    StateNotifierProvider<PostStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(postRepositoryProvider);

  final notifier = TotalRecentPostStateNotifier(postRepository: repository);

  return notifier;
});

final univRecentPostProvider =
    StateNotifierProvider<PostStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(postRepositoryProvider);

  final notifier = UnivRecentPostStateNotifier(postRepository: repository);

  return notifier;
});

final totalAllPostDetailProvider = Provider.family<PostModel?, int>((ref, id) {
  final state = ref.watch(totalAllPostProvider);

  if (state is! CursorPagination) {
    return null;
  }

  return state.data.firstWhereOrNull((e) => e.postId == id);
});

final totalFreePostDetailProvider = Provider.family<PostModel?, int>((ref, id) {
  final state = ref.watch(totalFreePostProvider);

  if (state is! CursorPagination) {
    return null;
  }

  return state.data.firstWhereOrNull((e) => e.postId == id);
});

final totalQnAPostDetailProvider = Provider.family<PostModel?, int>((ref, id) {
  final state = ref.watch(totalQnAPostProvider);

  if (state is! CursorPagination) {
    return null;
  }

  return state.data.firstWhereOrNull((e) => e.postId == id);
});

final totalMinglePostDetailProvider =
    Provider.family<PostModel?, int>((ref, id) {
  final state = ref.watch(totalMinglePostProvider);

  if (state is! CursorPagination) {
    return null;
  }

  return state.data.firstWhereOrNull((e) => e.postId == id);
});

final univAllPostDetailProvider = Provider.family<PostModel?, int>((ref, id) {
  final state = ref.watch(univAllPostProvider);

  if (state is! CursorPagination) {
    return null;
  }

  return state.data.firstWhereOrNull((e) => e.postId == id);
});

final univFreePostDetailProvider = Provider.family<PostModel?, int>((ref, id) {
  final state = ref.watch(univFreePostProvider);

  if (state is! CursorPagination) {
    return null;
  }

  return state.data.firstWhereOrNull((e) => e.postId == id);
  // return state.data.firstOrNull((e) => e.postId == id);
});

final univQnAPostDetailProvider = Provider.family<PostModel?, int>((ref, id) {
  final state = ref.watch(univQnAPostProvider);

  if (state is! CursorPagination) {
    return null;
  }

  return state.data.firstWhereOrNull((e) => e.postId == id);
});

final univKsaPostDetailProvider = Provider.family<PostModel?, int>((ref, id) {
  final state = ref.watch(univKsaPostProvider);

  if (state is! CursorPagination) {
    return null;
  }

  return state.data.firstWhereOrNull((e) => e.postId == id);
});

final totalRecentPostDetailProvider =
    Provider.family<PostModel?, int>((ref, id) {
  final state = ref.watch(totalRecentPostProvider);

  if (state is! CursorPagination) {
    return null;
  }

  return state.data.firstWhereOrNull((e) => e.postId == id);
});

final univRecentPostDetailProvider =
    Provider.family<PostModel?, int>((ref, id) {
  final state = ref.watch(univRecentPostProvider);

  if (state is! CursorPagination) {
    return null;
  }

  return state.data.firstWhereOrNull((e) => e.postId == id);
});

class PostStateNotifier extends StateNotifier<CursorPaginationBase> {
  final PostRepository postRepository;
  final String boardType;
  final String categoryType;
  PostStateNotifier(
      {required this.postRepository,
      required this.boardType,
      required this.categoryType})
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
      bool forceRefetch = false}) async {
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
      if (state is CursorPagination && !forceRefetch) {
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

      final resp = await postRepository.paginate(
          boardType: boardType,
          categoryType: categoryType,
          paginationParams: paginationParams);

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
    final resp = await postRepository.getPostDetails(postId: postId);
    print("likeCount: ${resp.likeCount}");
    state = pState.copyWith(
        data: pState.data
            .map<PostModel>((e) => e.postId == postId ? resp : e)
            .toList());
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

class TotalAllPostStateNotifier extends PostStateNotifier {
  @override
  final PostRepository postRepository;
  TotalAllPostStateNotifier({required this.postRepository})
      : super(
            postRepository: postRepository,
            boardType: 'TOTAL',
            categoryType: 'all');
}

class TotalFreePostStateNotifier extends PostStateNotifier {
  @override
  final PostRepository postRepository;
  TotalFreePostStateNotifier({required this.postRepository})
      : super(
            postRepository: postRepository,
            boardType: 'TOTAL',
            categoryType: 'FREE');
}

class TotalQnAPostStateNotifier extends PostStateNotifier {
  @override
  final PostRepository postRepository;
  TotalQnAPostStateNotifier({required this.postRepository})
      : super(
            postRepository: postRepository,
            boardType: 'TOTAL',
            categoryType: 'QNA');
}

class TotalMinglePostStateNotifier extends PostStateNotifier {
  @override
  final PostRepository postRepository;
  TotalMinglePostStateNotifier({required this.postRepository})
      : super(
            postRepository: postRepository,
            boardType: 'TOTAL',
            categoryType: 'MINGLE');
}

class UnivAllPostStateNotifier extends PostStateNotifier {
  @override
  final PostRepository postRepository;
  UnivAllPostStateNotifier({required this.postRepository})
      : super(
            postRepository: postRepository,
            boardType: 'UNIV',
            categoryType: 'all');
}

class UnivFreePostStateNotifier extends PostStateNotifier {
  @override
  final PostRepository postRepository;
  UnivFreePostStateNotifier({required this.postRepository})
      : super(
            postRepository: postRepository,
            boardType: 'UNIV',
            categoryType: 'FREE');
}

class UnivQnAPostStateNotifier extends PostStateNotifier {
  @override
  final PostRepository postRepository;
  UnivQnAPostStateNotifier({required this.postRepository})
      : super(
            postRepository: postRepository,
            boardType: 'UNIV',
            categoryType: 'QNA');
}

class UnivKsaPostStateNotifier extends PostStateNotifier {
  @override
  final PostRepository postRepository;
  UnivKsaPostStateNotifier({required this.postRepository})
      : super(
            postRepository: postRepository,
            boardType: 'UNIV',
            categoryType: 'KSA');
}

class TotalRecentPostStateNotifier extends PostStateNotifier {
  @override
  final PostRepository postRepository;
  TotalRecentPostStateNotifier({required this.postRepository})
      : super(
            postRepository: postRepository,
            boardType: 'TOTAL',
            categoryType: 'recent');
}

class UnivRecentPostStateNotifier extends PostStateNotifier {
  @override
  final PostRepository postRepository;
  UnivRecentPostStateNotifier({required this.postRepository})
      : super(
            postRepository: postRepository,
            boardType: 'UNIV',
            categoryType: 'recent');
}

class PostCategoryStateNotifier extends StateNotifier<List<CategoryModel>> {
  final PostRepository postRepository;

  PostCategoryStateNotifier({required this.postRepository}) : super([]) {
    fetchCategories();
  }
  fetchCategories() async {
    final resp = await postRepository.fetchCategories();

    state = resp;
  }
}
