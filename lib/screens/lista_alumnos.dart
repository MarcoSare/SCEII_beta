
import 'dart:ui';

import 'package:flutter/material.dart';

class listAlumnos extends StatefulWidget {
  const listAlumnos({Key? key}) : super(key: key);

  @override
  State<listAlumnos> createState() => _listAlumnosState();
}

class _listAlumnosState extends State<listAlumnos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(19, 20, 20, 1),
      /*appBar: AppBar(
        title: Text('Bienvenido'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          onPressed: () {},
        ),

      )*/
      drawer: _getDrawer(context),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
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
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Text("Lista de alumnos", style: TextStyle(fontSize: 28, color: Colors.white, fontFamily: "PopPins"),),
          ),
          _getCard(context,"https://upload.wikimedia.org/wikipedia/commons/1/19/Face-perfil.png","Johana Martina Reyes Rojas"),
          _getCard(context,"https://upload.wikimedia.org/wikipedia/commons/a/af/Tio_Douglas_Perfil.png","Luis David Garcia Ramirez")
        ],
      ),

    );
  }

  Widget _getCard(BuildContext context, String link, String nombre){
    return Container(
        width: 100,
        height: 110,
        padding:const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Card(
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),

          color: Color.fromRGBO(23, 32, 42, 1),
          elevation: 25,
          child: Column(
            children: <Widget>[
              Row(
          mainAxisAlignment: MainAxisAlignment.start,//Center Row contents horizontally,
          crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,
                children: <Widget>[
                  Container(
                    margin:const EdgeInsets.fromLTRB(20, 5, 10, 0),
                    child:CircleAvatar(
                      backgroundImage: NetworkImage(link),
                      radius: 40,
                      backgroundColor: Colors.transparent,
                    ) ,
                  ),
          Expanded(
            child:
            Text(
              nombre,style:TextStyle(fontSize: 18, color: Colors.white, fontFamily: "PopPins"),)
          )
                ],
              ),
            ]),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
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
