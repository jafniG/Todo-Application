import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  static const _storageKey = 'user_prefs';
  static Future<bool> saveUserData(bool value) async {
    final instance = await SharedPreferences.getInstance();
    return instance.setBool(_storageKey, value);
  }

  static Future<bool?> getUserData() async {
    final instance = await SharedPreferences.getInstance();
    return instance.getBool(_storageKey);
  }

  static Future<bool> clearUserData() async {
    final instance = await SharedPreferences.getInstance();
    return instance.remove(_storageKey);
  }

  static Future<bool> checkExistingUser() async {
    await Future.delayed(Duration(seconds: 3));
    final val = await getUserData();
    if (val == null) return false;
    return val;
  }
}
