import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Pref {
  Future<bool> saveString(String key, String value);

  Future<String> getString(String key);
}

class LocalPref extends Pref {
  static LocalPref shared = LocalPref();

  @override
  Future<bool> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  @override
  Future<String> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> removeKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}

class PrefKey {
  static const String accessToken = 'access_token';
}
