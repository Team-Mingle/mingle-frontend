import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/model/cursor_pagination_model.dart';
import 'package:mingle/timetable/model/default_timetable_id_model.dart';
import 'package:mingle/timetable/repository/timetable_repository.dart';

class PinnedTimetableIdStateNotifier extends StateNotifier<int?> {
  final TimetableRepository timetableRepository;
  PinnedTimetableIdStateNotifier({required this.timetableRepository})
      : super(null) {
    fetchPinnedTimetableId();
  }
  Future<void> fetchPinnedTimetableId() async {
    try {
      DefaultTimetableIdModel defaultTimetableIdModel =
          await timetableRepository.getDefaultTimetableId();

      state = defaultTimetableIdModel.defaultTimetableId;
      print(state);
    } on DioException catch (e) {
      state = null;
    }
  }
}

final pinnedTimetableIdProvider =
    StateNotifierProvider<PinnedTimetableIdStateNotifier, int?>((ref) {
  final repository = ref.watch(timetableRepositoryProvider);

  final notifier =
      PinnedTimetableIdStateNotifier(timetableRepository: repository);

  return notifier;
});
