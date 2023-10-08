import 'package:shared_preferences/shared_preferences.dart';
class SharedPreferencesManager {


  static SharedPreferences? prefs;
  static Future<void> init() async {
    prefs ??= await SharedPreferences.getInstance();
  }

   static String? getString(String key)  {
    return  prefs!.getString(key);
  }

  static void setString(String key, String value) {
    prefs!.setString(key, value);
  }
  Future<void> clearUserSession() async {
    await prefs!.clear();
  }

}
