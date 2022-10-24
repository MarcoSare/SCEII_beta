import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sceii/screens/home/home_alumno.dart';
import 'package:sceii/screens/recuperacion%20cuenta/changePassword.dart';
import 'package:sceii/screens/registro/register.dart';

import 'package:sceii/screens/registro.dart';
import 'package:sceii/screens/model%20widget/widget.dart';
import 'package:sceii/services/htpp_servicies/httpService.dart';
import 'package:sceii/utils/responsive.dart';

import '../../provider/theme_provider.dart';
import '../../services/htpp_servicies/recuperacionCuenta.dart';
import '../model widget/emailFormField.dart';
import '../model widget/openDialog.dart';



class recuperacionCuenta extends StatefulWidget {
  recuperacionCuenta({Key? key}) : super(key: key);
  @override
  State<recuperacionCuenta> createState() => _recuperacionCuentaState();
}

class _recuperacionCuentaState extends State<recuperacionCuenta> {
  recuperacionCuenta_http http = new recuperacionCuenta_http();
  emailFormField correo = emailFormField("Correo", "Ingrese tu correo",
      "El correo ya se encuentra registrado");
  bool isLoading = false;
  late openDialogError alertError;


  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final isTablet = responsive.isTablet;
    return Scaffold(
        body:
        SingleChildScrollView(
          child:Column(
              children: <Widget>[
                Container(
                    margin :  EdgeInsets.fromLTRB(0,responsive.hp(10) , 0, responsive.hp(15)),
                    alignment: Alignment.center,
                    child: Image.asset(
                        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark?
                        'assets/logo.png':'assets/logoLigthTheme.png',
                      width: responsive.wp(50),
                      height: responsive.hp(25),
                    )),
                Container(
                    margin: isTablet?EdgeInsets.fromLTRB(0,0 , 0, responsive.hp(10)):null ,
                    constraints: BoxConstraints(
                      maxWidth: responsive.isTablet?responsive.wp(80):responsive.wp(100),
                    ),
                    height: MediaQuery.of(context).orientation==Orientation.portrait? responsive.hp(50):  null,

                    padding:  EdgeInsets.fromLTRB(responsive.wp(7), responsive.hp(3) , responsive.wp(7), responsive.hp(3)),
                    decoration: BoxDecoration(
                        color:Theme.of(context).primaryColor,
                        borderRadius: isTablet?BorderRadius.circular(30):BorderRadius.only( topRight: Radius.circular(30), topLeft: Radius.circular(30))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: responsive.dp(10),
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(child:Text("Recuperar contraseña", style: TextStyle(fontSize: isTablet?responsive.fontSizeSubT:responsive.dp(3.3),color: Theme.of(context).primaryColorLight,fontWeight: FontWeight.bold)),),
                              Expanded(child:Text("Se enviará un codigo de verificación a tu correo", style: TextStyle(fontSize: responsive.fontSizeNormal,color:  Theme.of(context).primaryColorLight,),)),
                            ],
                          ),
                        ),
                        correo,
                        Container(
                          height: responsive.dp(15),
                          child: Column(
                            children: [
                              Container(
                                height: isTablet?responsive.dp(4):responsive.dp(4.5),
                                width: responsive.wp(90),
                                //padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                margin:  EdgeInsets.fromLTRB(0,responsive.dp(1),0,responsive.dp(1)),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary:  Theme.of(context).primaryColorDark,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20))),
                                    child:  !isLoading?Text(
                                      'Enviar',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: isTablet?responsive.fontSizeSubT:responsive.dp(2.5),fontFamily: "Poppins"),
                                    ):Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            child: CircularProgressIndicator(color: Colors.white,),
                                          margin: EdgeInsets.fromLTRB(0,responsive.dp(0.3),responsive.dp(1),responsive.dp(0.3)),
                                        ),
                                        Text(
                                          'Espera',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: isTablet?responsive.fontSizeSubT:responsive.dp(2.5),fontFamily: "Poppins"),
                                        )
                                    ]),
                                    onPressed: () async {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      if(veriCorreo()){
                                        var responde = await getCodigo();
                                        setState(() {
                                          isLoading = false;
                                        });
                                        if(responde.containsKey('error')){
                                            if(responde['error']=='El usuario no existe'){
                                              correo.error=true;
                                              correo.msgError = "El correo no se encuentra registrado";
                                              correo.formKey.currentState!.validate();
                                            }
                                            else{
                                              alertError =openDialogError("Error", responde['error']);
                                              Future<bool?> openDialog()=> showDialog<bool>(
                                                  context: context,
                                                  builder: (context)=>alertError);
                                              await openDialog();
                                            }
                                        }
                                        else
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => changePassword(key: null, correo: correo.controlador.toString(),)));
                                      }
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }),
                              ),
                              Container(
                                height: isTablet?responsive.dp(4):responsive.dp(4.5),
                                width: responsive.wp(90),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: const Color.fromRGBO(19, 20, 20, 1),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20))),
                                    child:  Text(
                                      'Regresar al inicio',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: isTablet?responsive.fontSizeSubT:responsive.dp(2.5),fontFamily: "Poppins"),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      //showAlu();
                                    }),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ))]) ,
        )
    );
  }//if(correo.formKey.currentState!.validate())
  bool veriCorreo(){
    if(correo.formKey.currentState!.validate())
    return true;
    else return false;
  }

  Future<Map<String, dynamic>> getCodigo() async {
    String correo_a = correo.controlador;
    Map<String, dynamic> responde = await this.http.getCodigoPass(correo_a);
    return responde;
  }


}
