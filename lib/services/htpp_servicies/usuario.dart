import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:io';
import '../../utils/userSimplePreferences.dart';
import 'httpService.dart';


class usuario_http extends http_request{
  userPreferences  UserPreferences = userPreferences();
  late String token;

  Future<Map<String, dynamic>> edit_usuario(String nombre, String apellidos, String clave, String genero, String fecha_nacimeinto, String foto_perfil, String confirmPassword) async {
    token = (await UserPreferences.getToken())!;
    String url = super.apiURL+"usuario.php?metodo=PATCH";
    http.Response response;
  print("f");
    try{
      Map data = {
        "nombre": nombre,
        "apellidos": apellidos,
        "clave":clave,
        "genero" : genero,
        "fecha_nacimiento" :fecha_nacimeinto,
        "foto_perfil" : foto_perfil,
        "claveConfirm" : confirmPassword
      };
      var body = json.encode(data);
      response =
      await http.post(Uri.parse(url), headers:{HttpHeaders.authorizationHeader: token,
        HttpHeaders.contentTypeHeader : "application/json"}, body: body).timeout(const Duration(seconds: 60));
      print(json.decode(response.body));
      if(response.statusCode==201){
        var datos = json.decode(response.body);
        return datos;
      }
      else
      {
        var datos = json.decode(response.body);
        return {'error' : datos['message'],
          'code' : datos['code']};
      }
    }
    on TimeoutException catch (e){
      return {'error' : "Time out"};
    }
    on Exception catch (e){
      print("Error :"+e.toString());
      return {'error' : e.toString()};
    }
  }


  Future<Map<String, dynamic>> delete_usuario(String clave) async {
    token = (await UserPreferences.getToken())!;
    String url = super.apiURL+"usuario.php?metodo=DELETE";
    http.Response response;
    print("f");
    try{
      Map data = {
        "claveConfirm":clave
      };
      var body = json.encode(data);
      response =
      await http.post(Uri.parse(url), headers:{HttpHeaders.authorizationHeader: token,
        HttpHeaders.contentTypeHeader : "application/json"}, body: body).timeout(const Duration(seconds: 60));
      print(json.decode(response.body));
      if(response.statusCode==201){
        var datos = json.decode(response.body);
        return datos;
      }
      else
      {
        var datos = json.decode(response.body);
        return {'error' : datos['message'],
          'code' : datos['code']};
      }
    }
    on TimeoutException catch (e){
      return {'error' : "Time out"};
    }
    on Exception catch (e){
      print("Error :"+e.toString());
      return {'error' : e.toString()};
    }
  }


  Future<Map<String, dynamic>> get_usuario() async {
    token = (await UserPreferences.getToken())!;
    String url = super.apiURL+"usuario.php";
    http.Response response;
    try{
      response =
      await http.get(Uri.parse(url), headers:{HttpHeaders.authorizationHeader: token,
        HttpHeaders.contentTypeHeader : "application/json"}).timeout(const Duration(seconds: 60));
      print(json.decode(response.body));
      if(response.statusCode==201){
        var datos = json.decode(response.body);
        return datos;
      }
      else
      {
        var datos = json.decode(response.body);
        return {'error' : datos['message'],
          'code' : datos['code']};
      }
    }
    on TimeoutException catch (e){
      return {'error' : "Time out"};
    }
    on Exception catch (e){
      return {'error' : e.toString()};
    }
  }


  Future<Map<String, dynamic>> subir_foto(img) async {
    token = (await UserPreferences.getToken())!;
    String url = "https://sceii.000webhostapp.com/api-sceii/v1/public/subirImagen.php";
    Map data = {
      "imagen": img,
    };
    var body = json.encode(data);
    http.Response response;
    try{
      response =
      await http.post(Uri.parse(url), headers:{HttpHeaders.authorizationHeader: token,
        HttpHeaders.contentTypeHeader : "application/json"}, body:body).timeout(const Duration(seconds: 60));
      print(json.decode(response.body));
      if(response.statusCode==201){
        var datos = json.decode(response.body);
        return datos;
      }
      else
      {
        var datos = json.decode(response.body);
        return {'error' : datos['message'],
          'code' : datos['code']};
      }
    }
    on TimeoutException catch (e){
      return {'error' : "Time out"};
    }
    on Exception catch (e){
      return {'error' : e.toString()};
    }
  }
}