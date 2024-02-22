import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/model/cursor_pagination_model.dart';
import 'package:mingle/common/model/pagination_params.dart';
import 'package:mingle/post/models/category_model.dart';
import 'package:mingle/post/models/post_model.dart';
import 'package:mingle/post/provider/post_provider.dart';
import 'package:mingle/post/repository/post_repository.dart';
import 'package:mingle/second_hand_market/model/second_hand_market_post_model.dart';
import 'package:mingle/second_hand_market/provider/second_hand_market_post_provider.dart';
import 'package:mingle/second_hand_market/repository/second_hand_market_post_repository.dart';
import 'package:mingle/user/repository/member_repository.dart';
import 'package:retrofit/retrofit.dart';
import 'package:collection/collection.dart';

final totalScrappedPostProvider =
    StateNotifierProvider<MemberPostStateNotifier, CursorPaginationBase>((ref) {
  final postRepository = ref.watch(postRepositoryProvider);
  final memberRepository = ref.watch(memberRepositoryProvider);

  final notifier = TotalScrappedPostStateNotifier(
      postRepository: postRepository, memberRepository: memberRepository);

  return notifier;
});

final totalMyPostProvider =
    StateNotifierProvider<MemberPostStateNotifier, CursorPaginationBase>((ref) {
  final postRepository = ref.watch(postRepositoryProvider);
  final memberRepository = ref.watch(memberRepositoryProvider);

  final notifier = TotalMyPostStateNotifier(
      postRepository: postRepository, memberRepository: memberRepository);

  return notifier;
});

final totalLikedPostProvider =
    StateNotifierProvider<MemberPostStateNotifier, CursorPaginationBase>((ref) {
  final postRepository = ref.watch(postRepositoryProvider);
  final memberRepository = ref.watch(memberRepositoryProvider);

  final notifier = TotalLikedPostStateNotifier(
      postRepository: postRepository, memberRepository: memberRepository);

  return notifier;
});

final totalCommentedPostProvider =
    StateNotifierProvider<MemberPostStateNotifier, CursorPaginationBase>((ref) {
  final postRepository = ref.watch(postRepositoryProvider);
  final memberRepository = ref.watch(memberRepositoryProvider);

  final notifier = TotalCommentedPostStateNotifier(
      postRepository: postRepository, memberRepository: memberRepository);

  return notifier;
});

final totalScrappedPostDetailProvider =
    Provider.family<PostModel?, int>((ref, id) {
  final state = ref.watch(totalScrappedPostProvider);

  if (state is! CursorPagination) {
    return null;
  }

  return state.data.firstWhereOrNull((e) => e.postId == id);
});

final totalMyPostDetailProvider = Provider.family<PostModel?, int>((ref, id) {
  final state = ref.watch(totalMyPostProvider);

  if (state is! CursorPagination) {
    return null;
  }

  return state.data.firstWhereOrNull((e) => e.postId == id);
});

final totalLikedPostDetailProvider =
    Provider.family<PostModel?, int>((ref, id) {
  final state = ref.watch(totalLikedPostProvider);

  if (state is! CursorPagination) {
    return null;
  }

  return state.data.firstWhereOrNull((e) => e.postId == id);
});

final totalCommentedPostDetailProvider =
    Provider.family<PostModel?, int>((ref, id) {
  final state = ref.watch(totalCommentedPostProvider);

  if (state is! CursorPagination) {
    return null;
  }

  return state.data.firstWhereOrNull((e) => e.postId == id);
});

final univScrappedPostProvider =
    StateNotifierProvider<MemberPostStateNotifier, CursorPaginationBase>((ref) {
  final postRepository = ref.watch(postRepositoryProvider);
  final memberRepository = ref.watch(memberRepositoryProvider);

  final notifier = UnivScrappedPostStateNotifier(
      postRepository: postRepository, memberRepository: memberRepository);

  return notifier;
});

