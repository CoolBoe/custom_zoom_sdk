import 'package:flutter/material.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/shared_perference.dart';

class ThemeProvider with ChangeNotifier{
  final darkTheme = ThemeData(
    hintColor: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: Colors.black,
    accentColor: Colors.white,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
    textTheme: TextTheme(
      headline1: TextStyle(fontFamily: fontName,fontSize: 8.0, fontWeight: semiBold),
      headline2: TextStyle(fontFamily: fontName,fontSize: 10.0, fontWeight: semiBold),
      headline3: TextStyle(fontFamily: fontName,fontSize: 12.0, fontWeight: semiBold),
      headline4: TextStyle(fontFamily: fontName,fontSize: 14.0, fontWeight: semiBold),
      headline5: TextStyle(fontFamily: fontName,fontSize: 16.0, fontWeight: semiBold),
      headline6: TextStyle(fontFamily: fontName,fontSize: 18.0, fontWeight: semiBold),
      bodyText1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
  );
  final lightTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
    accentColor: Colors.black,
    accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.white54,
  );
  ThemeData _themeData;
  ThemeData getTheme() => _themeData;

  ThemeNotifier() {
    BasePrefs.readData('themeMode').then((value) {
      print('value read from storage: ' + value.toString());
      var themeMode = value ?? 'light';
      if (themeMode == lightTheme) {
        _themeData = lightTheme;
      } else {
        print('setting dark theme');
        _themeData = darkTheme;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    BasePrefs.saveData(app_Theme, dark_Mode);
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    BasePrefs.saveData(app_Theme, light_Mode);
    notifyListeners();
  }
}