import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sceii/tools/codigo_materia.dart';
import '../../screens/model widget/openDialog.dart';
import 'httpService.dart';


class recuperacionCuenta_http extends http_request{
  late openDialogError alertError;

  Future<Map<String, dynamic>> getCodigoPass(String correo) async {
    String url = super.apiURL+"recuperacionCuenta.php?correo="+correo;
    http.Response response;
    try{
      response =
      await http.get(Uri.parse(url),headers: {"Content-Type": "application/json"});
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
    on Exception catch (e){
      return {'error' : e.toString()};
    }
  }

  Future<Map<String, dynamic>> getCodigoForgetPass(String correo, String codigo) async {
    String url = super.apiURL+"recuperacionCuenta.php";
    http.Response response;
    try{
      Map data = {
        "correo": correo,
        "codigo": codigo
      };
      var body = json.encode(data);
      response =
      await http.post(Uri.parse(url), body : body, headers: {"Content-Type": "application/json"});
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
    on Exception catch (e){
      return {'error' : e.toString()};
    }
  }

  Future<Map<String, dynamic>> cambiaPassword(String correo, String password) async {
    String url = super.apiURL+"recuperacionCuenta.php";
    http.Response response;
    try{
      Map data = {
        "correo": correo,
        "clave": password
      };
      var body = json.encode(data);
      response =
      await http.patch(Uri.parse(url), body : body, headers: {"Content-Type": "application/json"});
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
    on Exception catch (e){
      return {'error' : e.toString()};
    }
  }

}