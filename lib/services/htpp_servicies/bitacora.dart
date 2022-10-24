import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/userSimplePreferences.dart';
import 'httpService.dart';


class bitacora_http extends http_request{
  userPreferences  UserPreferences = userPreferences();
  String token ="";

  Future<Map<String, dynamic>> registro(String id_laboratorio, String codigo_bitacora) async {
    token = (await UserPreferences.getToken())!;
    String url = super.apiURL+"bitacora.php";
    http.Response response;
    try{
      Map data = {
        "id_laboratorio": id_laboratorio,
        "codigo_bitacora": codigo_bitacora
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
      return {'error' : e.toString()};
    }
  }



}