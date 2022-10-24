import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sceii/services/htpp_servicies/prestamos.dart';
import 'package:sceii/tools/Dateformat.dart';

import 'home/models/appBar.dart';
import 'home/models/girdView.dart';

class prestamo_herramienta extends StatefulWidget {
  const prestamo_herramienta({Key? key}) : super(key: key);

  @override
  State<prestamo_herramienta> createState() => _prestamo_herramientaState();
}

class _prestamo_herramientaState extends State<prestamo_herramienta> {
  dateFormat formatoFecha = dateFormat();
  var lista = {"data" : [{"id": 1, "descripcion": "Herramiebta", "fecha_limite":"2021-07-17"}, {"id": 2, "descripcion": "sdfsdfs", "fecha_limite":"2021-08-17"}]};
  prestamos_http prestamosHttp = prestamos_http();
  var listPrestamos;
  bool hasError = false;
  String msgError = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: AppBarHome(),
      ),
      body:
      FutureBuilder(
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
                  return(RefreshIndicator(
                      onRefresh: () async {
                        refreshIndexPrestamosUsuario();
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
                                            color:  Theme.of(context).primaryColorLight,
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
                            child:  Text(
                              "Prestamos",
                              style: TextStyle(
                                  fontSize: 20,
                                  color:  Theme.of(context).primaryColorLight,
                                  fontWeight: FontWeight.bold),textAlign: TextAlign.center,
                            ),
                          ),
                          GirdViewPrestamos(listPrestamos),
                        ],
                      )));
                }
            }

          }
      )

    );
  }



  Future<void> initData() async {
    await indexPrestamosUsuario();
  }

  Future<Map<String, dynamic>> indexPrestamosUsuario() async {
    Map<String, dynamic> responde =
    await this.prestamosHttp.index_prestamos_usuario();
    listPrestamos = responde;
    if (listPrestamos.containsKey('error')) {
      hasError = true;
      msgError = listPrestamos['error'].toString();
    } else {
      hasError = false;
      msgError = "";
    }
    return responde;
  }

  Future<Map<String, dynamic>> refreshIndexPrestamosUsuario() async {
    Map<String, dynamic> responde =
    await this.prestamosHttp.index_prestamos_usuario();
    setState(() {
      listPrestamos  = responde;
    });
    if (listPrestamos .containsKey('error')) {
      hasError = true;
      msgError = listPrestamos['error'].toString();
    } else {
      hasError = false;
      msgError = "";
    }
    return responde;
  }
}
