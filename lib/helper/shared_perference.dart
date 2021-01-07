import 'dart:convert';
import 'dart:ffi';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wooapp/models/user.dart';

class BasePrefs {
  static SharedPreferences _preferences;

  static Future<SharedPreferences> get _instance async =>
      _preferences ?? await SharedPreferences.getInstance();

  static Future<SharedPreferences> init() async {
    _preferences = await SharedPreferences.getInstance();

    return _preferences;
  }

  static void saveData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is int) {
      prefs.setInt(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else {
      print("Invalid Type");
    }
  }

  static Future<dynamic> readData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    dynamic obj = prefs.get(key);
    return obj;
  }

  static Future<bool> deleteData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }


  static String getString(String key, [String defValue]) {
    return _preferences.getString(key);
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs?.setString(key, value) ?? Future.value(false);
  }

  static Future<bool> clearPrefs() async {
    var prefs = await _instance;
    return prefs.clear();
  }
}

class UserPrefs {
  SharedPreferences _preferences;

  Future<SharedPreferences> get _instance async =>
      _preferences ?? await SharedPreferences.getInstance();

  Future<SharedPreferences> init() async {
    _preferences = await SharedPreferences.getInstance();

    return _preferences;
  }

  String getString(String key, [String defValue]) {
    return _preferences.getString(key);
  }

  Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs?.setString(key, value) ?? Future.value(false);
  }

  Future<bool> clearPrefs() async {
    var prefs = await _instance;
    return prefs.clear();
  }
}
