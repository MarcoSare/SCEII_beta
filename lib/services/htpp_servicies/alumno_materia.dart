import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import '../../utils/userSimplePreferences.dart';
import 'httpService.dart';


class alumno_materia_http extends http_request{
  userPreferences  UserPreferences = userPreferences();
  late String token;
  Future<Map<String, dynamic>> index_alumno_materia() async {
    token = (await UserPreferences.getToken())!;
    String url = super.apiURL+"alumno_materia.php";
    http.Response response;

    try{

      response =
      await http.get(Uri.parse(url), headers:{HttpHeaders.authorizationHeader: token}).timeout(const Duration(seconds: 60));
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

  Future<Map<String, dynamic>> inscribir_materia(String codigo) async {
    token = (await UserPreferences.getToken())!;
    String url = super.apiURL+"alumno_materia.php";
    http.Response response;

    try{
      Map data = {
        "codigo": codigo
      };
      var body = json.encode(data);
      response =
      await http.post(Uri.parse(url), headers:{HttpHeaders.authorizationHeader: token, HttpHeaders.contentTypeHeader : "application/json"}, body: body).timeout(const Duration(seconds: 60));
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