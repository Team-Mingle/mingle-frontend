import 'package:mingle/common/const/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchHistoryService {
  static SearchHistoryService? _instance;
  static late SharedPreferences _preferences;

  SearchHistoryService._();

  // Using a singleton pattern
  static Future<SearchHistoryService> getInstance() async {
    _instance ??= SearchHistoryService._();

    _preferences = await SharedPreferences.getInstance();

    return _instance!;
  }

  List<String>? getHistories() {
    print("histories: ${_preferences.getStringList(HISTORY_KEY)}");
    return _preferences.getStringList(HISTORY_KEY);
  }

  void addHistory(String search) {
    print("serach: $search");
    List<String> histories = _preferences.getStringList(HISTORY_KEY) ?? [];
    if (histories.contains(search)) {
      histories.remove(search);
    }
    if (histories.length >= 3) {
      histories.removeAt(2);
    }
    histories.insert(0, search);
    _preferences.setStringList(HISTORY_KEY, histories);
  }

  void clearHistories() {
    _preferences.remove(HISTORY_KEY);
  }

  void removeHistoryAt(int index) {
    List<String> histories = _preferences.getStringList(HISTORY_KEY) ?? [];
    histories.removeAt(index);
    _preferences.setStringList(HISTORY_KEY, histories);
  }
}
