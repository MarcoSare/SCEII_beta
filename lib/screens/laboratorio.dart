import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sceii/screens/lista_actividades.dart';
import 'package:sceii/screens/lista_alumnos.dart';
import 'package:sceii/screens/utils/qr_scanner.dart';

import '../models/alumno.dart';
import '../models/student.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/htpp_servicies/bitacora.dart';
import '../utils/responsive.dart';

class laboratorio extends StatefulWidget {
  int id;
  TextEditingController controlador = TextEditingController();

  var Alumno;
  laboratorio({Key? key, required this.id }) : super(key: key){

  }


  @override
  State<laboratorio> createState() => _laboratorioState();
}

class _laboratorioState extends State<laboratorio> {
  int _currentIndex = 0;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  var isBarcode=false;
  QRViewController? controller;
  bitacora_http http = new bitacora_http();

  _laboratorioState(){

  }

  var listPracticas = {
    "data": [{
    "nombre" : "practica x",
      "porcentaje" : "10"
    },
      {
        "nombre" : "practica y",
        "porcentaje" : "20"

      },
      {
        "nombre" : "practica z",
        "porcentaje" : "100"

      }
    ]
  };

  var listEnlaces = {
    "data": [{
      "nombre" : "Canal de yotube",
      "porcentaje" : "10",
      "tipoEnlace" : "0"
    },
      {
        "nombre" : "Blog para el laboratorio",
        "porcentaje" : "20",
        "tipoEnlace" : "1",

      },
      {
        "nombre" : "Grupo de Face Book",
        "porcentaje" : "20",
        "tipoEnlace" : "2"

      },
      {
        "nombre" : "Cuenta de Twitter",
        "porcentaje" : "20",
        "tipoEnlace" : "3"

      },
      {
        "nombre" : "PopCats",
        "porcentaje" : "20",
        "tipoEnlace" : "4"

      },
      {
        "nombre" : "Pagina para reforzar aprendizajes",
        "porcentaje" : "20",
        "tipoEnlace" : "5"

      },
    ]
  };
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    print("id: " + widget.id.toString());
    ProgressDialog pr = ProgressDialog(context);
    pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    pr.style(
        message: 'Espere por favor',
        borderRadius: 10.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        progressWidget: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColorDark),
        ),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Theme.of(context).primaryColorLight, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Theme.of(context).primaryColorLight, fontSize: 19.0, fontWeight: FontWeight.w600)
    );
    var codigo;
    return Scaffold(

        floatingActionButton:
        _currentIndex==0?
        FloatingActionButton(
            child: Icon(Icons.format_list_bulleted,size: 30,),
            backgroundColor: Color.fromRGBO(70, 165, 37, 1),
            onPressed:(){
              /*
              AwesomeDialog(
                dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
                context: context,
                dialogType: DialogType.success,
                headerAnimationLoop: true,
                animType: AnimType.bottomSlide,
                titleTextStyle: TextStyle(color: Theme.of(context).primaryColorLight),
                descTextStyle:  TextStyle(color: Theme.of(context).primaryColorLight),
                title: "Encabezado",
                desc: 'Dialog description here...',
                buttonsTextStyle: const TextStyle(color: Colors.black),
                closeIcon: Icon(Icons.close,color: Theme.of(context).primaryColorLight,),
                showCloseIcon: true,
                btnCancelOnPress: () {},
                btnOkOnPress: () {},
              ).show();
              */
              setState(() {
                _currentIndex = _currentIndex==0?1:0;
                result == null;
              });
            }
        ):null,

      appBar:
      _currentIndex==1?
      AppBar(
          title: Text("Registro en bitacora", style: TextStyle(color: Theme.of(context).primaryColorLight),),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_sharp,color: Theme.of(context).primaryColorLight,),
            tooltip: 'Menu Icon',
            onPressed: () {
             setState(() {
               _currentIndex=0;
             });
            },
          )
      ):null,

      body:

      _currentIndex==0?
      ListView(
        shrinkWrap: true,


          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        children: <Widget>[
          Container(
              width: 100,
              height: 250,
              //margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              padding:const EdgeInsets.fromLTRB(0, 0, 0, 0),
              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                    image: NetworkImage("https://i.imgur.com/l5kHdYQ.jpeg"),
                    //image: AssetImage("assets/materia1.jpg"),
                    fit:BoxFit.cover
                ),

              ),
              child:Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black
                          ]
                      )),
                  child:Card(
                    margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                    color: Colors.transparent,
                    elevation: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            child: Row(
                                children:<Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(right: 20.0),
                                    width: 150,
                                    height: 70,
                                    child: ClipRect(
                                    child: BackdropFilter(filter: ImageFilter.blur(sigmaX:7.0,sigmaY:7.0
                                    ),
                                    child: Container(
                                      color: Colors.black.withOpacity(0),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20))),
                                          child:
                                          Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              //crossAxisAlignment:CrossAxisAlignment.start ,
                                              children: [
                                                Expanded( child: Text("Encargado",style: TextStyle(color: Colors.white,fontSize:18),textAlign: TextAlign.left)),
                                                Icon(Icons.book_rounded),
                                              ]
                                          ),
                                          onPressed: () async {
                                            await openDialog2();
                                          })
                                    )
                                    )
                                    ),
                                  ),
                                  Container(
                                    //margin: const EdgeInsets.only(right: 20.0),
                                    width: 160,
                                    height: 70,
                                    child: ClipRect(
                                        child: BackdropFilter(filter: ImageFilter.blur(sigmaX:7.0,sigmaY:7.0
                                        ),
                                            child: Container(
                                                color: Colors.black.withOpacity(0),
                                                child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        primary: Colors.transparent,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(20))),
                                                    child:
                                                    Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        //crossAxisAlignment:CrossAxisAlignment.start ,
                                                        children: [
                                                          Expanded( child: Text("Compañeros",style: TextStyle(color: Colors.white,fontSize:18),textAlign: TextAlign.left)),
                                                          Icon(Icons.supervised_user_circle_rounded),
                                                        ]
                                                    ),
                                                    onPressed: () {
                                                      Navigator.push(context,
                                                          MaterialPageRoute(builder: (context) => listAlumnos()));
                                                    })
                                            )
                                        )
                                    ),
                                  )
                                  ])
                        ),

                        Row(
                            children:<Widget>[
                              Container(
                                margin: const EdgeInsets.only(right: 20.0),
                                width: 50,
                                height: 50,
                                child: Icon(Icons.star, size: 30,
                                    color: Colors.white),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.purple),
                              ),
                              Flexible(
                                child: Text("Laboratorio de manofacturas",
                                    style: TextStyle(fontSize: 20, color: Colors.white,fontFamily: "Poppins")),
                              )])
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ))),
          //if(widget.listMaterias.length>0)
          //for(int i=0;widget.listMaterias.length>i;i++)
          //_getCard(context,widget.listMaterias[i]['materia'],widget.listMaterias[i]['maestro'])
          if(false)
            Container(
                padding: const EdgeInsets.fromLTRB(0, 100, 0, 50),
                alignment: Alignment.center,
                child: Column(
                    children: [
                      Image.asset(
                        'assets/sinMaterias.png',
                        width: 205,
                        height: 205,
                      ),
                      Text(
                        "No tienes laboratorios",
                        style: TextStyle(color: Colors.white,fontFamily: "Poppins", fontSize: 26),
                      ),
                      Icon(Icons.help, color: Colors.white, size: 70,)
                    ]
                )),

          Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 20, right: 20),
              child:
              Text(
                "Enlaces",
                style: TextStyle(
                    fontSize: 20,
                    color:  Theme.of(context).primaryColorLight,
                    fontWeight: FontWeight.bold),
              )),
          Container(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.all(0),
            height: 200,
            width: 200,
            child: GirdViewEnlaces(listEnlaces),),
          Padding(
              padding: const EdgeInsets.only(
                  top: 5, left: 20, right: 20),
              child:
              Text(
                "Practicas",
                style: TextStyle(
                    fontSize: 20,
                    color:  Theme.of(context).primaryColorLight,
                    fontWeight: FontWeight.bold),
              )),
          GirdViewPracticas(listPracticas),






        ],
      ):Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay:  QrScannerOverlayShape(
                  borderColor: Theme.of(context).primaryColorDark,
                  borderRadius: 20,
                  borderLength: 20,
                  borderWidth: 20,
                  cutOutSize: MediaQuery.of(context).size.width * 0.8
              ),
            ),
          ),
          Expanded(
            //Type: qrcode
            //Data: token
            flex: 1,
            child:
            ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    primary:Theme.of(context).primaryColorDark,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
            onPressed:isBarcode? () async {
              int error = 0;
              String msg = "";
              pr.show();
              var responde = await login(widget.id.toString(),result!.code.toString());
              pr.hide();
              if(responde.containsKey('error')){
                if(responde['error']=='El código que ingreso no es correcto'){
                  error = 1;
                  msg = "El código que ingreso no es correcto";
                }
                else{
                  error = 1;
                  msg = "Ha ocurrido en error inesperado";
                }
              }
              else{
                msg = responde['message'];
                setState(() {
                  _currentIndex =0;
                });
              }


              AwesomeDialog(
                dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
                context: context,
                dialogType: error==0?DialogType.success:DialogType.error,
                headerAnimationLoop: true,
                animType: AnimType.bottomSlide,
                titleTextStyle: TextStyle(color: Theme.of(context).primaryColorLight),
                descTextStyle:  TextStyle(color: Theme.of(context).primaryColorLight),
                title: error==0?"Exito":"Error",
                desc: msg,
                buttonsTextStyle: const TextStyle(color: Colors.black),
                closeIcon: Icon(Icons.close,color: Theme.of(context).primaryColorLight,),
                showCloseIcon: true,
                btnOkOnPress: () {},
              ).show();
              result == null;
            }:null,
            child:
            Center(

              child: (result != null)
                  ? Text("De clic para registrarse en la bitacora")
                  : Text('Escanea el código QR', style: TextStyle(color: Colors.white),),
            ),
          ))
        ],
      ),
    );
  }



  Future<Map<String, dynamic>> login(String id_laboratorio, String codigo_bitacora) async {
    Map<String, dynamic> responde = await this.http.registro(id_laboratorio, codigo_bitacora);
    return responde;
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if(describeEnum(result!.format)=="qrcode"){
          isBarcode = true;
        }
        else{
          isBarcode = false;
          AwesomeDialog(
            dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
            context: context,
            dialogType: DialogType.error,
            headerAnimationLoop: true,
            animType: AnimType.bottomSlide,
            titleTextStyle: TextStyle(color: Theme.of(context).primaryColorLight),
            descTextStyle:  TextStyle(color: Theme.of(context).primaryColorLight),
            title: "Error",
            desc: "ingresa un código QR",
            buttonsTextStyle: const TextStyle(color: Colors.black),
            closeIcon: Icon(Icons.close,color: Theme.of(context).primaryColorLight,),
            showCloseIcon: true,
            btnOkOnPress: () {},
          ).show();
        }

      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }







  Future<bool?> openDialog2()=> showDialog<bool>(

    context: context,
    builder: (context)=>AlertDialog(
      backgroundColor: Color.fromRGBO(23, 32, 42, 1),
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),),
      title: Text("Datos del encargado", style: TextStyle(color: Colors.white)),
      content: Container(
        height: 200,
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: Color.fromRGBO(23, 32, 42, 1),
              radius: 60,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 55,
                backgroundImage: AssetImage('assets/encargado.png'),
              ),
            ),
            Text("Marco Isaías Ramírez García", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 18)),
            Text("19030260@itcelaya.edu.mx", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),


        //TextField(
        //controller: controlador,
        //autofocus: true,
        //)

      ),
      actions: [
        Container(
          height: 40,
          width: 110,
          //padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          //margin: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(222, 23, 59 , 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: const Text(
                'Atras',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        Container(
          height: 40,
          width: 110,
          //padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          //margin: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(70, 165, 37, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: const Text(
                'Ok',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              onPressed: () async {
                Navigator.pop(context);
              }
          ),
        ),
      ],
    ),
  );


  Future<bool?> openDialog3()=> showDialog<bool>(

    context: context,
    builder: (context)=>AlertDialog(
      backgroundColor: Color.fromRGBO(23, 32, 42, 1),
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),),
      title: Text("Registro en bitacora", style: TextStyle(color: Colors.white)),
      content: Container(
        height: 300,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10)),
            Text("Registra tu entrada/salida del laboratorio escenneando el codigo QR", style: TextStyle(color: Colors.white)),

            Container(
                margin:  const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 50,
                  child: Center(child: IconButton(iconSize:60,icon: Icon(Icons.qr_code_scanner,color: Colors.white), onPressed: () {  _leerCodigo();},)),
                )),
          ],
        ),


        //TextField(
        //controller: controlador,
        //autofocus: true,
        //)

      ),
      actions: [
        Container(
          height: 40,
          width: 110,
          //padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          //margin: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(222, 23, 59 , 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: const Text(
                'Atras',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
      ],
    ),
  );







  void _leerCodigo() async {
    String resultado = "";
    //String? cameraScanResult = await scanner.scan();
    //resultado = cameraScanResult!;
    setState(() {
      switch (resultado) {
        case "entrada":
          {
            print("entrada");
          }
          break;
        case "salida":
          {
            print("salida");
          }
          break;
        default:
          {
            print("defaulr");
          }
          break;
      }
      /* (resultado == "entrada")
          ? lectura = "Registro de entrada exitoso"
          : lectura = "Error en lectura";
      (resultado == "salida")
          ? lectura = "Registro de salida exitoso"
          : lectura = "Error en lectura";*/
    });
  }
}


