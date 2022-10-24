import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sceii/screens/model%20widget/widget.dart';
import 'package:sceii/utils/responsive.dart';
import '../model widget/textFieldOne.dart';
import '../../services/htpp_servicies/recuperacionCuenta.dart';
import '../model widget/openDialog.dart';





class changePassword extends StatefulWidget {
  changePassword( {Key? key, required String this.correo}) : super(key: key);
  String correo;
  @override
  State<changePassword> createState() => _changePasswordState();
}

class _changePasswordState extends State<changePassword> {
  recuperacionCuenta_http http = new recuperacionCuenta_http();
  textFieldPass password = textFieldPass();
  textFieldOne textOne = new textFieldOne();
  textFieldOne textTwo = new textFieldOne();
  textFieldOne textThree = new textFieldOne();
  textFieldOne textFour = new textFieldOne();
  bool isAcept = false;
  bool codigoIncorrecto = false;
  bool isLoading = false;
  late openDialogError alertError;
  late openDialogSuccess alertSucces;


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
                    margin :  EdgeInsets.fromLTRB(0,responsive.hp(5) , 0, responsive.hp(3)),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/changePassword.png',
                      height: responsive.hp(40),
                    )),
                Container(
                    margin: isTablet?EdgeInsets.fromLTRB(0,0 , 0, responsive.hp(5)):null ,
                    constraints: BoxConstraints(
                      maxWidth: responsive.isTablet?responsive.wp(80):responsive.wp(100),
                    ),
                    height: MediaQuery.of(context).orientation==Orientation.portrait? responsive.hp(52):  null,

                    padding:  EdgeInsets.fromLTRB(responsive.wp(7), responsive.hp(1) , responsive.wp(7), responsive.hp(0.1)),
                    decoration: BoxDecoration(
                        color:  Theme.of(context).primaryColor,
                        borderRadius: isTablet?BorderRadius.circular(30):BorderRadius.only( topRight: Radius.circular(30), topLeft: Radius.circular(30))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Recuperar contraseña",textAlign: TextAlign.center, style: TextStyle(fontSize: responsive.fontSizeSubT,color:  Theme.of(context).primaryColorLight,fontFamily: "Poppins",fontWeight: FontWeight.bold)),
                        Text("Se envió el codigo a " + widget.correo, textAlign: TextAlign.center,style: TextStyle(fontSize: responsive.fontSizeNormal,color:  Theme.of(context).primaryColorLight,fontFamily: "Poppins")),
                        if(!isAcept)
                        Text("¿No has recibido el código?", style: TextStyle(fontSize: responsive.fontSizeNormal,color:  Theme.of(context).primaryColorLight,fontFamily: "Poppins")),
                        if(isAcept)
                        Text("Escriba su nueva contraseña", style: TextStyle(fontSize: responsive.fontSizeNormal,color:  Theme.of(context).primaryColorLight,fontFamily: "Poppins")),
                        if(!isAcept)
                        TextButton(onPressed:(){
                        }, child:Text("Solicita un nuevo código", style: TextStyle(fontSize: responsive.fontSizeNormal,color: Theme.of(context).primaryColorDark ,fontFamily: "Poppins",),),
                        ),

                        !isAcept?
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0,responsive.dp(1), 0),
                              width: responsive.dp(7),
                              child:  textOne,
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0,responsive.dp(1), 0),
                              width: responsive.dp(7),
                              child:  textTwo,
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0,responsive.dp(1), 0),
                              width: responsive.dp(7),
                              child:  textThree,
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0,responsive.dp(1), 0),
                              width: responsive.dp(7),
                              child:  textFour,
                            ),
                          ],
                        ):
                        password,
                        if(codigoIncorrecto)
                        Text("El código no corresponde",
                            style: TextStyle(fontSize: responsive.fontSizeNormal,color:  Theme.of(context).errorColor,fontFamily: "Poppins")),
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
                                    child: !isLoading?Text(
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
                                      if(!isAcept){
                                        if(veriTextCodigo()){
                                          var responde = await getCodigoForgetPass();
                                          setState(() {
                                            isLoading = false;
                                          });
                                          if(responde.containsKey('error')){
                                              if(responde['error']=='El usuario no existe' || responde['error']=='Los datos no coinciden'){
                                                setState(() {
                                                  codigoIncorrecto = true;
                                                });
                                              }//array indefinido poner excepciones como alertas
                                            else{
                                                alertError =openDialogError("Error", responde['error']);
                                                Future<bool?> openDialog()=> showDialog<bool>(
                                                    context: context,
                                                    builder: (context)=>alertError);
                                                await openDialog();
                                              }
                                          }
                                          else{
                                            setState(() {
                                              isAcept = true;
                                              codigoIncorrecto = false;
                                            });
                                          }
                                        }
                                      }else{
                                        if(veriPassword()){
                                          var responde = await cambiaPassword();
                                          setState(() {
                                            isLoading = false;
                                          });
                                          if(responde.containsKey('error')){
                                                alertError =openDialogError("Error", responde['error']);
                                                Future<bool?> openDialog()=> showDialog<bool>(
                                                    context: context,
                                                    builder: (context)=>alertError);
                                                    await openDialog();
                                          }
                                          else{
                                            alertSucces = openDialogSuccess("Se ha cambiado la contraseña", "Regresa al inicio e inicie sesión con su nueva contraseña");
                                            Future<bool?> openDialog()=> showDialog<bool>(
                                                context: context,
                                                builder: (context)=>alertSucces);
                                            await openDialog();
                                            int count = 0;
                                            Navigator.of(context).popUntil((_) => count++ >= 2);
                                          }
                                        }
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
                                      int count = 0;
                                      Navigator.of(context).popUntil((_) => count++ >= 2);
                                    }),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ))]) ,
        )
    );
  }

  bool veriTextCodigo(){
    if(textOne.formKey.currentState!.validate())
      if(textTwo.formKey.currentState!.validate())
        if(textThree.formKey.currentState!.validate())
          if(textFour.formKey.currentState!.validate())
      return true;
   return false;
  }

  bool veriPassword(){
    if(this.password.formKey.currentState!.validate())
      return true;
    else
      return false;
  }

  String getCodigo(){
    String codigo="";
    codigo = textOne.controlador + textTwo.controlador +textThree.controlador+textFour.controlador;
    return codigo;
  }

  Future<Map<String, dynamic>> getCodigoForgetPass() async {
    String correo = widget.correo;
    Map<String, dynamic> responde = await this.http.getCodigoForgetPass(correo,getCodigo());
    return responde;
  }

  Future<Map<String, dynamic>> cambiaPassword() async {
    String correo = widget.correo;
    String password = this.password.controlador;
    Map<String, dynamic> responde = await this.http.cambiaPassword(correo,password);
    return responde;
  }
}