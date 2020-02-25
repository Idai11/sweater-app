import 'package:shared_preferences/shared_preferences.dart';

class LocalSave {
  static Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  static Future<String> getString(String key) async {
    return (await _getPrefs()).getString(key);
  }

  static void setString(String key, String value) async {
    SharedPreferences prefs = await _getPrefs();
    await prefs.setString(key, value);
  }

  static Future<int> getInt(String key) async {
    return (await _getPrefs()).getInt(key);
  }

  static void setInt(String key, int value) async {
    SharedPreferences prefs = await _getPrefs();
    await prefs.setInt(key, value);
  }
}