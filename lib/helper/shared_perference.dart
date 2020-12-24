import 'dart:convert';
import 'dart:ffi';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wooapp/models/user.dart';

class BasePrefs {
  static SharedPreferences _preferences;


  static Future<SharedPreferences> get _instance async =>
      _preferences ?? await SharedPreferences.getInstance();

  static Future<SharedPreferences>init()async{

      _preferences=await SharedPreferences.getInstance();

      return _preferences;
  }
  static String getString(String key, [String defValue]) {

    return _preferences.getString(key);
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs?.setString(key, value) ?? Future.value(false);
  }
}
    //   }
//   static UserPrefs _prefs;
//
//   static const String UserKey = 'userPrefs';
//
//   static Future<UserPrefs>getInstance()async{
//     if(_prefs==null){
//       _prefs= UserPrefs();
//     }
//     if(_preferences==null){
//       _preferences=await SharedPreferences.getInstance();
//     }
//     return _prefs;
//   }
//   void addStringToSF(String key, String value)async{
//     _preferences.setString(key, value);
//   }
//   void addIntToSF(String key, int value)async{
//     _preferences.setInt(key, value);
//   }
//   void addDoubleToSF(String key, double value)async{
//     _preferences.setDouble(key, value);
//   }
//   void addBoolToSF(String key, bool value)async{
//     _preferences.setBool(key, value);
//   }
//   void addStringListToSF(String key, List<String> value)async{
//     _preferences.setStringList(key, value);
//   }
//
//   getStringToSF(String stringKey)async{
//     return _preferences.getString(stringKey).toString();
//   }
//   getIntToSF(String intKey)async{
//     _preferences= await SharedPreferences.getInstance();
//     return _preferences.getInt(intKey).toString();
//   }
//   getDoubleToSF(String doubleKey)async{
//     _preferences.getDouble(doubleKey).toString();
//   }
//   getBoolToSF(String boolKey)async{
//     _preferences= await SharedPreferences.getInstance();
//     _preferences.getBool(boolKey).toString();
//   }
//   getStringListToSF(String listKey)async{
//     _preferences= await SharedPreferences.getInstance();
//     _preferences.getStringList(listKey).toString();
//   }
// }
//
// class UserPrefs {
//
//   static const String AppLanguagesKey = 'languages';
//   static const String DarkModeKey = 'darkmode';
//
//   UserModel get user{
//     var userjson = getFromPrefs(BasePrefs.UserKey);
//     if(userjson==null)return null;
//     return UserModel.fromJson(jsonDecode(userjson));
//   }
//
//   set user(UserModel userToSave){
//     saveToPrefs(BasePrefs.UserKey, json.encode(userToSave.toJson()));
//   }
//
//   get darkMode => getFromPrefs(DarkModeKey);
//
//   set darkMode (bool value) => saveToPrefs(DarkModeKey, value.toString());
//
//  dynamic getFromPrefs(String userKey) {
//     var value =  BasePrefs._preferences.get(userKey);
//     print('(TRACE) SharedPreference:_getFromDisk. key: $userKey value: $value');
//     return value;
//  }
//
//   void saveToPrefs(String userKey, String content) {
//     print('(TRACE) SharedPreference:_saveStringToDisk. key: $userKey value: $content');
//     BasePrefs._preferences.setString(userKey, content);
//   }

