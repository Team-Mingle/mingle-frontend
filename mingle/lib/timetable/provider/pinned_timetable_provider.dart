import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/model/cursor_pagination_model.dart';
import 'package:mingle/timetable/model/default_timetable_id_model.dart';
import 'package:mingle/timetable/model/timetable_model.dart';
import 'package:mingle/timetable/provider/pinned_timetable_id_provider.dart';
import 'package:mingle/timetable/repository/timetable_repository.dart';

class PinnedTimetableStateNotifier extends StateNotifier<TimetableModel?> {
  final TimetableRepository timetableRepository;
  final int? pinnedTimetableId;
  PinnedTimetableStateNotifier(
      {required this.timetableRepository, this.pinnedTimetableId})
      : super(null) {
    fetchPinnedTimetable();
  }
  Future<void> fetchPinnedTimetable() async {
    try {
      TimetableModel? pinnedTimetable = pinnedTimetableId == null
          ? null
          : await timetableRepository.getTimetable(
              timetableId: pinnedTimetableId!);
      state = pinnedTimetable;
    } on DioException catch (e) {
      state = null;
    }
  }
}

final pinnedTimetableProvider =
    StateNotifierProvider<PinnedTimetableStateNotifier, TimetableModel?>((ref) {
  final repository = ref.watch(timetableRepositoryProvider);
  final int? pinnedTimetableId = ref.watch(pinnedTimetableIdProvider);

  final notifier = PinnedTimetableStateNotifier(
      timetableRepository: repository, pinnedTimetableId: pinnedTimetableId);

  return notifier;
});
