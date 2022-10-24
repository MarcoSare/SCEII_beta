import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sceii/screens/prestamos.dart';
import 'package:sceii/screens/perfil.dart';
import 'package:sceii/screens/model%20widget/widget.dart';
import 'package:sceii/services/htpp_servicies/httpService.dart';
import 'package:sceii/tools/codigo_materia.dart';
import '../../services/htpp_servicies/alumno_laboratorio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../services/htpp_servicies/alumno_materia.dart';
import '../../utils/userSimplePreferences.dart';
import 'models/appBar.dart';
import 'models/girdView.dart';

class homeAlumno extends StatefulWidget {
  homeAlumno({Key? key}) : super(key: key) {}

  @override
  State<homeAlumno> createState() => _homeAlumnoState();
}

class _homeAlumnoState extends State<homeAlumno> {
  List<Widget> bodyWidgetList = [
    bodyHomeAlumno(),
    prestamo_herramienta(),
    perfil(),
  ];
  late textFormField codigo = textFormField(
      "Codigo", "Ingrese el código", "", Icons.text_format, 1, 50);
  late List listmateria = [];
  TextEditingController controlador = TextEditingController();
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          elevation: 0,
          currentIndex: _currentIndex,
          backgroundColor: Color.fromRGBO(23, 32, 42, 0.5),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color.fromRGBO(70, 165, 37, 1),
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: TextStyle(fontFamily: 'Poppins'),
          unselectedLabelStyle: TextStyle(fontFamily: 'Poppins'),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home,
                  color: _currentIndex == 0
                      ? Color.fromRGBO(70, 165, 37, 1)
                      : Colors.grey),
              label: "home",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.format_list_bulleted,
                    color: _currentIndex == 1
                        ? Color.fromRGBO(70, 165, 37, 1)
                        : Colors.grey),
                label: "Prestamos"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings,
                    color: _currentIndex == 2
                        ? Color.fromRGBO(70, 165, 37, 1)
                        : Colors.grey),
                label: "Configuracion"),
          ],
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
              print(_currentIndex);
            });
          },
        ),
      ),
      //drawer: _getDrawer(context),
      body: bodyWidgetList[_currentIndex],
    );
  }









}

class bodyHomeAlumno extends StatefulWidget {
  @override
  State<bodyHomeAlumno> createState() => _bodyHomeAlumnoState();
}

