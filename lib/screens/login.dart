import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sceii/screens/home/home_alumno.dart';
import 'package:sceii/screens/recuperacion%20cuenta/recuperacion_cuenta.dart';
import 'package:sceii/screens/registro/register.dart';
import 'package:sceii/screens/model%20widget/widget.dart';
import 'package:sceii/utils/responsive.dart';
import 'package:sceii/utils/userSimplePreferences.dart';
import '../provider/theme_provider.dart';
import '../services/htpp_servicies/login.dart';
import 'model widget/changeTheme.dart';
import 'model widget/openDialog.dart';
import 'model widget/emailFormField.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);
  initData() {}
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  login_http http = login_http();
  emailFormField correo = emailFormField(
      "Correo", "Ingrese tu correo", "El correo ya se encuentra registrado");
  textFieldPass password = textFieldPass();
  bool isLoading = false;
  userPreferences preferences = userPreferences();
  ChangeThemeButton s = new ChangeThemeButton();
  bool session = false;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final isTablet = responsive.isTablet;
    return Scaffold(
      body: ListView(children: <Widget>[
        Container(
            margin:
                EdgeInsets.fromLTRB(0, responsive.hp(7), 0, responsive.hp(5)),
            alignment: Alignment.center,
            child: Image.asset(
              Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
                  ? 'assets/logo.png'
                  : 'assets/logoLigthTheme.png',
              width: responsive.wp(50),
              height: responsive.hp(25),
            )),
        Container(
            margin: isTablet
                ? EdgeInsets.fromLTRB(0, 0, 0, responsive.hp(10))
                : null,
            constraints: BoxConstraints(
              maxWidth:
                  responsive.isTablet ? responsive.wp(80) : responsive.wp(100),
            ),
            height: MediaQuery.of(context).orientation == Orientation.portrait
                ? responsive.hp(66)
                : null,
            padding: EdgeInsets.fromLTRB(responsive.wp(7), responsive.hp(3),
                responsive.wp(7), responsive.hp(3)),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: isTablet
                    ? BorderRadius.circular(30)
                    : BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Iniciar sesión",
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                            fontSize: responsive.fontSizeTilte,
                            fontWeight: FontWeight.bold)),
                    //s
                  ],
                ),
                correo,
                password,
                Container(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => recuperacionCuenta()));
                    },
                    child: Text(
                      'Olvide mi contraseña',
                      style: TextStyle(
                          fontSize:
                              isTablet ? responsive.dp(1.5) : responsive.dp(2),
                          color: Theme.of(context).primaryColorDark,
                          fontFamily: "Poppins"),
                    ),
                  ),
                ),
                Container(
                  height: isTablet ? responsive.dp(3.5) : responsive.dp(4),
                  width: responsive.wp(90),
                  //padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  //margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColorDark,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: !isLoading
                          ? Text(
                              'Entrar',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: isTablet
                                      ? responsive.fontSizeSubT
                                      : responsive.dp(2.5),
                                  color: Colors.white),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  Container(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                    margin: EdgeInsets.fromLTRB(
                                        0,
                                        responsive.dp(0.3),
                                        responsive.dp(1),
                                        responsive.dp(0.3)),
                                  ),
                                  Text(
                                    'Espera',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: isTablet
                                            ? responsive.fontSizeSubT
                                            : responsive.dp(2.5),
                                        fontFamily: "Poppins"),
                                  )
                                ]),
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        if (validar()) {
                          var responde = await login();
                          setState(() {
                            isLoading = false;
                          });
                          if (responde.containsKey('error')) {
                            if (responde['error'] == 'Datos incorrectos') {
                              correo.error = true;
                              correo.msgError =
                                  "Usuario o contraseña incorrecta";
                              correo.formKey.currentState!.validate();
                              password.error = true;
                              password.formKey.currentState!.validate();
                            } else {
                              openDialogError alertError =
                                  openDialogError("Error", responde['error']);
                              Future<bool?> openDialog() => showDialog<bool>(
                                  context: context,
                                  builder: (context) => alertError);
                              await openDialog();
                            }
                          } else {
                            if (responde['message'] == 'Login exitoso') {
                              print(session);
                              await preferences.setSesion(session);
                              await preferences.setLogin(
                                  responde['data'][0]['token'],
                                  responde['data'][0]['tipoUsuario'],
                                  responde['data'][0]['estado'],
                                  responde['data'][0]['nombre'],
                                  responde['data'][0]['apellidos'],
                                  responde['data'][0]['fotoPerfil']);

                              if (responde['data'][0]['tipoUsuario'] ==
                                  "alumno") {
                                Navigator.of(context, rootNavigator: true)
                                    .pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => homeAlumno()),
                                        (route) => false);
                              } else {
                                print("hola");
                              }
                            }
                          }
                          setState(() {
                            isLoading = false;
                          });
                        }
                        setState(() {
                          isLoading = false;
                        });

                        //showAlu();
                      }),
                ),
                Column(
                  children: <Widget>[
                    Text(
                      '¿No tienes una cuenta?',
                      style: TextStyle(
                          fontSize: responsive.dp(1.5),
                          color: Theme.of(context).primaryColorLight),
                    ),
                    TextButton(
                      child: Text(
                        'Crear una cuenta',
                        style: TextStyle(
                            fontSize: isTablet
                                ? responsive.fontSizeSubT
                                : responsive.dp(2.5),
                            color: Theme.of(context).primaryColorDark,
                            fontFamily: "Poppins"),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => registro()));
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: isTablet ? responsive.dp(4) : responsive.dp(5),
                          height:
                              isTablet ? responsive.dp(4) : responsive.dp(5),
                          margin: EdgeInsets.fromLTRB(
                              responsive.dp(0.5), 0, responsive.dp(0.5), 0),
                          child: Icon(Icons.facebook_outlined,
                              size: isTablet
                                  ? responsive.dp(2.5)
                                  : responsive.dp(3.5),
                              color: Colors.white),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColorDark),
                        ),
                        Container(
                          width: isTablet ? responsive.dp(4) : responsive.dp(5),
                          height:
                              isTablet ? responsive.dp(4) : responsive.dp(5),
                          margin: EdgeInsets.fromLTRB(
                              responsive.dp(0.5), 0, responsive.dp(0.5), 0),
                          child: Icon(Icons.discord_outlined,
                              size: isTablet
                                  ? responsive.dp(2.5)
                                  : responsive.dp(3.5),
                              color: Colors.white),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColorDark),
                        ),
                        Container(
                          width: isTablet ? responsive.dp(4) : responsive.dp(5),
                          height:
                              isTablet ? responsive.dp(4) : responsive.dp(5),
                          margin: EdgeInsets.fromLTRB(
                              responsive.dp(0.5), 0, responsive.dp(0.5), 0),
                          child: Icon(Icons.whatsapp_rounded,
                              size: isTablet
                                  ? responsive.dp(2.5)
                                  : responsive.dp(3.5),
                              color: Colors.white),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColorDark),
                        )
                      ],
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        '¿Quires mantener tu sesión abierta?',
                        style: TextStyle(
                            fontSize: responsive.dp(1.5),
                            color: Theme.of(context).primaryColorLight),
                      ),
                      Checkbox(
                        value: session,
                        onChanged: (bool? value) {
                          setState(() {
                            session = value!;
                            print(session);
                          });
                        },
                      ),
                    ]),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            ))
      ]),
    );
  }

  bool validar() {
    if (correo.formKey.currentState!
        .validate()) if (password.formKey.currentState!.validate()) return true;
    return false;
  }

  Future<Map<String, dynamic>> login() async {
    String correo = this.correo.controlador;
    String password = this.password.controlador;
    Map<String, dynamic> responde = await this.http.login(correo, password);
    return responde;
  }
}