final univMyPostProvider =
    StateNotifierProvider<MemberPostStateNotifier, CursorPaginationBase>((ref) {
  final postRepository = ref.watch(postRepositoryProvider);
  final memberRepository = ref.watch(memberRepositoryProvider);

  final notifier = UnivMyPostStateNotifier(
      postRepository: postRepository, memberRepository: memberRepository);

  return notifier;
});

final univLikedPostProvider =
    StateNotifierProvider<MemberPostStateNotifier, CursorPaginationBase>((ref) {
  final postRepository = ref.watch(postRepositoryProvider);
  final memberRepository = ref.watch(memberRepositoryProvider);

  final notifier = UnivLikedPostStateNotifier(
      postRepository: postRepository, memberRepository: memberRepository);

  return notifier;
});

final univCommentedPostProvider =
    StateNotifierProvider<MemberPostStateNotifier, CursorPaginationBase>((ref) {
  final postRepository = ref.watch(postRepositoryProvider);
  final memberRepository = ref.watch(memberRepositoryProvider);

  final notifier = UnivCommentedPostStateNotifier(
      postRepository: postRepository, memberRepository: memberRepository);

  return notifier;
});

final univScrappedPostDetailProvider =
    Provider.family<PostModel?, int>((ref, id) {
  final state = ref.watch(univScrappedPostProvider);

  if (state is! CursorPagination) {
    return null;
  }

  return state.data.firstWhereOrNull((e) => e.postId == id);
});

final univMyPostDetailProvider = Provider.family<PostModel?, int>((ref, id) {
  final state = ref.watch(univMyPostProvider);

  if (state is! CursorPagination) {
    return null;
  }

  return state.data.firstWhereOrNull((e) => e.postId == id);
});

final univLikedPostDetailProvider = Provider.family<PostModel?, int>((ref, id) {
  final state = ref.watch(univLikedPostProvider);

  if (state is! CursorPagination) {
    return null;
  }

  return state.data.firstWhereOrNull((e) => e.postId == id);
});

final univCommentedPostDetailProvider =
    Provider.family<PostModel?, int>((ref, id) {
  final state = ref.watch(univCommentedPostProvider);

  if (state is! CursorPagination) {
    return null;
  }

  return state.data.firstWhereOrNull((e) => e.postId == id);
});

final itemMyPostProvider =
    StateNotifierProvider<MemberPostStateNotifier, CursorPaginationBase>((ref) {
  final postRepository = ref.watch(postRepositoryProvider);
  final memberRepository = ref.watch(memberRepositoryProvider);

  final notifier = ItemMyPostStateNotifier(
      postRepository: postRepository, memberRepository: memberRepository);

  return notifier;
});

final itemLikedPostProvider =
    StateNotifierProvider<MemberPostStateNotifier, CursorPaginationBase>((ref) {
  final postRepository = ref.watch(postRepositoryProvider);
  final memberRepository = ref.watch(memberRepositoryProvider);

  final notifier = ItemLikedPostStateNotifier(
      postRepository: postRepository, memberRepository: memberRepository);

  return notifier;
});

final itemCommentedPostProvider =
    StateNotifierProvider<MemberPostStateNotifier, CursorPaginationBase>((ref) {
  final postRepository = ref.watch(postRepositoryProvider);
  final memberRepository = ref.watch(memberRepositoryProvider);

  final notifier = ItemCommentedPostStateNotifier(
      postRepository: postRepository, memberRepository: memberRepository);

  return notifier;
});

final itemMyPostDetailProvider = Provider.family<PostModel?, int>((ref, id) {
  final state = ref.watch(itemMyPostProvider);

  if (state is! CursorPagination) {
    return null;
  }

  return state.data.firstWhereOrNull((e) => e.postId == id);
});

final itemLikedPostDetailProvider = Provider.family<PostModel?, int>((ref, id) {
  final state = ref.watch(itemLikedPostProvider);

  if (state is! CursorPagination) {
    return null;
  }

  return state.data.firstWhereOrNull((e) => e.postId == id);
});

