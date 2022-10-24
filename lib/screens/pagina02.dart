import 'package:flutter/material.dart';
import 'package:sceii/main.dart';

void main() => runApp(const Pagina02());

class Pagina02 extends StatefulWidget {
  const Pagina02({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Registro"),
            backgroundColor: Color.fromRGBO(112, 173, 71, 1)),
        backgroundColor: Colors.grey[900],
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      "assets/alumno.png",
                      width: 200,
                      height: 200,
                    )),
                Container(
                  margin: EdgeInsets.only(left: 30.0, right: 30.0),
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(112, 173, 71, 1))),
                      labelText: 'Nombre(s)',
                      labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 30.0, right: 30.0),
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(112, 173, 71, 1))),
                      labelText: 'Apellidos',
                      labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 30.0, right: 30.0),
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                    obscureText: true,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(112, 173, 71, 1))),
                      labelText: 'No. control',
                      labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 30.0, right: 30.0),
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                    obscureText: true,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(112, 173, 71, 1))),
                      labelText: 'Correo',
                      labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 30.0, right: 30.0),
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Semestre',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
                Container(
                    margin: EdgeInsets.only(left: 30.0, right: 30.0),
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: MyStatefulWidget()),
                Container(
                    margin: EdgeInsets.only(left: 30.0, right: 30.0),
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Carrera',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
                Container(
                  margin: EdgeInsets.only(left: 30.0, right: 30.0),
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: MyStatefulWidget2(),
                  //child: carrera(),
                ),
                Container(
                    height: 50,
                    margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(112, 173, 71, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: const Text('Registrar'),
                        onPressed: () {})),
              ],
            )));
  }

  void setState(Null Function() param0) {}

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String dropdownValue = '1';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      style: TextStyle(color: Colors.white, fontSize: 20),
      dropdownColor: Colors.grey[900],
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>[
        '1',
        '2',
        '3',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9',
        '10',
        '11',
        '12',
        'Otro'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class MyStatefulWidget2 extends StatefulWidget {
  const MyStatefulWidget2({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget2> createState() => _MyStatefulWidgetState2();
}

class _MyStatefulWidgetState2 extends State<MyStatefulWidget2> {
  String dropdownValue = 'Ingeniería Industrial';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      style: const TextStyle(color: Colors.white, fontSize: 20),
      dropdownColor: Colors.grey[900],
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>[
        'Licenciatura en administracion',
        'Ingeniería ambiental',
        'Ingeniería bioquímica',
        'Ingeniería electrónica',
        'Ingeniería en gestión empresarial',
        'Ingeniería Industrial',
        'Ingeniería mecánica',
        'Ingeniería mecatrónica',
        'Ingeniería en sistemas computacionales',
        'Ingeniería química'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
