import 'package:json_annotation/json_annotation.dart';
import 'package:mingle/timetable/model/timetable_preview_model.dart';

part 'timetable_list_model.g.dart';

@JsonSerializable()
class TimetableListModel {
  final Map<String, List<TimetablePreviewModel>> timetablePreviewResponseMap;

  TimetableListModel({required this.timetablePreviewResponseMap});

  factory TimetableListModel.fromJson(Map<String, dynamic> json) =>
      _$TimetableListModelFromJson(json);

  static String convertKeyToSemester(String key) {
    //key format: FIRST_SEMESTER_2019
    List<String> splitted = key.split('_');
    String semester = "${getSemester(key)}학기";
    String year = "${getYear(key)}년";
    return "$year $semester";
  }

  static int getYear(String key) {
    List<String> splitted = key.split('_');
    int year = int.parse(splitted[2]);
    return year;
  }

  static int getSemester(String key) {
    List<String> splitted = key.split('_');
    int semester = splitted[0] == "FIRST" ? 1 : 2;
    return semester;
  }
}