//card de la practica
class practicaCard extends StatelessWidget {
  practicaCard(this.nombre, this.porcentaje);
  String nombre;
  var porcentaje;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("f"),
      child: Container(
        padding:  EdgeInsets.fromLTRB(10,10,10,5),
        decoration: BoxDecoration(
          color:  double.parse(porcentaje)==100?Colors.green: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 4.0,
              spreadRadius: .05,
            ), //BoxShadow
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child:
              CircularPercentIndicator(
                radius: 50.0,
                lineWidth: 13.0,
                animation: true,
                percent: double.parse(porcentaje)/100,
                backgroundColor:  Theme.of(context).primaryColorLight,
                center:
                double.parse(porcentaje)==100?
                Center(
                  child: Icon(Icons.star, size: 40, color: Colors.amberAccent,),
                ):
                 Text(
                  porcentaje+"%",
                  style:
                  new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color:  Theme.of(context).primaryColorLight),
                ),
                footer: new Text(
                  double.parse(porcentaje)==100?"Completado":"Tu avance",
                  style:
                  new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0, color:  Theme.of(context).primaryColorLight),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: double.parse(porcentaje)==100? Colors.amberAccent:Colors.green,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(this.nombre, style: TextStyle(fontSize: 20,color:  Theme.of(context).primaryColorLight,fontFamily: "Poppins",fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}


class enlaceCard extends StatefulWidget {
  enlaceCard(this.nombre, this.tipoEnlace );
  late String nombre;
  late int tipoEnlace;

  @override
  State<StatefulWidget> createState() => _enlaceCardState();
}

class _enlaceCardState extends State<enlaceCard> {
  var colorEnlaces = [Color.fromRGBO(255, 0, 0, 1),
    Color.fromRGBO(252, 210, 9, 1),
    Color.fromRGBO(3, 107, 227, 1),
    Color.fromRGBO(17, 154, 251, 1),
    Color.fromRGBO(30, 215, 96, 1),
    Colors.grey];



  var iconEnlaces = [FontAwesomeIcons.youtube, FontAwesomeIcons.google, FontAwesomeIcons.facebook, FontAwesomeIcons.twitter, FontAwesomeIcons.spotify, FontAwesomeIcons.earthAmericas];

  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: 150,
        height: 200,
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(5),
        child:
        Column (children: [
          GestureDetector(
            onTap: () => print("f"),
            child: Container(
              margin: EdgeInsets.all(5),

              height: 80,
              //padding:  EdgeInsets.fromLTRB(5,5,5,5),

              decoration: BoxDecoration(
                color:  colorEnlaces[widget.tipoEnlace],
                shape: BoxShape.circle,

              ),
              child:
                  Align(
                      alignment: Alignment.center,
                      child:
                      Center(
                          child: FaIcon(iconEnlaces[widget.tipoEnlace], color: Colors.white,size: 40,)
                      )
                  ),
            ),
          ),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(""),
              Expanded(child:Text(widget.nombre, style: TextStyle(fontSize: 12,color:  Theme.of(context).primaryColorLight,fontFamily: "Poppins"),textAlign: TextAlign.center,),),
              Container(
                height: 40,
                width: 40,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(

                            borderRadius: BorderRadius.circular(30))),
                    onPressed: ()  {
                      showModalBottomSheet(context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context)=> builSheet());
                    },
                    child: Center(child:Icon(Icons.more_vert, color:  Theme.of(context).primaryColorLight,),)
                ),
              )
            ],
          ),
        ],)


      );

  }

  Widget makeDismissible({required Widget child}) =>GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () => Navigator.pop(context),
    child: GestureDetector(onTap: (){},child: child,),
  );

  Widget builSheet() {
    return
      FutureBuilder(future: init(),
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
                  return makeDismissible(child: DraggableScrollableSheet(
                      initialChildSize: 0.5,
                      minChildSize: 0.4,
                      maxChildSize: 0.6,

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
                                        Text("Detalles",style: TextStyle(fontSize: 18,color:  Theme.of(context).primaryColorLight,fontFamily: "Poppins",fontWeight: FontWeight.bold),textAlign: TextAlign.center),
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
                                Expanded(
                                    child:ListView(
                                      controller: controller,
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                                color:    colorEnlaces[widget.tipoEnlace],
                                                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
                                            ),
                                            child: Center(child:FaIcon(iconEnlaces[widget.tipoEnlace], color: Colors.white,size: 150,),)
                                        ),

                                        Container(
                                          margin: EdgeInsets.all(20),
                                          child:
                                          Column(
                                            children: [

                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Canal",style: TextStyle(fontSize: 18,color:  Theme.of(context).primaryColorLight,fontFamily: "Poppins",fontWeight: FontWeight.bold),),
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        color: colorEnlaces[widget.tipoEnlace],
                                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                                    ),
                                                    child:Text("YouTube",style: TextStyle(fontSize: 14,color: Colors.white),),
                                                  )
                                                ],
                                              ),Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Expanded(child:Text("Lorem ipsum dolor sit amet. Ea officia odio qui quasi voluptatem rem unde animi. Eum veritatis et voluptatem iusto hic veritatis laborum aut explicabo laudantium ut pariatur mollitia et vitae itaque",style: TextStyle(fontSize: 14,color:  Theme.of(context).primaryColorLight,fontWeight: FontWeight.bold),),
                                                  )
                                                ],
                                              ),
                                              getRowDetails(Icons.link, "https://www.youtube.com/channel/UC6YbhDw4mcdjC7P3q26XX6A"),
                                              // Clipboard.setData(ClipboardData(text: "your text"));
                                            ],
                                          ),
                                        )
                                      ],
                                    ) )
                              ],
                            ),
                          )));
                }
            }
          });
  }

  Widget getRowDetails(var p_icon, String data){
    return
      Builder(
          builder: (context){
            return  Container(
              margin: EdgeInsets.all(10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: Theme.of(context).primaryColor,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(

                                borderRadius: BorderRadius.circular(30))),
                        onPressed: ()  {
                          //Clipboard.setData(ClipboardData(text: data));


                          final snackBar = SnackBar(
                            content: Text('Yay! A SnackBar!'),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);


                          // Find the Scaffold in the widget tree and use
                          // it to show a SnackBar.

                        },
                        child: Center(child:Icon(p_icon, color:  Theme.of(context).primaryColorLight,),)
                    ),
                    Expanded(child:Text(data,style: TextStyle(fontSize: 14,color:  Theme.of(context).primaryColorLight,fontFamily: "Poppins",fontWeight: FontWeight.bold),)),
                  ]
              ),
            );
          }
      );


  }

  Future<void> init() async{
    print ("hola");
  }


}


