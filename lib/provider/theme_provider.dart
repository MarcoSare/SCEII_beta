
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/appSimplePreferences.dart';

class ThemeProvider extends ChangeNotifier{
  appPreferences app_preferences = appPreferences();
  late ThemeMode themeMode;
  
  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn){
    themeMode = isOn?ThemeMode.dark:ThemeMode.light;
    notifyListeners();
  }

  ThemeMode getThemeMode(bool theme) {
    if(theme==true)
      return themeMode = ThemeMode.dark;
    else return themeMode = ThemeMode.light;
  }

  init(bool theme) {
    if (theme!= null)
    themeMode = theme? ThemeMode.dark:ThemeMode.light;
    else
      themeMode = ThemeMode.dark;
    notifyListeners();
  }





}

class myThemes{

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Color.fromRGBO(19, 20, 20, 1),//o black78
    primaryColor: Color.fromRGBO(23, 32, 42, 1),
    accentColor: Color.fromRGBO(70, 165, 37, 1),
    primaryColorDark: Color.fromRGBO(70, 165, 37, 1),
    primaryColorLight: Colors.white,
    fontFamily: 'PopPins',
   errorColor: Color.fromRGBO(222, 23, 59, 1),


  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white, //Color.fromRGBO(222, 223, 215, 1)
    primaryColor: Color.fromRGBO(222, 223, 215, 1),
      accentColor: Color.fromRGBO(51, 115, 27, 1),
      primaryColorDark:Color.fromRGBO(51, 115, 27, 1) ,
      primaryColorLight: Colors.black,
      fontFamily: 'PopPins',
    errorColor: Color.fromRGBO(222, 23, 59, 1),
  );
}