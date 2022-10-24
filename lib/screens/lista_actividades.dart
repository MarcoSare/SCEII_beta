
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'cuestionario.dart';
import 'package:url_launcher/url_launcher.dart';

class listActividades extends StatefulWidget {
  const listActividades({Key? key}) : super(key: key);

  @override
  State<listActividades> createState() => _listActividadesState();
}

class _listActividadesState extends State<listActividades> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(19, 20, 20, 1),
      appBar: AppBar(
        title: Text('Bienvenido'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          onPressed: () {},
        ),

      ),
      drawer: _getDrawer(context),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.white70),
                ),
              ),

            child:  ElevatedButton(
              style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              elevation: 0,
              ),
              onPressed: () {
              },
            child: Row(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Icon(
                  Icons.videocam, size: 40, color: Colors.green,),),
              Expanded(
                  child:Text("Videos de seguridad", style: TextStyle(color: Colors.white, fontFamily: "PopPins", fontSize: 20),textAlign: TextAlign.left,)
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Icon(
                  Icons.star, size: 30, color: Colors.green,),),
            ],
          )),
          ),Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white70),
              ),
            ),

            child:  ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  elevation: 0,
                ),
                onPressed: () {
                },
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Icon(
                        Icons.note_alt, size: 40, color: Colors.green,),),
                    Expanded(
                        child: InkWell(
                        onTap: (){
          Navigator.push(context,
          MaterialPageRoute(builder: (context) => cuestionario()));
                },
              child:
                        Text("Cuestionario de seguridad", style: TextStyle(color: Colors.white, fontFamily: "PopPins", fontSize: 20),textAlign: TextAlign.left,)
                    )),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Icon(
                        Icons.star, size: 30, color: Colors.green,),),
                  ],
                )),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white70),
              ),
            ),

            child:  ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  elevation: 0,
                ),
                onPressed: () {
                },
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Icon(
                        Icons.note_alt, size: 40, color: Colors.white,),),
                    Expanded(
                        child:Text("Cuestionario de protoclos", style: TextStyle(color: Colors.white, fontFamily: "PopPins", fontSize: 20),textAlign: TextAlign.left,)
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Icon(
                        Icons.star, size: 30, color: Colors.white,),),
                  ],
                )),
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Column(
                  children:[
                    Text("Tu proceso: 66%", style: TextStyle(color: Colors.white, fontFamily: "PopPins", fontSize: 20, fontWeight:FontWeight.bold),textAlign: TextAlign.center,),
                    LinearPercentIndicator(
                        width: 370.0,
                        lineHeight: 20,
                        percent: 0.66,
                        progressColor: Color.fromRGBO(70, 165, 37, 1)
                    )
                  ]

              ))],
      ),
      floatingActionButton:FloatingActionButton(
        child: Icon(Icons.qr_code_scanner),
        backgroundColor: Colors.green,
        onPressed:(){
          openDialog3();
        },
      ) ,
    );
  }

  Widget _getCard(BuildContext context){
    return Container(
        width: 100,
        height: 150,
        padding:const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Card(
          margin: const EdgeInsets.only(left: 30.0, right: 30.0),
          color: Colors.grey[850],
          elevation: 30,
          child: Column(
            children: <Widget>[
              Text(
                  'Platica de seguirdad',style:TextStyle(fontSize: 20, color: Colors.white)),
              Row(
                children:<Widget> [

                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.grey[900],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text(
                        'Ver',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        //Navigator.push(context,
                        // MaterialPageRoute(builder: (context) => Pagina02()));
                      }),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(112, 173, 71, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text(
                        '50&',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        //Navigator.push(context,
                        // MaterialPageRoute(builder: (context) => Pagina02()));
                      }),
                  Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 30,
                  )
                ],
              ),

            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ));
  }

  Widget _getDrawer(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.grey[850],
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Color.fromRGBO(112, 173, 71, 1)),
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/alumno.png',
                    width: 100,
                    height: 100,
                  ),
                  Text(
                    'Nombre del maestro',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ],
              ),
            ),
            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
            ),
            ListTile(
              title: Text('Materias'),
              leading: Icon(Icons.home),
            ),
          ],
        ));
  }

  Future<bool?> openDialog3()=> showDialog<bool>(

    context: context,
    builder: (context)=>AlertDialog(
      backgroundColor: Color.fromRGBO(23, 32, 42, 1),
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),),
      title: Text("Escaner de enlaces", style: TextStyle(color: Colors.white)),
      content: Container(
        height: 200,
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10)),
            Text("Escanea el código QR del documento o vídeo", style: TextStyle(color: Colors.white)),

            Container(
                margin:  const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 50,
                  child: Center(child: IconButton(iconSize:60,icon: Icon(Icons.qr_code_scanner,color: Colors.white), onPressed: () {  },)),
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
  /*
  void _launchUrl() async {
    String resultado = "";
    String? cameraScanResult = await scanner.scan();
    resultado = cameraScanResult!;
    Uri _url = Uri.parse(resultado);
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }

   */
}