class GirdViewPracticas extends StatefulWidget {
  var data;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GirdViewPracticas(this.data);
  @override
  State<StatefulWidget> createState() => _GirdViewPracticasState();
//State<getDropdownButton> createState() => _getDropdownButtonState(sele);
}

class _GirdViewPracticasState extends State<GirdViewPracticas> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    bool isTablet = responsive.isTablet;
    double marginTB = responsive.dp(0.4);



    return  GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 20,
          mainAxisSpacing: 24,
        ),
        itemBuilder: (context, index) {
          return
            BounceInLeft(
                delay: Duration(microseconds: 100 * index),
                child: practicaCard(
                    widget.data['data'][index]['nombre'],
                    widget.data['data'][index]['porcentaje']
                )
            );
        },
        itemCount: widget.data['data'].length
    );
  }
}


class GirdViewEnlaces extends StatefulWidget {
  var data;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GirdViewEnlaces(this.data);
  @override
  State<StatefulWidget> createState() => _GirdViewEnlacesState();
//State<getDropdownButton> createState() => _getDropdownButtonState(sele);
}

class _GirdViewEnlacesState extends State<GirdViewEnlaces> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    bool isTablet = responsive.isTablet;
    double marginTB = responsive.dp(0.4);



    return  ListView.builder(
        //physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,


        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),

        itemBuilder: (context, index) {
          return
            BounceInLeft(
                delay: Duration(microseconds: 100 * index),
                child: enlaceCard(
                    widget.data['data'][index]['nombre'],
                  int.parse(widget.data['data'][index]['tipoEnlace']),
                )
            );
        },
        itemCount: widget.data['data'].length
    );
  }
}

