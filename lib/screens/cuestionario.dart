
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class cuestionario extends StatefulWidget {
  const cuestionario({Key? key}) : super(key: key);

  @override
  State<cuestionario> createState() => _cuestionarioState();
}

class _cuestionarioState extends State<cuestionario> {
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
            height: 650,
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                color: Color.fromRGBO(23, 32, 42, 1)
                  ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                    child:
                        Text("Cuestionario de seguridad", style: TextStyle(fontSize: 24, fontFamily: "PopPins", color: Colors.white, fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                    )
            ],
                ),
                Row(
                  children: [
                    Expanded(
                        child:
                        Text("Pregunta: 1/10", style: TextStyle(fontSize: 18, fontFamily: "PopPins", color: Colors.white, fontWeight: FontWeight.bold),textAlign: TextAlign.left,)
                    )
                  ],
                ),
                LinearPercentIndicator(
                    width: 350.0,
                    lineHeight: 20,
                    percent: 0.1,
                    progressColor: Color.fromRGBO(70, 165, 37, 1)
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  alignment: Alignment.center,
                  child:
                  Row(
                    children: [
                      Expanded(
                          child:
                          Text("¿Cuál de los siguientes materiales son necesarios para entrar la laborotario?", style: TextStyle(fontSize: 18, fontFamily: "PopPins", color: Colors.white, fontWeight: FontWeight.bold),textAlign: TextAlign.left,)
                      )
                    ],
                  ),


                ), Container(


                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: 500,
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        //margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: const Color.fromRGBO(70, 165, 37, 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            child: const Text(
                              'Botas',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                            onPressed: () {
                              //showAlu();
                            }),
                      ),
                      Container(
                        height: 50,
                        width: 500,
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        //margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: const Color.fromRGBO(70, 165, 37, 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            child: const Text(
                              'Lentes',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                            onPressed: () {
                              //showAlu();
                            }),
                      ),
                      Container(
                        height: 50,
                        width: 500,
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        //margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: const Color.fromRGBO(70, 165, 37, 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            child: const Text(
                              'Bata',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                            onPressed: () {
                              //showAlu();
                            }),
                      ),
                      Container(
                        height: 50,
                        width: 500,
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        //margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: const Color.fromRGBO(70, 165, 37, 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            child: const Text(
                              'Pulseras',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                            onPressed: () {
                              //showAlu();
                            }),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: IconButton(icon: Icon(Icons.skip_previous,size: 30,color:Colors.white), onPressed: () {  },),
                          ),
                          Expanded(
                            child: IconButton(icon: Icon(Icons.skip_next,size: 30,color:Colors.white), onPressed: () {  },),
                          )
                        ],
                      )
                    ],
                  )
                )

              ],
            ),

          ),

        ],
      ),

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
}