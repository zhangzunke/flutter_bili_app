import 'package:shared_preferences/shared_preferences.dart';

class HiCache {
  static final HiCache _instance = HiCache._internal();
  late SharedPreferences prefs;

  HiCache._internal();

  static Future<HiCache> getInstance() async {
    _instance.prefs = await SharedPreferences.getInstance();
    return _instance;
  }

  setString(String key, String value) {
    prefs.setString(key, value);
  }

  setDouble(String key, double value) {
    prefs.setDouble(key, value);
  }

  setInt(String key, int value) {
    prefs.setInt(key, value);
  }

  setBool(String key, bool value) {
    prefs.setBool(key, value);
  }

  setListString(String key, List<String> value) {
    prefs.setStringList(key, value);
  }

  T? get<T>(String key, {T? defaultValue}) {
    var value = prefs.get(key);
    if (value is T) {
      return value;
    }
    return defaultValue;
  }
}
