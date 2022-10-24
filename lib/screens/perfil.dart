
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sceii/screens/prestamos.dart';

import '../services/htpp_servicies/usuario.dart';
import '../utils/userSimplePreferences.dart';
import 'editar_perfil.dart';
import 'home/home_alumno.dart';
import 'login.dart';
import 'model widget/changeTheme.dart';
import 'model widget/widget.dart';


class perfil extends StatefulWidget {
  TextEditingController controlador = TextEditingController();

  var Alumno;
  perfil({Key? key}) : super(key: key){

  }
  @override
  State<perfil> createState() => _perfilState();
}

class _perfilState extends State<perfil> {
  late textChangedPass password = textChangedPass("","Contraseña", "Confirma contraseña", "error",Icons.drive_file_rename_outline);

  usuario_http usuarioHttp = usuario_http();
  userPreferences  UserPreferences = userPreferences();
  var base64Img;
  late Uint8List bytes;
  var nombre;
  var apellidos;
  var fotoPerfil;
  List<Widget> bodyWidgetList = [
    bodyHomeAlumno(),
    prestamo_herramienta(),
    perfil(),
  ];


  @override
  Widget build(BuildContext context) {
    var codigo;
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(Icons.arrow_back,
                                        color: Colors.white,
                                        size: 20),
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.all(0),
                                      primary: Colors.transparent,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                    ),
                    body: Container(
                      decoration:  BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35),
                          ),
                          color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      child: ListView(
                        children: <Widget>[
                          Text("Mi perfil", style: TextStyle(fontSize: 24,color: Theme.of(context).primaryColorLight,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: CircleAvatar(
                              backgroundColor: Color.fromRGBO(23, 32, 42, 1),
                              radius: 60,
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 55,
                                backgroundImage: NetworkImage(fotoPerfil),
                              ),
                            ),
                          ),
                          Transform.translate(offset: Offset(50,-40),
                              child:
                              CircleAvatar(
                                backgroundColor: Color.fromRGBO(23, 32, 42, 1),
                                radius: 30,
                                child: Icon(Icons.school,color: Colors.white,size: 30,)),
                              ),
                          Row(
                            children: [
                              Expanded(
                                  child: Text(nombre.toString() +" "+apellidos.toString(), style: TextStyle(fontSize: 18,color: Theme.of(context).primaryColorLight, fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                              ),
                            ],
                          ),
                          Text("Alumno", style: TextStyle(fontSize: 14,color: Theme.of(context).primaryColorLight,),textAlign: TextAlign.center,),
                          Container(
                              height: 500,
                              margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                              child:
                              ListView(
                                  children: <Widget>[
                                    getButtonWidget(0),
                                    getButtonWidget(1),
                                    getButtonWidget(2),
                                    getButtonWidget(3),

                                  ]))],
                      ),
                    ),
                  );
                }
            }

    });
  }


  Widget makeDismissible({required Widget child}) =>GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () => Navigator.pop(context),
    child: GestureDetector(onTap: (){},child: child,),
  );

  Widget builSheet() {
    return
       makeDismissible(child: DraggableScrollableSheet(
                      initialChildSize: 0.7,
                      minChildSize: 0.5,
                      maxChildSize: 0.7,

                      builder: (_, controller)=>
                          Container(
                            decoration: BoxDecoration(
                                color:   Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                            ),
                            //padding: EdgeInsets.all(15),
                            child: Column(
                              //controller: controller,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color:   Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                                    ),
                                    padding: EdgeInsets.only(bottom: 20, top: 10, left: 10, right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(""),
                                        Text("Ajustes",style: TextStyle(fontSize: 18,color:  Theme.of(context).primaryColorLight,fontFamily: "Poppins",fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                                        Container(
                                          height: 30,
                                          width: 30,
                                          padding: EdgeInsets.all(0),
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.all(0),
                                                  primary:  Theme.of(context).errorColor,
                                                  shadowColor: Colors.transparent,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(40))),
                                              onPressed: ()  {
                                                Navigator.pop(context);
                                              },
                                              child: Center(child:Icon(Icons.close, size: 20),)
                                          ),
                                        )

                                      ],
                                    )),
                                getButtonWidgetConfi(0),
                                getButtonWidgetConfi(1),
                                getButtonWidgetConfi(2),
                                getButtonWidgetConfi(3)
                              ],
                            ),
                          )));
                }



  Widget getButtonWidgetConfi (int position){
    ChangeThemeButton s = ChangeThemeButton();
    var etiqueta = ["Editar perfil","Ver notificaciones","Tema","Eliminar cuenta"];
    var icons = [Icons.edit, Icons.notifications, Icons.wb_sunny, Icons.delete];
    var color = position!=3?Theme.of(context).primaryColorLight:Color.fromRGBO(222, 23, 59, 1);
    bool isSwitched = true;
    return Container(
        height:50,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Theme.of(context).primaryColorLight),
          ),
        ),
        child:
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              elevation: 0,
            ),
            onPressed: () async {
              if (position==0){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => editPerfil()));
              }else
                if(position==3){
                  AwesomeDialog(
                    dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    context: context,
                    dialogType: DialogType.warning,
                    headerAnimationLoop: true,
                    animType: AnimType.bottomSlide,
                    titleTextStyle: TextStyle(color: Theme.of(context).primaryColorLight),
                    descTextStyle:  TextStyle(color: Theme.of(context).primaryColorLight),
                    title: "¿Seguro que quieres borrar tu cuenta?",
                    desc: "Confirma con tu contraseña, una vez borrada no podrás recuperar ninguno de tus datos",
                    buttonsTextStyle: const TextStyle(color: Colors.black),
                    closeIcon: Icon(Icons.close,color: Theme.of(context).primaryColorLight,),
                    showCloseIcon: true,
                      body:Center(
                        child: password,
                      ),
                    btnOkOnPress: () async {
                        if(valiPassword()){
                          var responde = await delete_user();
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
                            AwesomeDialog(
                                dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                context: context,
                                dialogType: DialogType.success,
                                headerAnimationLoop: true,
                                animType: AnimType.bottomSlide,
                                titleTextStyle: TextStyle(color: Theme.of(context).primaryColorLight),
                                descTextStyle:  TextStyle(color: Theme.of(context).primaryColorLight),
                                title: "Tu cuenta ha sido elimina correctamente",
                                desc: "¡Qué te vaya bien!",
                                buttonsTextStyle: const TextStyle(color: Colors.black),
                                closeIcon: Icon(Icons.close,color: Theme.of(context).primaryColorLight,),
                                showCloseIcon: true,
                                btnOkOnPress: () {}
                            ).show();
                          }
                        }
                    },
                    btnCancelOnPress: () {},
                  ).show();
                }

            },
            child:
            Row(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(icons[position], size: 30, color: color,),
                  ),
                  Expanded(child:Text(etiqueta[position].toString(),style: TextStyle(color: color,fontSize:18, fontFamily: 'PopPins'),textAlign: TextAlign.left),),
                  position==2?
                      s:
                      position==1?
                  Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });
                    },
                  ):Text(""),
                ]
            )));
  }


  Widget getButtonWidget (int position){
    var etiqueta = ["Configuración","Ver perfil","Acerca de nosotros","Cerrar sesión"];
    var icons = [Icons.settings, Icons.account_circle, Icons.flutter_dash, Icons.logout];
    var color = position!=3?Theme.of(context).primaryColorLight:Color.fromRGBO(222, 23, 59, 1);
    return Container(
          height:50,
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Theme.of(context).primaryColorLight),
            ),
          ),
          child:
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                elevation: 0,
              ),
              onPressed: () async {
                if(position==3){
                  AwesomeDialog(
                      dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      context: context,
                      dialogType: DialogType.info,
                      headerAnimationLoop: true,
                      animType: AnimType.bottomSlide,
                      titleTextStyle: TextStyle(color: Theme.of(context).primaryColorLight),
                      title: "¿Seguro que quieres cerrar sesión?",
                      buttonsTextStyle: const TextStyle(color: Colors.black),
                      closeIcon: Icon(Icons.close,color: Theme.of(context).primaryColorLight,),
                      showCloseIcon: true,
                      btnOkOnPress: () async {await logout(); },
                      btnCancelOnPress: (){}
                  ).show();

                }

                else
                  if(position==0)
                    showModalBottomSheet(context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context)=> builSheet());
                  else
                    print("hola");

              },
              child:
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Icon(icons[position], size: 30, color: color,),
                    ),
                    Expanded(child:Text(etiqueta[position].toString(),style: TextStyle(color: color,fontSize:18, fontFamily: 'PopPins'),textAlign: TextAlign.left),),
                    Icon(Icons.navigate_next, size: 30, color: color,)
                  ]
              )));
    }

  initData() async {
    fotoPerfil = await UserPreferences.getfotoPerfil();
    //bytes = base64Decode(base64Img);
    nombre = await UserPreferences.getNombre();
    apellidos = await UserPreferences.getApellidos();
  }

  logout() async {
    await UserPreferences.logout();
    Navigator.of(context, rootNavigator:
    true).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        login()), (route) => false);
  }

  bool valiPassword(){
      if(password.formKey.currentState!.validate())
        return true;
    return false;
  }

  Future<Map<String, dynamic>> delete_user() async{
    String clave = password.controlador;
    Map<String, dynamic> r = await this.usuarioHttp.delete_usuario(clave);
    return r;
  }

}