class _bodyHomeAlumnoState extends State<bodyHomeAlumno> {
  @override
  void initState() {
    super.initState();
    InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
      if (hasInternet == false) {
        turnOff = true;
        showTopSbackBar(context, "Sin conexión", Colors.red);
      } else {
        if (turnOff) showTopSbackBar(context, "Conexión", Colors.green);
      }

      setState(() {
        this.hasInternet = hasInternet;
      });
    });
  }

  late textFormField codigo = textFormField(
      "Codigo", "Ingrese el código", "", Icons.text_format, 1, 50);

  bool bandera = true;
  TextEditingController controlador = TextEditingController();
  http_request httpService = http_request();
  alumno_materia_http alumMateHttp = alumno_materia_http();
  alumno_laboratorio_http alumLaboHttp = alumno_laboratorio_http();
  var listMateria;
  var listLaboratorio;
  bool hasError = false;
  String msgError = "";
  bool hasInternet = true;
  bool turnOff = false;
  bool isLoading = false;
  int inscrito = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: AppBarHome(),
      ),
      body: hasInternet
          ? FutureBuilder(
              future: initData(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    {
                      return Center(
                          child: Center(
                              child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      )));
                    }
                  case ConnectionState.done:
                    {
                      return (RefreshIndicator(
                          onRefresh: () async {
                            await refreshIndexAlumnoLaboratorio();
                            await refreshIndexAlumnoMateria();
                          },
                          child: hasError
                              ? Center(
                                  child: ListView(
                                    children: [
                                      Image.asset(
                                        'assets/error.png',
                                        width: 200,
                                        height: 200,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text((msgError),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                      fontFamily: "Poppins",
                                                      fontWeight:
                                                          FontWeight.bold)))
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              : ListView(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 20, right: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Laboratorios",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color:  Theme.of(context).primaryColorLight,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              "Mostrar más",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color.fromRGBO(
                                                      70, 165, 37, 1),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    GirdViewLaboratorios(listLaboratorio),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 20, right: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Materias",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color:  Theme.of(context).primaryColorLight,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              "Mostrar más",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color.fromRGBO(
                                                      70, 165, 37, 1),
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    GirdViewMaterias(listMateria)
                                  ],
                                )));
                    }
                }
              })
          : Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/hasNotInternet.png',
                    width: 200,
                    height: 200,
                  ),
                  Text(
                    "Sin internet",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 30,
          ),
          backgroundColor: Color.fromRGBO(70, 165, 37, 1),
          onPressed: () async {
            codigo.controlador="";
            await openDialog();
            if(inscrito==2)
            await refreshIndexAlumnoMateria();
            inscrito = 0;
          }),
    );
  }

  static void showTopSbackBar(BuildContext context, String msg, Color color) =>
      showSimpleNotification(Text(msg), background: color);

  Future<void> initData() async {
    await indexAlumnoMateria();
    await indexAlumnoLaboratorio();
  }

  Future<Map<String, dynamic>> indexAlumnoMateria() async {
    Map<String, dynamic> responde =
        await this.alumMateHttp.index_alumno_materia();
    listMateria = responde;
    if (listMateria.containsKey('error')) {
      hasError = true;
      msgError = listLaboratorio['error'].toString();
    } else {
      hasError = false;
      msgError = "";
    }

    return responde;
  }

  Future<Map<String, dynamic>> indexAlumnoLaboratorio() async {
    Map<String, dynamic> responde =
        await this.alumLaboHttp.index_alumno_laboratorio();
    listLaboratorio = responde;
    if (listLaboratorio.containsKey('error')) {
      hasError = true;
      msgError = listLaboratorio['error'].toString();
    } else {
      hasError = false;
      msgError = "";
    }
    return responde;
  }

  Future<Map<String, dynamic>> refreshIndexAlumnoMateria() async {
    Map<String, dynamic> responde =
        await this.alumMateHttp.index_alumno_materia();
    setState(() {
      listMateria = responde;
    });
    if (listMateria.containsKey('error')) {
      hasError = true;
      msgError = listMateria['error'].toString();
    } else {
      hasError = false;
      msgError = "";
    }
    return responde;
  }

  Future<Map<String, dynamic>> refreshIndexAlumnoLaboratorio() async {
    Map<String, dynamic> responde =
        await this.alumLaboHttp.index_alumno_laboratorio();
    setState(() {
      listLaboratorio = responde;
    });
    if (listLaboratorio.containsKey('error')) {
      hasError = true;
      msgError = listLaboratorio['error'].toString();
    } else {
      hasError = false;
      msgError = "";
    }
    return responde;
  }

  Future<void> inscribirMateria() async {
    if(validar()){
      setState(() {
        this.isLoading=true;
      });
      Map<String, dynamic> responde =
      await this.alumMateHttp.inscribir_materia(codigo.controlador.toString());
      setState(() {
        this.isLoading=false;
      });
    if(responde.containsKey('error')){
      if(responde['error']== "La materia no existe" || responde['error']== "Ya esta inscrito a esta materia"){
         setState(() {
           inscrito =2;
         });
      }
    }
    else{
      setState(() {
        inscrito =1;
      });

    }
    }

  }

  bool validar() {
    if(codigo.formKey.currentState!.validate())
        return true;
    return false;
  }

  void setErrorCodigo(String error){
  setState(() {

  });

  }

  Future<bool?> openDialog() => showDialog<bool>(
        context: context,
        builder: (context) => StatefulBuilder(builder:(context, setState) =>
            AlertDialog(
              backgroundColor: Color.fromRGBO(23, 32, 42, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title:
              Text("Inscribir materia", style: TextStyle(color: Colors.white)),
              content: Container(
                height: 200,
                child: Column(
                  children: [
                    Text(inscrito==2?"Materia inscrita con exito":"Escribe el código de acceso",
                        style: TextStyle(color: Colors.white)),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: inscrito!=2?codigo:Text(""),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: gwtWidgetCodigo(),
                    ),
                  ],
                ),
              ),
              actions: [
                Container(
                  height: 40,
                  width: 110,
                  //padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  //margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: inscrito!=2?ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(222, 23, 59, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }):Text(""),
                ),
                Container(
                  height: 40,
                  width: 110,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(70, 165, 37, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: Text(
                        inscrito==2?"Aceptar":'Inscribir',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),

                      onPressed: () async {
                        if(inscrito==2)
                        Navigator.pop(context);
                        else
                        if (validar()){
                          setState(() {
                            inscrito = 1;
                          });
                          Map<String, dynamic> responde = await this.alumMateHttp.inscribir_materia(codigo.controlador.toString());
                          setState(() {
                            inscrito = 0;
                          });
                          if (responde.containsKey('error')) {
                            if (responde['error'] == "La materia no existe" ||
                                responde['error'] ==
                                    "Ya esta inscrito a esta materia") {
                              codigo.error=true;
                              codigo.msgError = responde['error'];
                              codigo.formKey.currentState!.validate();
                            }
                          }
                          else {
                            setState(() {
                              inscrito = 2;
                            });
                          }
                        }
                      }),
                ),
              ],
            ),
        )
      );


  Widget gwtWidgetCodigo() {
    switch (inscrito) {
      case 1:
        { //cargando
          return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ));
        }
      case 2:
        { //inscrita
          return
            Column(
              children: [
              Container(
              height: 60,
              width: 60,
              margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child:
              Icon(Icons.check_circle, size: 40,
                    color: Colors.white),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green)),
               Text(
                  "Materia inscrita con exito",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold),
                )
              ],
            );
        }
      default : return Text("");
    }
  }
  }



