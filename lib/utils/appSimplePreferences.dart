import 'dart:convert';
import 'dart:typed_data';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class appPreferences{

  Future<void> bienvenida()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('bienvenida', true);
  }

  Future<bool?> getbienvenida()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(preferences.containsKey('bienvenida'))
      return await preferences.getBool('bienvenida');
    else false;
  }


  Future<void> setTheme(bool theme)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('theme', theme); //true=> oscuro, false =>claro
  }

  Future<bool?> getTheme()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(preferences.containsKey('theme')){
      print("fd");
      return await preferences.getBool('theme');
    }
    else true;
  }






}