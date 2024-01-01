class TimetableListPreview {
  final int timetableId;
  final String semester;
  final String name;
  final int orderNumber;
  final bool isPinned;

  TimetableListPreview({
    required this.timetableId,
    required this.semester,
    required this.name,
    required this.orderNumber,
    required this.isPinned,
  });

  factory TimetableListPreview.fromJson(Map<String, dynamic> json) {
    return TimetableListPreview(
      timetableId: json['timetableId'],
      semester: json['semester'],
      name: json['name'],
      orderNumber: json['orderNumber'],
      isPinned: json['isPinned'],
    );
  }
}

class TimetableListPreviewResponse {
  final Map<String, List<TimetableListPreview>> timetablePreviewResponseMap;

  TimetableListPreviewResponse({required this.timetablePreviewResponseMap});

  factory TimetableListPreviewResponse.fromJson(Map<String, dynamic> json) {
    Map<String, List<TimetableListPreview>> timetableMap = {};

    json['timetablePreviewResponseMap'].forEach((key, value) {
      List<TimetableListPreview> timetables = (value as List)
          .map((timetableJson) => TimetableListPreview.fromJson(timetableJson))
          .toList();
      timetableMap[key] = timetables;
    });

    return TimetableListPreviewResponse(
        timetablePreviewResponseMap: timetableMap);
  }
}
