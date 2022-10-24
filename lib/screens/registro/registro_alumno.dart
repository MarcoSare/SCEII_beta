import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sceii/models/alumno.dart';
import 'package:sceii/models/alumnoDatos.dart';
import 'package:sceii/screens/model%20widget/widget.dart';
import 'package:sceii/services/htpp_servicies/register.dart';
import 'package:sceii/tools/Dateformat.dart';

import '../../utils/responsive.dart';
import '../model widget/emailFormField.dart';
import '../model widget/openDialog.dart';

class registroAlumno extends StatefulWidget {
  const registroAlumno({Key? key}) : super(key: key);
  @override
  State<registroAlumno> createState() => _registroAlumnoState();
}

class _registroAlumnoState extends State<registroAlumno> {
  _registroAlumnoState(){
    dateFormat fo = dateFormat();
    fecha_nac= fo.showDate(DateTime.now());
  }
  var fecha_nac;
  datePicker  datePicker_w = datePicker("Fecha de nacimiento", DateTime.now());
  register http_register = register();
  alumnoDatos alumDatos = alumnoDatos();
  late getDropdownButton listGenero =
  getDropdownButton(alumDatos.generos[0], alumDatos.generos, alumDatos.genero,"Genero");
  late getDropdownButton listSemestre =
  getDropdownButton(alumDatos.semestres[0], alumDatos.semestres, alumDatos.semestre,"Semestre");
  late getDropdownButton listCarrera =
  getDropdownButton(alumDatos.carreras[0], alumDatos.carreras, alumDatos.carrera,"Carrera");

  late textFormField nombre = textFormField("Nombre", "Ingrese tu nombre(s)",
      "", Icons.account_circle,1,50);
  late textFormField apellidos = textFormField("Apellidos", "Ingrese tu apellidos(s)",
      "", Icons.account_circle,1,50);
  emailFormField correo = emailFormField("Correo", "Ingrese tu correo",
      "El correo ya se encuentra registrado");
  textFieldPass password = textFieldPass();
  textFormField noControl = textFormField("No. Control", "Ingrese tu no. Control",
      "El No.Control ya se encuentra registrado", Icons.switch_account_rounded,0,8);

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final isTablet = responsive.isTablet;
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro Alumno", style: TextStyle(color: Theme.of(context).primaryColorLight),),
          centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_sharp,color: Theme.of(context).primaryColorLight,),
            tooltip: 'Menu Icon',
            onPressed: () {
              Navigator.pop(context);
            },
          )
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 100.0, right: 100.0),
                    alignment: Alignment.center,
                    width: 130,
                    height: 100,
                    child: Icon(Icons.school, color: Theme.of(context).primaryColorLight, size: 100,)
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                    margin: isTablet? EdgeInsets.fromLTRB(responsive.dp(7), responsive.dp(1), responsive.dp(7), responsive.dp(7)):null ,
                      decoration: BoxDecoration(
                          borderRadius:!isTablet? BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20)):BorderRadius.circular(20),
                              color: Theme.of(context).primaryColor
                          ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Registrarse", style: TextStyle(fontSize: 28,color: Theme.of(context).primaryColorLight,fontFamily: "Poppins",fontWeight: FontWeight.bold),)
                          ],
                        ),

                        nombre,
                  apellidos,
                  correo,
                  noControl,
                  password,
                  listGenero,
                  listCarrera,
                  listSemestre,
                  datePicker_w,
                  Container(
                    width: 200,
                    height: 50,
                    child:
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColorDark,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child:
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded( child: Text(!isLoading?"Registrarse":"Espere",style: TextStyle(color: Colors.white,fontSize:18),textAlign: TextAlign.left)),
                            !isLoading?Icon(Icons.login):Container(
                              child: CircularProgressIndicator(color: Colors.white,),
                              margin: EdgeInsets.fromLTRB(responsive.dp(1),responsive.dp(0.3),responsive.dp(1),responsive.dp(0.3)),
                            ),
                          ]
                      ),
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        if(valiAlumno()){
                         var responde = await addAlumno();
                         setState(() {
                           isLoading = false;
                         });
                         if(!responde.containsKey('error')){
                           if(responde['message']=='Registro exitoso'){
                             openDialogSuccess alerta =openDialogSuccess("Registro Existoso", "Se ha enviado un enlace de confirmación a su correo");
                             Future<bool?> openDialog()=> showDialog<bool>(
                                 context: context,
                                 builder: (context)=>alerta);
                             await openDialog();
                             int count = 0;
                             Navigator.of(context).popUntil((_) => count++ >= 2);
                           }
                         }else
                           if(responde['error']=='El correo ya se encuentra registrado'){
                             correo.error=true;
                             correo.msgError = "El correo ya se encuentra registrado";
                             correo.formKey.currentState!.validate();
                           }else
                             if(responde['error']=='El no. Control ya se encuentra registrado'){
                               noControl.error=true;
                               noControl.msgError = "El no. Control ya se encuentra registrado";
                               noControl.formKey.currentState!.validate();
                             }else{
                               openDialogError alerta =openDialogError("Error", responde['error']);
                               Future<bool?> openDialog()=> showDialog<bool>(
                                   context: context,
                                   builder: (context)=>alerta);
                               await openDialog();
                             }

                        }
                        setState(() {
                          isLoading = false;
                        });
                      }))])
                ,
              )]
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

  Future<Map<String, dynamic>> addAlumno() async {
    String nombre_a = nombre.controlador;
    print(nombre_a);
    String apellidos_a = apellidos.controlador;
    print(apellidos_a);
    String correo_a = correo.controlador;
    print(correo_a);
    String no_control_a = noControl.controlador;
    print(no_control_a);
    String password_a = password.controlador;
    print(password_a);
    String genero_a = getGenero();
    print(genero_a);
    String carrera_a = getCarrera();
    print(carrera_a);
    String semestre_a = getSemestre();
    print(semestre_a);
    String fecha_a = datePicker_w.fecha_return;
    print(fecha_a);
    alumno Alumno = alumno.add(nombre_a, apellidos_a, correo_a, no_control_a, password_a,
        genero_a, semestre_a, carrera_a,fecha_a);
    Map<String, dynamic> r = await this.http_register.addAlumno(Alumno);
    return r;
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