import 'package:flutter/material.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/shared_perference.dart';

class ThemeProvider with ChangeNotifier{
  final darkTheme = ThemeData(
    highlightColor: Color(0xFF313639),
    hintColor: Colors.grey,
    brightness: Brightness.dark,
    primaryColor: accent_color,
    cardColor:Color(0xFF313639),
    backgroundColor: Colors.black,
    canvasColor: Color(0xFF38464c),
    shadowColor: Color(0xFF313639) ,
    accentColor: Colors.white,
    unselectedWidgetColor: Colors.white,
    disabledColor: Colors.blue,
    focusColor:  Color(0xFF5A5E61),
    bottomAppBarColor: Color(0xFF313639),
    dividerColor: Colors.white70,
  );
  final lightTheme = ThemeData(
    hintColor: Colors.white54,
    focusColor: Colors.grey[200],
    cardColor:Colors.grey[200],
    canvasColor: Color(0xFFFEDBD0),
    primaryColor: accent_color,
    brightness: Brightness.light,
    unselectedWidgetColor: Colors.black,
    disabledColor: Colors.blue,
    bottomAppBarColor: Colors.white,
    highlightColor: Color(0xFF000000),
    backgroundColor:Color(0xFFFEFDFD),
    accentColor: Colors.black,
    dividerColor: Colors.black12,
  );

  ThemeData _themeData;
  ThemeProvider.initialize(){
    BasePrefs.init();
  }

  ThemeNotifier() {
    BasePrefs.readData(app_Theme).then((value) {
      print('value read from storage: ' + value.toString());
      var themeMode = value ?? dark_Mode;
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

  ThemeData getTheme(){

    if(BasePrefs!=null && BasePrefs.getString(app_Theme)!=null && BasePrefs.getString(app_Theme)== dark_Mode){
      return darkTheme;
    }else{
      return lightTheme;
    }
  }
}