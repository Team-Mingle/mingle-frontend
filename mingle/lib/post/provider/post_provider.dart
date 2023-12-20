import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/post/models/category_model.dart';
import 'package:mingle/post/models/post_model.dart';
import 'package:mingle/post/repository/post_repository.dart';

final totalAllPostProvider =
    StateNotifierProvider<PostStateNotifier, List<PostModel>>((ref) {
  final repository = ref.watch(postRepositoryProvider);

  final notifier = TotalAllPostStateNotifier(postRepository: repository);

  return notifier;
});

final totalFreePostProvider =
    StateNotifierProvider<PostStateNotifier, List<PostModel>>((ref) {
  final repository = ref.watch(postRepositoryProvider);

  final notifier = TotalFreePostStateNotifier(postRepository: repository);

  return notifier;
});

final totalQnAPostProvider =
    StateNotifierProvider<PostStateNotifier, List<PostModel>>((ref) {
  final repository = ref.watch(postRepositoryProvider);

  final notifier = TotalQnAPostStateNotifier(postRepository: repository);

  return notifier;
});

final totalMinglePostProvider =
    StateNotifierProvider<PostStateNotifier, List<PostModel>>((ref) {
  final repository = ref.watch(postRepositoryProvider);

  final notifier = TotalMinglePostStateNotifier(postRepository: repository);

  return notifier;
});

final univAllPostProvider =
    StateNotifierProvider<PostStateNotifier, List<PostModel>>((ref) {
  final repository = ref.watch(postRepositoryProvider);

  final notifier = UnivAllPostStateNotifier(postRepository: repository);

  return notifier;
});

final univFreePostProvider =
    StateNotifierProvider<PostStateNotifier, List<PostModel>>((ref) {
  final repository = ref.watch(postRepositoryProvider);

  final notifier = UnivFreePostStateNotifier(postRepository: repository);

  return notifier;
});

final univQnAPostProvider =
    StateNotifierProvider<PostStateNotifier, List<PostModel>>((ref) {
  final repository = ref.watch(postRepositoryProvider);

  final notifier = UnivQnAPostStateNotifier(postRepository: repository);

  return notifier;
});

final univKsaPostProvider =
    StateNotifierProvider<PostStateNotifier, List<PostModel>>((ref) {
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
    StateNotifierProvider<PostStateNotifier, List<PostModel>>((ref) {
  final repository = ref.watch(postRepositoryProvider);

  final notifier = TotalRecentPostStateNotifier(postRepository: repository);

  return notifier;
});

final univRecentPostProvider =
    StateNotifierProvider<PostStateNotifier, List<PostModel>>((ref) {
  final repository = ref.watch(postRepositoryProvider);

  final notifier = UnivRecentPostStateNotifier(postRepository: repository);

  return notifier;
});

class PostStateNotifier extends StateNotifier<List<PostModel>> {
  final PostRepository postRepository;
  final String boardType;
  final String categoryType;
  PostStateNotifier(
      {required this.postRepository,
      required this.boardType,
      required this.categoryType})
      : super([]) {
    paginate();
  }
  paginate() async {
    final resp = await postRepository.paginate(
        boardType: boardType, categoryType: categoryType);

    state = resp.data;
  }
}

class TotalAllPostStateNotifier extends PostStateNotifier {
  @override
  final PostRepository postRepository;
  TotalAllPostStateNotifier({required this.postRepository})
      : super(
            postRepository: postRepository,
            boardType: 'TOTAL',
            categoryType: 'FREE');
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
            categoryType: 'FREE');
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
