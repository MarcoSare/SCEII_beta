import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../utils/userSimplePreferences.dart';
import '../../perfil.dart';
class AppBarHome extends StatelessWidget {
  userPreferences  UserPreferences = userPreferences();
  var base64Img;
  late Uint8List bytes;
  var nombre;
  var fotoPerfil;
  DateTime now = new DateTime.now();

  @override
  Widget build(BuildContext context) {


    return
      FutureBuilder(
          future: initData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                {
                  return Center(
                      child: Center(child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color> (Colors.green),
                      )));
                }
              case ConnectionState.done:
                {
                  return Container(
                    padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                    height: 200,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.1, 0.6],
                        colors: [
                          Color.fromRGBO(23, 32, 42, 1),
                          Color.fromRGBO(10, 20, 30, 1),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "SCEII",
                          style: TextStyle(color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hola "+ nombre+"\n"+ getHora(),
                              style: TextStyle(color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Container(
                              height: 60,
                              width: 70,

                              child: ElevatedButton(

                                  style: ElevatedButton.styleFrom(
                                      elevation: 0.0,
                                      primary: Colors.transparent,
                                      shadowColor: Colors.transparent,

                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(60))),
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => perfil()));
                                  },
                                  child:  CircleAvatar(
                                    backgroundColor: Color.fromRGBO(23, 32, 42, 1),
                                    radius: 60,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 60,
                                      backgroundImage: NetworkImage(fotoPerfil),
                                    ),
                                  )
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }

            }
          }
      );
  }

  initData() async {
    fotoPerfil = await UserPreferences.getfotoPerfil();
    //bytes = base64Decode(base64Img);
    nombre = await UserPreferences.getNombre();
  }


  String getHora(){
    String fecha = this.now.toString();
    String strHora = fecha.split(" ")[1].split(":")[0];
    int hora = int.parse(strHora);

    if(hora>=7 && hora<=11)
      return "Buenos Dias";
    else
    if(hora>=12 && hora<=18)
      return "Buenas tardes";
    else
      return "Buenas noches";
  }
}

/*

BottomNavigationBar(
        elevation: 0,
        currentIndex: _currentIndex,
        backgroundColor: Color.fromRGBO(23, 32, 42, 0.5),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color.fromRGBO(70, 165, 37, 1),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(fontFamily: 'Poppins'),
        unselectedLabelStyle: TextStyle(fontFamily: 'Poppins'),
        //showSelectedLabels: false,
        //showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.home,
                  color: _currentIndex == 0 ? Color.fromRGBO(70, 165, 37, 1) : Colors.grey
              ),
              label: "home",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.format_list_bulleted,
                  color: _currentIndex == 1 ? Color.fromRGBO(70, 165, 37, 1) : Colors.grey
              ),
              label: "Prestamos"
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.settings,
                  color: _currentIndex == 2 ? Color.fromRGBO(70, 165, 37, 1): Colors.grey
              ),
              label: "Configuracion"
          ),
        ],
        onTap: (int index){
          setState(() {
            _currentIndex = index;
            print(_currentIndex);
          });
        },

      )

class listMaterias extends StatelessWidget {
  List lista;

  listMaterias(this.lista);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: lista.length,
        itemBuilder: (BuildContext context, int i) {
          return BounceInLeft(
              delay: Duration(microseconds: 100 * i),
              child: _getCard(context, lista[i]['nombre'],
                  "https://krear3d.com/wp-content/uploads/2019/08/procesos-de-manufactura-tradicional.jpg")
          );
        }
    );
  }

  Widget _getCard(BuildContext context, String nombre, String linkImg) {
    return Container(
        width: 100,
        height: 150,
        margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              image: NetworkImage(linkImg),
              //image: AssetImage("assets/materia1.jpg"),
              fit: BoxFit.cover
          ),

        ),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black
                    ]
                )),
            child:
            InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => laboratorio()));
                },
                child:
                Card(
                  margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                  color: Colors.transparent,
                  elevation: 0,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                          children: <Widget>[
                            Container(
                              width: 50,
                              height: 50,
                              child: Icon(Icons.star, size: 30,
                                  color: Colors.white),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.purple),
                            ),
                            Flexible(
                              child: Text(nombre,
                                  style: TextStyle(fontSize: 24,
                                      color: Colors.white,
                                      fontFamily: "Poppins")),
                            )
                          ])
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ))));
  }

}
 */

