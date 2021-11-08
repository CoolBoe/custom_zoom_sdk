import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BasePrefs {
  static FlutterSecureStorage storage = new FlutterSecureStorage();

  static Future<bool> setString(String key, dynamic value) async {
    bool status=false;
    storage.write(key: key, value: value.toString()).then((value) => status= true).
    onError((error, stackTrace) =>  status= false);
    return status;
  }

  static Future<dynamic> getString(String key) async {
    dynamic obj = storage.read(key: key);
    return obj;
  }

  static Future<void> clearPrefs() async {
    await storage.deleteAll();

  }
}