final itemCommentedPostDetailProvider =
    Provider.family<PostModel?, int>((ref, id) {
  final state = ref.watch(itemCommentedPostProvider);

  if (state is! CursorPagination) {
    return null;
  }

  return state.data.firstWhereOrNull((e) => e.postId == id);
});

class MemberPostStateNotifier extends PostStateNotifier

// StateNotifier<CursorPaginationBase>
{
  final MemberRepository memberRepository;
  @override
  final PostRepository postRepository;
  @override
  final String boardType;
  final String postType;
  MemberPostStateNotifier({
    required this.memberRepository,
    required this.postRepository,
    required this.boardType,
    required this.postType,
  }) : super(
            postRepository: postRepository,
            boardType: 'UNIV',
            categoryType: '');
  // paginate() async {
  //   final resp = await postRepository.paginate(
  //       boardType: boardType, categoryType: categoryType);

  //   state = resp.data;
  // }

  @override
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

      switch (postType) {
        case 'scraps':
          resp = await memberRepository.getScrappedPosts(
              boardType: boardType, paginationParams: paginationParams);
        case 'posts':
          resp = await memberRepository.getMyPosts(
              boardType: boardType, paginationParams: paginationParams);
        case 'likes':
          resp = await memberRepository.getMyLikedPosts(
              boardType: boardType, paginationParams: paginationParams);
        case 'comments':
          resp = await memberRepository.getMyCommentedPosts(
              boardType: boardType, paginationParams: paginationParams);
        default:
          resp = await memberRepository.getScrappedPosts(
              boardType: boardType, paginationParams: paginationParams);
      }

      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore;
        print("pstate: ${pState.data.length}");
        print("resp: ${resp.data.length}");
        print("page: ${paginationParams.page}");
        print("size: ${paginationParams.size}");
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

  @override
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

  @override
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

  @override
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

class TotalScrappedPostStateNotifier extends MemberPostStateNotifier {
  @override
  final PostRepository postRepository;
  @override
  final MemberRepository memberRepository;

  TotalScrappedPostStateNotifier(
      {required this.postRepository, required this.memberRepository})
      : super(
            memberRepository: memberRepository,
            postRepository: postRepository,
            boardType: 'TOTAL',
            postType: 'scraps');
}

class TotalMyPostStateNotifier extends MemberPostStateNotifier {
  @override
  final PostRepository postRepository;
  @override
  final MemberRepository memberRepository;

  TotalMyPostStateNotifier(
      {required this.postRepository, required this.memberRepository})
      : super(
            memberRepository: memberRepository,
            postRepository: postRepository,
            boardType: 'TOTAL',
            postType: 'posts');
}

class TotalLikedPostStateNotifier extends MemberPostStateNotifier {
  @override
  final PostRepository postRepository;
  @override
  final MemberRepository memberRepository;

  TotalLikedPostStateNotifier(
      {required this.postRepository, required this.memberRepository})
      : super(
            memberRepository: memberRepository,
            postRepository: postRepository,
            boardType: 'TOTAL',
            postType: 'likes');
}

class TotalCommentedPostStateNotifier extends MemberPostStateNotifier {
  @override
  final PostRepository postRepository;
  @override
  final MemberRepository memberRepository;

  TotalCommentedPostStateNotifier(
      {required this.postRepository, required this.memberRepository})
      : super(
            memberRepository: memberRepository,
            postRepository: postRepository,
            boardType: 'TOTAL',
            postType: 'comments');
}

class UnivScrappedPostStateNotifier extends MemberPostStateNotifier {
  @override
  final PostRepository postRepository;
  @override
  final MemberRepository memberRepository;

  UnivScrappedPostStateNotifier(
      {required this.postRepository, required this.memberRepository})
      : super(
            memberRepository: memberRepository,
            postRepository: postRepository,
            boardType: 'UNIV',
            postType: 'scraps');
}

class UnivMyPostStateNotifier extends MemberPostStateNotifier {
  @override
  final PostRepository postRepository;
  @override
  final MemberRepository memberRepository;

  UnivMyPostStateNotifier(
      {required this.postRepository, required this.memberRepository})
      : super(
            memberRepository: memberRepository,
            postRepository: postRepository,
            boardType: 'UNIV',
            postType: 'posts');
}

class UnivLikedPostStateNotifier extends MemberPostStateNotifier {
  @override
  final PostRepository postRepository;
  @override
  final MemberRepository memberRepository;

  UnivLikedPostStateNotifier(
      {required this.postRepository, required this.memberRepository})
      : super(
            memberRepository: memberRepository,
            postRepository: postRepository,
            boardType: 'UNIV',
            postType: 'likes');
}

class UnivCommentedPostStateNotifier extends MemberPostStateNotifier {
  @override
  final PostRepository postRepository;
  @override
  final MemberRepository memberRepository;

  UnivCommentedPostStateNotifier(
      {required this.postRepository, required this.memberRepository})
      : super(
            memberRepository: memberRepository,
            postRepository: postRepository,
            boardType: 'UNIV',
            postType: 'comments');
}

class ItemMyPostStateNotifier extends MemberPostStateNotifier {
  @override
  final PostRepository postRepository;
  @override
  final MemberRepository memberRepository;

  ItemMyPostStateNotifier(
      {required this.postRepository, required this.memberRepository})
      : super(
            memberRepository: memberRepository,
            postRepository: postRepository,
            boardType: 'ITEM',
            postType: 'posts');
}

class ItemLikedPostStateNotifier extends MemberPostStateNotifier {
  @override
  final PostRepository postRepository;
  @override
  final MemberRepository memberRepository;

  ItemLikedPostStateNotifier(
      {required this.postRepository, required this.memberRepository})
      : super(
            memberRepository: memberRepository,
            postRepository: postRepository,
            boardType: 'ITEM',
            postType: 'likes');
}

class ItemCommentedPostStateNotifier extends MemberPostStateNotifier {
  @override
  final PostRepository postRepository;
  @override
  final MemberRepository memberRepository;

  ItemCommentedPostStateNotifier(
      {required this.postRepository, required this.memberRepository})
      : super(
            memberRepository: memberRepository,
            postRepository: postRepository,
            boardType: 'ITEM',
            postType: 'comments');
}

class MemberSecondHandPostStateNotifier extends SecondHandPostStateNotifier {
  final MemberRepository memberRepository;
  MemberSecondHandPostStateNotifier(
      {required super.secondHandPostRepository,
      required this.memberRepository});
  @override
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

      final resp = await memberRepository.getMyLikedSecondHandPosts(
          boardType: "ITEM", paginationParams: paginationParams);

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
}

class LikedSecondHandPostStateNotifier
    extends MemberSecondHandPostStateNotifier {
  LikedSecondHandPostStateNotifier(
      {required super.secondHandPostRepository,
      required super.memberRepository});
}

final likedSecondHandPostProvider = StateNotifierProvider<
    LikedSecondHandPostStateNotifier, CursorPaginationBase>((ref) {
  final secondHandPostRepository = ref.watch(secondHandPostRepositoryProvider);
  final memberRepository = ref.watch(memberRepositoryProvider);

  final notifier = LikedSecondHandPostStateNotifier(
      secondHandPostRepository: secondHandPostRepository,
      memberRepository: memberRepository);

  return notifier;
});

final likedSecondHandPostDetailProvider =
    Provider.family<SecondHandMarketPostModel?, int>((ref, id) {
  final state = ref.watch(likedSecondHandPostProvider);

  if (state is! CursorPagination) {
    return null;
  }

  return state.data.firstWhereOrNull((e) => e.id == id);
});
