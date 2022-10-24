import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sceii/models/alumno.dart';
import 'package:sceii/models/alumnoDatos.dart';
import 'package:sceii/screens/registro/registro_alumno.dart';
import 'package:sceii/screens/registro/registro_docente.dart';
import 'package:sceii/screens/registro/registro_visitante.dart';
import 'package:sceii/screens/model%20widget/widget.dart';
import 'package:sceii/services/htpp_servicies/httpService.dart';
import 'package:sceii/tools/Dateformat.dart';

import '../../provider/theme_provider.dart';
import '../../utils/responsive.dart';

class registro extends StatefulWidget {
  const registro({Key? key}) : super(key: key);

  @override
  State<registro> createState() => _registroState();
}

class _registroState extends State<registro> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final isTablet = responsive.isTablet;
    return Scaffold(
        backgroundColor: isTablet?Theme.of(context).scaffoldBackgroundColor:Theme.of(context).primaryColor,
        body: ListView(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
            children: <Widget>[
              Card(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, responsive.dp(1.5)),
                  color: Colors.transparent,
                  elevation: 0,
                  child: Container(
                      padding: EdgeInsets.fromLTRB(0, responsive.dp(3), 0, 0),
                      alignment: Alignment.center,
                      decoration: !isTablet?BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(100),
                              bottomLeft: Radius.circular(100)),
                          gradient: Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark?LinearGradient(
                            colors: [
                              Color.fromRGBO(10, 10, 10, 1),
                              Color.fromRGBO(21, 21, 21, 1),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ):LinearGradient(
                            colors: [
                              Colors.white70,
                              Colors.white
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          )):null,
                      child: Column(
                        children: [
                          Container(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 70),
                              child: Container(
                                  child: Row(
                                children: <Widget>[
                                  Container(
                                      width: responsive.wp(10),
                                      height: isTablet
                                          ? responsive.dp(4)
                                          : responsive.dp(5),
                                      margin: EdgeInsets.fromLTRB(
                                          responsive.wp(2.5),
                                          0,
                                          responsive.wp(2.5),
                                          0),
                                      //padding: EdgeInsets.fromLTRB(0,  0,20,0),

                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(Icons.arrow_back,
                                            color: Colors.white,
                                            size: isTablet
                                                ? responsive.dp(2.5)
                                                : responsive.dp(3.5)),
                                        style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(),
                                          padding: EdgeInsets.all(0),
                                          primary: Colors.black,
                                        ),
                                      )),
                                  Container(
                                    width: responsive.wp(70),
                                    child: Text(
                                      'Registro',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: responsive.fontSizeTilte,
                                        color: Theme.of(context).primaryColorLight,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              ))),
                          Container(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                              child: Text(
                                'Registrate como:',
                                style: TextStyle(
                                    fontSize: isTablet
                                        ? responsive.fontSizeSubT
                                        : responsive.dp(2.5),
                                    color: Theme.of(context).primaryColorLight),
                              ))
                        ],
                      ))),
              Container(
                width: isTablet?responsive.wp(40):responsive.wp(100),
                  decoration: BoxDecoration(
                  color: isTablet?Color.fromRGBO(23, 32, 42, 1):null,
                  borderRadius: isTablet?BorderRadius.circular(30):null),
                  margin: isTablet? EdgeInsets.fromLTRB(responsive.dp(7),responsive.dp(2), responsive.dp(7), responsive.dp(1)):null,
                  child: Column(
                children: [
                  Container(
                    height: isTablet?responsive.dp(4):responsive.dp(5),
                    width: isTablet?responsive.wp(50):responsive.wp(100),
                    //padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    margin: isTablet?EdgeInsets.fromLTRB(responsive.dp(5),responsive.dp(2), responsive.dp(5), responsive.dp(0.5)):EdgeInsets.fromLTRB(responsive.dp(5),responsive.dp(2), responsive.dp(5), responsive.dp(1)),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColorDark,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: Text(
                          'Jefe de laboratorio',
                          style: TextStyle(
                              fontSize: responsive.fontSizeSubT,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => registroDocente()));
                        }),
                  ),
                  Container(
                    height: isTablet?responsive.dp(4):responsive.dp(5),
                    width: isTablet?responsive.wp(50):responsive.wp(100),
                    //padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    margin: isTablet?EdgeInsets.fromLTRB(responsive.dp(5),responsive.dp(1), responsive.dp(5), responsive.dp(0.5)):EdgeInsets.fromLTRB(responsive.dp(5),responsive.dp(2), responsive.dp(5), responsive.dp(1)),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColorDark,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: Text(
                          'Alumno',
                          style: TextStyle(
                              fontSize: responsive.fontSizeSubT,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => registroAlumno()));
                        }),
                  ),
                  Container(
                      height: isTablet?responsive.dp(4):responsive.dp(5),
                      width: isTablet?responsive.wp(50):responsive.wp(100),
                      //padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                      margin: isTablet?EdgeInsets.fromLTRB(responsive.dp(5),responsive.dp(1), responsive.dp(5), responsive.dp(2)):EdgeInsets.fromLTRB(responsive.dp(5),responsive.dp(2), responsive.dp(5), responsive.dp(1)),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColorDark,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: Text(
                            'Visitante',
                            style: TextStyle(
                                fontSize: responsive.fontSizeSubT,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => registroVisitante()));
                          })),
                ],
              ))
            ]));
  }
}
