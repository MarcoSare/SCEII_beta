import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/docente.dart';
import 'httpService.dart';
import '../../models/alumno.dart';
import '../../models/visitante.dart';

class register extends http_request{

  Future<Map<String, dynamic>> addAlumno(alumno a) async {
    print(a.nombre);
    String url = super.apiURL+"registro.php?tipo=alumno";
    Map data = {
      "nombre": a.nombre,
      "apellidos": a.apellidos,
      "clave" : a.password,
      "genero": a.genero,
      "no_control": a.noControl,
      "id_carrera": a.carrera,
      "correo": a.correo,
      "id_semestre": a.semestre,
      "fecha_nacimiento" : a.fecha_nac
    };
    var body = json.encode(data);
    http.Response response;
    try{
      response =
      await http.post(Uri.parse(url),  headers: {"Content-Type": "application/json"},
          body: body);
      var datos = json.decode(response.body);
      return datos;
    }
    on Exception catch (e){
      return {'Error' : e.toString()};
    }
  }


  Future<Map<String, dynamic>> addDocente(docente d) async {
    String url = super.apiURL+"registro.php?tipo=docente";
    Map data = {
      "nombre": d.nombre,
      "apellidos": d.apellidos,
      "clave" : d.password,
      "genero": d.genero,
      "correo": d.correo,
      "fecha_nacimiento" : d.fecha_nac
    };
    var body = json.encode(data);
    http.Response response;
    try{
      response =
      await http.post(Uri.parse(url),  headers: {"Content-Type": "application/json"},
          body: body);
      var datos = json.decode(response.body);
      return datos;
    }
    on Exception catch (e){
      return {'Error' : e.toString()};
    }
  }


  Future<Map<String, dynamic>> addVisitante(visitante v) async {
    String url = super.apiURL+"registro.php?tipo=visitante";
    Map data = {
      "nombre": v.nombre,
      "apellidos": v.apellidos,
      "clave" : v.password,
      "genero": v.genero,
      "correo": v.correo,
      "institucion" : v.institucion,
      "fecha_nacimiento" : v.fecha_nac
    };
    var body = json.encode(data);
    http.Response response;
    try{
      response =
      await http.post(Uri.parse(url),  headers: {"Content-Type": "application/json"},
          body: body);
      var datos = json.decode(response.body);
      return datos;
    }
    on Exception catch (e){
      return {'Error' : e.toString()};
    }
  }
}