import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mingle/common/const/colors.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/module/components/toast_message_card.dart';
import 'package:mingle/timetable/components/add_new_timetable_widget.dart';
import 'package:mingle/timetable/components/timetable_list_container.dart';
import 'package:mingle/timetable/model/timetable_list_model.dart';
import 'package:mingle/timetable/model/timetable_preview_model.dart';
import 'package:mingle/timetable/provider/pinned_timetable_provider.dart';
import 'package:mingle/timetable/repository/timetable_repository.dart';
import 'package:mingle/timetable/view/self_add_timetable_screen.dart';

class TimeTableListScreen extends ConsumerStatefulWidget {
  final bool isAddTimetable;
  final Function changeTimetableName;
  final Function deleteTimetable;
  const TimeTableListScreen({
    Key? key,
    this.isAddTimetable = false,
    required this.changeTimetableName,
    required this.deleteTimetable,
  }) : super(key: key);

  @override
  ConsumerState<TimeTableListScreen> createState() =>
      _MyTimeTableListScreenState();
}

class _MyTimeTableListScreenState extends ConsumerState<TimeTableListScreen> {
  Map<String, List<TimetablePreviewModel>> timetables = {};
  bool isLoading = false;
  late FToast fToast;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    fToast = FToast();
    fToast.init(context);
    setState(() {
      isLoading = true;
    });
    getTimetables();
    print(timetables);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.isAddTimetable) {
        showDialog(
          context: context,
          builder: (_) {
            return Center(
              child: AddNewTimetableWidget(
                  refreshTimetableList: getTimetables,
                  addTimetable: addTimetable),
            );
          },
        );
      }
    });
  }

  void addTimetable(String selectedSemester) async {
    try {
      final year = int.parse(selectedSemester.substring(0, 4));
      final semester = int.parse(selectedSemester.substring(6, 7));

      await ref.watch(timetableRepositoryProvider).addTimetable(
          addTimetableDto: AddTimetableDto(year: year, semester: semester));
      ref.read(pinnedTimetableIdProvider.notifier).fetchPinnedTimetable();
      getTimetables();
    } on DioException catch (e) {
      fToast.showToast(
        child: const ToastMessage(message: generalErrorMsg),
        gravity: ToastGravity.CENTER,
        toastDuration: const Duration(seconds: 2),
      );
    }
  }

  void pinTimetable(List<TimetablePreviewModel> timetableList,
      TimetablePreviewModel timetableToBePinned) {
    setState(() {
      timetableList.firstWhere((timetable) => timetable.isPinned).isPinned =
          false;
      timetableList
          .firstWhere((timetable) =>
              timetable.timetableId == timetableToBePinned.timetableId)
          .isPinned = true;
    });
  }

  void getTimetables() async {
    final result = (await ref.read(timetableRepositoryProvider).getTimetables())
        .timetablePreviewResponseMap;
    if (mounted) {
      setState(() {
        timetables = result;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            automaticallyImplyLeading: false,
            titleSpacing: 0.0,
            leading: Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: SvgPicture.asset(
                  "assets/img/post_screen/cross_icon.svg",
                ),
              ),
            ),
            title: const Text(
              '시간표 목록',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                letterSpacing: -0.02,
                height: 1.5,
                fontWeight: FontWeight.w400,
              ),
            ),
            actions: [
              InkWell(
                child: const Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Text(
                    "시간표 추가",
                    style: TextStyle(
                      color: PRIMARY_COLOR_ORANGE_01,
                      fontSize: 14.0,
                      letterSpacing: -0.01,
                      height: 1.4,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return Center(
                        child: AddNewTimetableWidget(
                          addTimetable: addTimetable,
                          refreshTimetableList: getTimetables,
                        ),
                      );
                    },
                  );
                },
              ),
            ],
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: PRIMARY_COLOR_ORANGE_01,
                  ),
                )
              : SingleChildScrollView(
                  // physics: const AlwaysScrollableScrollPhysics(),
                  child: Center(
                    child: Column(
                        children:
                            List.generate(timetables.keys.length, (index) {
                      final String key = timetables.keys.elementAt(index);
                      final List<TimetablePreviewModel> values =
                          timetables[key]!;
                      return Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 32),
                              Row(
                                children: [
                                  Text(
                                    TimetableListModel.convertKeyToSemester(
                                        key),
                                    style: const TextStyle(
                                      color: GRAYSCALE_GRAY_03,
                                      fontSize: 16.0,
                                      letterSpacing: -0.02,
                                      height: 1.5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              ...List.generate(
                                  values.length,
                                  (index) => TimetableListWidget(
                                      changeTimetableName:
                                          (String newTimetableName) {
                                        setState(() {
                                          values[index].name = newTimetableName;
                                        });
                                        widget.changeTimetableName(
                                            newTimetableName);
                                      },
                                      deleteTimetable: (int timetableId) async {
                                        setState(() {
                                          values.removeAt(index);
                                        });
                                        await widget
                                            .deleteTimetable(timetableId);
                                        getTimetables();
                                      },
                                      pinTimetable: (TimetablePreviewModel
                                              timetableToBePinned) =>
                                          pinTimetable(
                                              values, timetableToBePinned),
                                      timetables: values,
                                      timetablePreviewModel: values[index]))
                            ],
                          ),
                        ),
                      );
                    })
                        // [
                        //   TimetableList(),
                        //   SizedBox(
                        //     height: 56.0,
                        //   ),
                        //   TimetableList(),
                        //   SizedBox(
                        //     height: 56.0,
                        //   ),
                        //   TimetableList(),
                        //   SizedBox(
                        //     height: 56.0,
                        //   ),
                        // ],
                        ),
                  ),
                ),
        ),
      ),
    );
  }
}
