import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sceii/screens/model%20widget/widget.dart';

import '../models/alumnoDatos.dart';
import '../services/htpp_servicies/usuario.dart';
import '../utils/userSimplePreferences.dart';
import 'model widget/openDialog.dart';


class editPerfil extends StatefulWidget {
  TextEditingController controlador = TextEditingController();

  var Alumno;
  editPerfil({Key? key}) : super(key: key){

  }


  @override
  State<editPerfil> createState() => _editPerfilState();
}

class _editPerfilState extends State<editPerfil> {
  late String fotoPerfil="";
  userPreferences preferences = userPreferences();
  usuario_http usuarioHttp = usuario_http();
  var listDataUsuario;
  var img;
  late String img64;


  alumnoDatos alumDatos = alumnoDatos();
  late textFormField2 nombre;
  late textFormField2 apellidos;
  late textChangedPass password = textChangedPass("","Nueva contraseña", "Cambia tu contraseña", "error",Icons.drive_file_rename_outline);
  late textChangedPass passwordConfirm = textChangedPass("","Confirma tu contraseña", "Confirma tu contraseña", "error",Icons.drive_file_rename_outline);
  late getEditDropdownButton genero;
  late datePicker  datePicker_w;
  _editPerfilState(){
  }

  @override
  Widget build(BuildContext context) {
    password.controlador="";
    return
      FutureBuilder(
        future: initData(),
    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
    switch (snapshot.connectionState) {
    case ConnectionState.none:
    case ConnectionState.waiting:
    case ConnectionState.active:
    {
    return Center(
    child: Center(child: CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color> (Colors.green),
    )));
    }
    case ConnectionState.done:
    {
      return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(90),
              child: Container(
                padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                height: 200,
                width: double.infinity,
                decoration:  BoxDecoration(
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back,
                              color: Theme.of(context).primaryColorLight,
                              size: 20),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(0),
                            primary: Colors.transparent,
                          ),
                        ),
                        Text("Editar perfil", style: TextStyle(color: Theme.of(context).primaryColorLight, fontFamily: "PopPins", fontSize: 28),textAlign: TextAlign.center,),
                      ],
                    ),
                  ],
                ),
              )
          ),
          body:
          Container(
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),

            child:ListView(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                children: <Widget>[
                 StatefulBuilder(builder: (BuildContext context, StateSetter setState){
                    return Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      //padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Color.fromRGBO(23, 32, 42, 1),
                            radius: 60,
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 55,
                              backgroundImage: img==null ? NetworkImage(listDataUsuario["data"][0]["fotoPerfil"]) : FileImage(img) as ImageProvider,
                            ),
                          ),
                          Transform.translate(offset: Offset(50,-40),
                              child:

                              CircleAvatar(
                                backgroundColor: Color.fromRGBO(23, 32, 42, 1),
                                radius: 30,
                                child: IconButton(icon: Icon(Icons.add_a_photo,color:Colors.white,size: 30,), onPressed: () async {

                                  AwesomeDialog(
                                      dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                      context: context,
                                      dialogType: DialogType.info,
                                      headerAnimationLoop: true,
                                      animType: AnimType.bottomSlide,
                                      titleTextStyle: TextStyle(color: Theme.of(context).primaryColorLight),
                                      title: "¿Permitir que la aplicación acceda a tus archivos?",
                                      buttonsTextStyle: const TextStyle(color: Colors.black),
                                      closeIcon: Icon(Icons.close,color: Theme.of(context).primaryColorLight,),
                                      showCloseIcon: true,
                                      btnOkOnPress: () async {
                                        PickedFile? PickedImage = await ImagePicker().getImage(source: ImageSource.gallery,
                                            imageQuality: 50);
                                        setState(() {
                                          img = File(PickedImage!.path);
                                        });
                                        var bytes = await img.readAsBytesSync();
                                        img64 = base64.encode(bytes);
                                      },
                                      btnCancelOnPress: () {}
                                  ).show();
                                  //await this.usuarioHttp.subir_foto(img64);
                                },),
                              )),
                        ],
                      ),
                    );
                  }),
                  nombre,
                  apellidos,
                  password,
                  genero,
                  datePicker_w,
                  passwordConfirm,
                  Container(
                      margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child:
                      Row(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children:[
                            Container(
                              height: 60,
                              width: 150,
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              //margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: const Color.fromRGBO(70, 165, 37, 1),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20))),
                                  child: const Text(
                                    'Guardar',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                  ),
                                  onPressed: () async {
                                    if(valiUser()){
                                      var responde = await editUsuario();
                                      if (responde.containsKey('error')) {
                                        if(responde['error']=='La contraseña no corresponde'){
                                          AwesomeDialog(
                                              dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                              context: context,
                                              dialogType: DialogType.error,
                                              headerAnimationLoop: true,
                                              animType: AnimType.bottomSlide,
                                              titleTextStyle: TextStyle(color: Theme.of(context).primaryColorLight),
                                              descTextStyle:  TextStyle(color: Theme.of(context).primaryColorLight),
                                              title: "La contraseña no corresponde",
                                              desc: "No se puede continuar hasta que ingreses correctamente la contraseña",
                                              buttonsTextStyle: const TextStyle(color: Colors.black),
                                              closeIcon: Icon(Icons.close,color: Theme.of(context).primaryColorLight,),
                                              showCloseIcon: true,
                                              btnOkOnPress: () {}
                                          ).show();
                                        }
                                        else
                                          print("error inesperado");
                                      }
                                      else{
                                       await preferences.actualizar(this.nombre.controlador, this.apellidos.controlador, fotoPerfil);
                                        openDialogSuccess alerta =openDialogSuccess("Exito", "Se han actualizado tus datos correctamente");
                                        Future<bool?> openDialog()=> showDialog<bool>(
                                            context: context,
                                            builder: (context)=>alerta);
                                        await openDialog();
                                        Navigator.of(context).pop();
                                      }
                                    }
                                    else
                                      {
                                        print("error en onPressed1");
                                      }
                                  }),
                            ),
                            Container(
                              height: 60,
                              width: 150,
                              padding: const EdgeInsets.fromLTRB(10, 10, 10,10),
                              //margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: const Color.fromRGBO(222, 23, 59 , 1),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20))),
                                  child: const Text(
                                    'Cancelar',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                  ),
                                  onPressed: () {
                                    AwesomeDialog(
                                        dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                        context: context,
                                        dialogType: DialogType.info,
                                        headerAnimationLoop: true,
                                        animType: AnimType.bottomSlide,
                                        titleTextStyle: TextStyle(color: Theme.of(context).primaryColorLight),
                                        title: "¿Seguro que quieres salir, no se guardará ninguno de los cambios?",
                                        buttonsTextStyle: const TextStyle(color: Colors.black),
                                        closeIcon: Icon(Icons.close,color: Theme.of(context).primaryColorLight,),
                                        showCloseIcon: true,
                                        btnOkOnPress: () {
                                          Navigator.pop(context);
                                        },
                                        btnCancelOnPress: () {

                                        }
                                    ).show();
                                  }),
                            )])),
                ]) ,
          )


      );
    }
    }
    });
  }


  bool valiUser(){
    if(nombre.formKey.currentState!.validate())
      if(apellidos.formKey.currentState!.validate())
        if(passwordConfirm.formKey.currentState!.validate())
            return true;
    return false;
  }

  initData() async{
    Map<String, dynamic> responde = await this.usuarioHttp.get_usuario();
    if (responde.containsKey('error')) {
      print("error");
    }
    else{
      print("no error");
      listDataUsuario = responde;
      nombre = textFormField2(listDataUsuario["data"][0]["nombre"],"Nombre", "Cambia tu nombre", "error",Icons.drive_file_rename_outline);
      nombre.controlador = listDataUsuario["data"][0]["nombre"];
      apellidos= textFormField2(listDataUsuario["data"][0]["apellidos"],"Apellidos", "Cambia tu apellidos", "error",Icons.drive_file_rename_outline);
      apellidos.controlador = listDataUsuario["data"][0]["apellidos"];
      genero = getEditDropdownButton(setGenero(), alumDatos.generos, alumDatos.genero,"Genero");
      datePicker_w = datePicker("Fecha de nacimiento", DateTime.parse(listDataUsuario["data"][0]["fecha_Nac"]));
    }
  }

  setGenero(){
    if(listDataUsuario["data"][0]["genero"]=="m")
      return "Masculino";
    if(listDataUsuario["data"][0]["genero"]=="f")
      return "Femenino";
    if(listDataUsuario["data"][0]["genero"]=="o")
      return "Otro";
  }

  String getGenero(){
    String genero = this.genero.control;
    if(genero=="Masculino")
      return "m";
    if(genero=="Femenino")
      return  "f";
    return"o";
  }


  Future<Map<String, dynamic>> editUsuario() async {
    fotoPerfil="";
    if(img!=null){
      var responde = await this.usuarioHttp.subir_foto(img64);
      if (responde.containsKey('error')) {
        print("error");
        fotoPerfil= listDataUsuario["data"][0]["fotoPerfil"];
      }else{
        fotoPerfil = responde["link"];
      }
    }else{
      print("qui");
      print(listDataUsuario["data"][0]["fotoPerfil"]);
      fotoPerfil= listDataUsuario["data"][0]["fotoPerfil"];
    }
    String nombre = this.nombre.controlador;
    String apellidos = this.apellidos.controlador;
    String clave = this.password.controlador;
    String genero = getGenero();
    String fecha = this.datePicker_w.fecha_return;
    String passworConfirm = this.passwordConfirm.controlador;
    Map<String, dynamic> r = await this.usuarioHttp.edit_usuario(nombre, apellidos, clave, genero, fecha, fotoPerfil, passworConfirm);
    return r;
  }

}