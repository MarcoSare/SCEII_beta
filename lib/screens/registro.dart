import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sceii/models/alumno.dart';
import 'package:sceii/models/alumnoDatos.dart';
import 'package:sceii/screens/model%20widget/widget.dart';
import 'package:sceii/services/htpp_servicies/httpService.dart';
import 'package:sceii/tools/Dateformat.dart';

class regiAlumno extends StatefulWidget {
  const regiAlumno({Key? key}) : super(key: key);
  @override
  State<regiAlumno> createState() => _regiAlumnoState();
}

class _regiAlumnoState extends State<regiAlumno> {
  _regiAlumnoState(){
    dateFormat fo = dateFormat();
    //fecha_nac = fo.showDate(DateTime.now());
    fecha_nac= fo.showDate(DateTime.now());
  }
  dateFormat fo = dateFormat();
  var fecha_nac;
  http_request http = http_request();
  late datePicker  datePicker_w;
  final fechaInicio = DateTime.now();
  alumnoDatos alumDatos = alumnoDatos();
   String dropdownValue ="alumno";
   List<String> usuarios = ["alumno", "docente", "visitante"];

  late getDropdownButton listGenero =
      getDropdownButton(alumDatos.generos[0], alumDatos.generos, alumDatos.genero,"");
  late getDropdownButton listSemestre =
      getDropdownButton(alumDatos.semestres[0], alumDatos.semestres, alumDatos.semestre,"");
  late getDropdownButton listCarrera =
      getDropdownButton(alumDatos.carreras[0], alumDatos.carreras, alumDatos.carrera,"");

  late textFormField nombre = textFormField("Nombre", "Ingrese tu nombre(s)",
      "", Icons.account_circle,1,50);
  late textFormField apellidos = textFormField("Apellidos", "Ingrese tu apellidos(s)",
      "", Icons.account_circle,1,50);
  textFormField correo = textFormField("Correo", "Ingrese tu correo",
      "Correo incorecto", Icons.email_rounded,1,50);
  textFieldPass password = textFieldPass();
  textFormField noControl = textFormField("No. Control", "Ingrese tu no. Control",
      "", Icons.switch_account_rounded,1,50);
  textFormField institucion = textFormField("Institucion", "Ingrese tu institución",
      "", Icons.maps_home_work_rounded,1,50);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        centerTitle: true,
        title: Text('Crea tu cuenta',textAlign: TextAlign.center),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 50),
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('assets/'+dropdownValue+".png" ),
                          fit: BoxFit.fill),
                    ),
                  ),

                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Color.fromRGBO(20, 90, 50, 1),
                              width: 1.0
                          )
                      ),
                      child: DropdownButton<String>(

                        icon: Icon(Icons.expand_more),
                        iconEnabledColor: Colors.white,
                        isExpanded: true,
                        underline: Container(
                            decoration: BoxDecoration(border: Border(bottom: BorderSide.none))),
                        value: dropdownValue,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        dropdownColor: Color.fromRGBO(60, 60, 60, 0.90),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;

                          });
                        },
                        items: usuarios.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )),
                  nombre,
                  apellidos,
                  correo,
                  if(dropdownValue=="alumno")
                    noControl,
                    if(dropdownValue=="visitante")
                    institucion,
                  password,
                  listGenero,
                    Visibility(
                      child: listCarrera,
                        visible : dropdownValue=="alumno"?true:false
                    ),
                    Visibility(
                        child: listSemestre,
                        visible : dropdownValue=="alumno"?true:false
                    ),
                  datePicker_w,
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(112, 173, 71, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: const Text('Registrar'),
                      onPressed: () {
                        if(valiAlumno())
                       print("a");
                      })
                ],
              )),
        ],
      ),
    );
  }


  bool valiUser(){
    if(nombre.formKey.currentState!.validate())
      if(apellidos.formKey.currentState!.validate())
        if(correo.formKey.currentState!.validate())
          if(password.formKey.currentState!.validate())
            return true;
          return false;
  }

  bool valiAlumno(){
    if(valiUser())
      if(noControl.formKey.currentState!.validate())
        return true;
      return false;
  }






    String getGenero(){
    String genero = listGenero.control;
    if(genero=="Masculino")
      return "m";
    if(genero=="Femenino")
      return  "f";
    return"o";
    }

    String getCarrera(){
    int index = listCarrera.lista.indexOf(listCarrera.control)+1;
    return index.toString();
    }
    String getSemestre(){
    if(listSemestre.control=="Otro")
      return "13";
    return listSemestre.control;
    }

  }
