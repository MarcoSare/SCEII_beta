import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'httpService.dart';


class login_http extends http_request{

  Future<Map<String, dynamic>> login(String correo, String clave) async {
    String url = super.apiURL+"login.php";
    http.Response response;
    try{
      Map data = {
        "correo": correo,
        "clave": clave
      };
      var body = json.encode(data);
      response =
      await http.post(Uri.parse(url), body : body, headers: {"Content-Type": "application/json"}).timeout(const Duration(seconds: 60));
      print(json.decode(response.body));
      if(response.statusCode==201){
        var datos = json.decode(response.body);
        print(datos);
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