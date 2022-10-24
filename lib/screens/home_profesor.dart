import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sceii/models/alumnoDatos.dart';
import 'package:sceii/screens/lista_actividades.dart';
import 'package:sceii/screens/lista_alumnos.dart';
import 'package:sceii/screens/model%20widget/widget.dart';
import 'package:sceii/services/htpp_servicies/httpService.dart';
import '../models/alumno.dart';
import '../models/student.dart';

class homeDocente extends StatefulWidget {

  homeDocente({Key? key}) : super(key: key){}


  @override
  State<homeDocente> createState() => _homeDocenteState();
}

class _homeDocenteState extends State<homeDocente> {
  alumnoDatos alumDatos = alumnoDatos();
  late getDropdownButton listSemestre =
  getDropdownButton(alumDatos.semestres[0], alumDatos.semestres, alumDatos.semestre,"");
  late DropdownImg lisImg = DropdownImg();
  late textFormField codigo = textFormField("Nombre", "Ingrese el nombre de la materia",
      "", Icons.auto_stories,1,50);
  late List  listmateria= [];
  bool bandera=true;
  TextEditingController controlador = TextEditingController();
  http_request httpService = http_request();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var codigo;
    return Scaffold(
      backgroundColor: Color.fromRGBO(19, 20, 20, 1),
      appBar: AppBar(
          elevation: 0,
          title: Text("Home"),
          backgroundColor: Colors.transparent
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: _currentIndex,
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color.fromRGBO(112, 173, 71, 1),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.home,
                  color: _currentIndex == 0 ? Color.fromRGBO(112, 173, 71, 1) : Colors.grey
              ),
              label: "home"
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.settings,
                  color: _currentIndex == 1 ? Color.fromRGBO(112, 173, 71, 1) : Colors.grey
              ),
              label: "home"
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.face,
                  color: _currentIndex == 2 ? Color.fromRGBO(112, 173, 71, 1) : Colors.grey
              ),
              label: "Clases"
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.face,
                  color: _currentIndex == 3 ? Color.fromRGBO(112, 173, 71, 1) : Colors.grey
              ),
              label: "Clases"
          )
        ],
        onTap: (int index){
          setState(() {
            _currentIndex = index;
            print(_currentIndex);
          });
        },

      ),
      drawer: _getDrawer(context),
      body: ListView(
        //padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text("Laboratorios",style: TextStyle(color: Colors.white,fontSize: 26,fontFamily: "Poppins",fontWeight:FontWeight.bold),),
          ),
          FutureBuilder(
            future: getMateriasDocente(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.connectionState == ConnectionState.waiting)
                return Center(child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color> (Colors.green),
                ));
              else
              if(listmateria.length>0)
                return RefreshIndicator(
                    color: Colors.green,
                    backgroundColor: Colors.transparent,
                    onRefresh: () async {  setState(() async {
                      await getMateriasDocente();});  },
                    child: listMaterias(listmateria));
              //for(int i=0;listmateria.length>i;i++)
              else
                return Container(
                    padding: const EdgeInsets.fromLTRB(0, 100, 0, 50),
                    alignment: Alignment.center,
                    child: Column(
                        children: [
                          Image.asset(
                            'assets/sinMaterias.gif',
                            width: 205,
                            height: 205,
                          ),
                          Text(
                            "No tienes laboratorios",
                            style: TextStyle(color: Colors.white,fontFamily: "Poppins", fontSize: 26),
                          ),
                          Icon(Icons.help, color: Colors.white, size: 70,)
                        ]
                    ));

            },
          ),


        ],
      ),
      floatingActionButton:FloatingActionButton(
          child: Icon(Icons.add,size: 30,),
          backgroundColor: Color.fromRGBO(70, 165, 37, 1),
          onPressed:()async{
            await openDialog();
            print("sd");
            setState(()   {
              print("hola");
              listmateria;
            });
            print("NO KBRON");

          }

      ) ,
    );
  }
  @override
  void initState()  {
    getMateriasDocente();
    super.initState();
  }

  Future<void> getMateriasDocente() async {
    listmateria;
    print("once");
    print("l: " + listmateria.length.toString());
    bandera=false;
  }


  Future<bool?> openDialog()=> showDialog<bool>(

    context: context,
    builder: (context)=>AlertDialog(
      backgroundColor: Color.fromRGBO(23, 32, 42, 1),
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),),
      title: Text("Crear materia", style: TextStyle(color: Colors.white)),
      content: Container(
        height: 600,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0,5),
              child: codigo,),
            Text("Semestre", style: TextStyle(color: Colors.white)),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0,10),
              child: listSemestre,),
            lisImg
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
                'Cancelar',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              onPressed: () {
                //showAlu();
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
                'Inscribir',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              onPressed: () async {
                return  await addMateria();
              }
          ),
        ),
      ],
    ),
  );
  Future<void> incribir() async {
    bool ban = await veriMateria(controlador.text);
    if(ban){
      final response =
      await http.post(Uri.parse("http://192.168.1.106/api/inscribirMateria.php"),
          body:{
            "id_alumno": "1",
            "id_materia" : "2"
          }
      );
      listmateria= await getMateriasDocente() as List;
      Navigator.of(context).pop();
    }

    else
      print("la materia no existe");
  }



  Future<bool> veriMateria(String id) async {
    final response =
    await http.post(Uri.parse("http://192.168.1.106/api/buscaMateria.php"),
        body:{
          "id": id.toString(),
        }
    );
    var lista =  json.decode(response.body);
    if(lista.length==0)
      return false;
    else
      return true;
  }
  Future<void> addMateria() async {
    //await httpService.addMateria(codigo.controlador, "1", getSemestre());
  }

  String getSemestre(){
    if(listSemestre.control=="Otro")
      return "13";
    return listSemestre.control;
  }

  Widget _listImg(){
    return Container(
      width: 300,
      height: 100,
      child:  ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _getCard(context, "1", "https://www.news-medical.net/images/Article_Images/ImageForArticle_22064_16436342404173431.jpg"),
          _getCard(context, "2", "https://agendaeducativa.org/wp-content/uploads/2020/08/Matem%C3%A1tica-P%C3%A1ginas-web-850x560.jpg"),
          _getCard(context, "3", "https://www.unicoos.com/img/ogImages/quimica.png"),
          _getCard(context, "4", "https://cdn.euroinnova.edu.es/img/subidasEditor/1-1624276646.webp")
        ],
      ),
    );
  }

  Widget _getCard(BuildContext context, String nombre,String linkImg){
    return Container(
        width: 100,
        height: 50,
        margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        padding:const EdgeInsets.fromLTRB(0, 0, 0, 0),
        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              image: NetworkImage(linkImg),
              //image: AssetImage("assets/materia1.jpg"),
              fit:BoxFit.cover
          ),

        ),
        child:Container(
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
                              style: TextStyle(fontSize: 24, color: Colors.white,fontFamily: "Poppins")),
                        )])

                  /*ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.grey[900],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text(
                    'Ver datos',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    imprimirDatteles(profesor);
                    //Navigator.push(context,
                    // MaterialPageRoute(builder: (context) => Pagina02()));
                  })*/
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            )));
  }

  void imprimirDatteles(String profesor){
    print(profesor);
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

class listMaterias extends StatelessWidget{
  List lista;
  listMaterias(this.lista);
  @override
  Widget build(BuildContext context) {
    return Expanded  ( child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        itemCount: lista.length,
        itemBuilder: (BuildContext context, int i){

          return BounceInLeft(
              delay: Duration(microseconds: 100*i),
              child: _getCard(context, lista[i]['nombre'], "https://krear3d.com/wp-content/uploads/2019/08/procesos-de-manufactura-tradicional.jpg")
          );
        }
    ));
  }

  Widget _getCard(BuildContext context, String nombre,String linkImg){
    return Container(
        width: 100,
        height: 150,
        margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        padding:const EdgeInsets.fromLTRB(0, 0, 0, 0),
        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              image: NetworkImage(linkImg),
              //image: AssetImage("assets/materia1.jpg"),
              fit:BoxFit.cover
          ),

        ),
        child:Container(
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
                              style: TextStyle(fontSize: 24, color: Colors.white,fontFamily: "Poppins")),
                        )])

                  /*ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.grey[900],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text(
                    'Ver datos',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    imprimirDatteles(profesor);
                    //Navigator.push(context,
                    // MaterialPageRoute(builder: (context) => Pagina02()));
                  })*/
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            )));
  }

}
