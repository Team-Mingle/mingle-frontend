class ClassModel {
  final List<String> days;
  final List<String> startTimes;
  final List<String> endTimes;
  final String moduleCode;
  final String moduleName;
  final String location;
  final String profName;

  ClassModel(
      {required this.days,
      required this.startTimes,
      required this.endTimes,
      required this.moduleCode,
      required this.moduleName,
      required this.location,
      required this.profName});

  int convertDayToInt(String day) {
    switch (day) {
      case "월요일":
        return 0;
      case "화요일":
        return 1;
      case "수요일":
        return 2;
      case "목요일":
        return 3;
      case "금요일":
        return 4;
      case "토요일":
        return 5;
      case "일요일":
        return 6;
      default:
        return 0;
    }
  }

  List<int> convertTimeToIndex(String startTime) {
    List<int> result = [];
    var splitted = startTime.split(":");
    int hour = int.parse(splitted[0]);
    int minutes = int.parse(splitted[1]);
    int hourIndex = hour - 8;
    result.add(hourIndex);
    result.add(minutes);
    return result;
  }
}
