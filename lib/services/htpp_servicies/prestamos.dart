import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import '../../utils/userSimplePreferences.dart';
import 'httpService.dart';



class prestamos_http extends http_request{
  userPreferences  UserPreferences = userPreferences();
  String token ="";
  Future<Map<String, dynamic>> index_prestamos_usuario() async {
    token = (await UserPreferences.getToken())!;
    String url = super.apiURL+"prestamos.php?tipo=usuario";
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

  Future<Map<String, dynamic>> get_one_prestamo(String id) async {
    String url = super.apiURL+"prestamos.php?id_prestamo="+id;
    http.Response response;
    try{
      response =
      await http.get(Uri.parse(url)).timeout(const Duration(seconds: 60));
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