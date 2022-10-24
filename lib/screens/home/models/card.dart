import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../services/htpp_servicies/prestamos.dart';
import '../../../tools/Dateformat.dart';
import '../../laboratorio.dart';

class laboratorioCard extends StatelessWidget {
  laboratorioCard(this.id, this.nombre, this.nombreEncardo);
  String nombre;
  String nombreEncardo;
  int id;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>  Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  laboratorio(id: this.id,))),
      child: Container(
        padding:  EdgeInsets.fromLTRB(10,10,10,5),
        decoration: BoxDecoration(
          color:   Theme.of(context).primaryColor,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Image.network(
                'https://i.imgur.com/l5kHdYQ.jpeg',
                height: 100,
                width: 500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(this.nombre, style: TextStyle(fontSize: 14,color:  Theme.of(context).primaryColorLight,fontFamily: "Poppins",fontWeight: FontWeight.bold),),
            Text(this.nombreEncardo, style: TextStyle(fontSize: 12,color:  Theme.of(context).primaryColorLight,fontFamily: "Poppins",fontWeight: FontWeight.bold),),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    width: 30,
                    height: 30,
                    margin: EdgeInsets.fromLTRB(5, 3, 10, 10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green),
                    child: Icon(Icons.science, size: 20,
                        color: Colors.white)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MateriaCard extends StatelessWidget {

  MateriaCard(this.nombre, this.nombreDocente);
  String nombre;
  String nombreDocente;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('hola'),
      child: Container(
        padding:  EdgeInsets.fromLTRB(10,10,10,5),
        decoration: BoxDecoration(
          color:   Theme.of(context).primaryColor,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Image.network(
                'https://cdn.diferenciador.com/imagenes/materia-y-energia-og.jpg',
                height: 100,
                width: 500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(this.nombre, style: TextStyle(fontSize: 14,color:  Theme.of(context).primaryColorLight,fontFamily: "Poppins",fontWeight: FontWeight.bold),),
            Text(this.nombreDocente, style: TextStyle(fontSize: 12,color:  Theme.of(context).primaryColorLight,fontFamily: "Poppins",fontWeight: FontWeight.bold),),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    width: 30,
                    height: 30,
                    margin: EdgeInsets.fromLTRB(5, 3, 10, 10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.pink),
                    child: Icon(Icons.school, size: 20,
                        color: Colors.white)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class prestamoCard extends StatefulWidget {

  late String nombre_herramienta;
  late String fecha_limite;
  late String fecha_inicio;
  late String id_prestamo;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  prestamoCard(this.id_prestamo,this.nombre_herramienta, this.fecha_limite, this.fecha_inicio);
  @override
  State<StatefulWidget> createState() => _prestamoCardState();
//State<getDropdownButton> createState() => _getDropdownButtonState(sele);
}

class _prestamoCardState extends State<prestamoCard> {
  @override
  void initState() {
    super.initState();
    veriEstadoPrestamo();
  }

  prestamos_http prestamosHttp = prestamos_http();
  var data_prestamo;
  bool hasError = false;
  String msgError = "";
  int estadoPrestamo=0; //0 en tiempo, 1 proximo, 2 late 3 entregado
  var colores =[Color.fromRGBO(70, 165, 37, 1), Colors.amber, Color.fromRGBO(222, 23, 59, 1)];
  var estado = ["En tiempo","Próximo","Sin entregar"];
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () => print('hola'),
      child: Container(
        //padding:  EdgeInsets.fromLTRB(10,10,10,5),
        decoration: BoxDecoration(
          color:   Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.only(top: 10,bottom: 10),
                decoration: BoxDecoration(
                    color:  colores[estadoPrestamo],
                    borderRadius: BorderRadius.only( topRight: Radius.circular(20), topLeft: Radius.circular(20))
                ),
                child: Center(
                  child: Icon(Icons.handyman, size: 80, color: Colors.white,),
                )),
            Container(
                padding:  EdgeInsets.fromLTRB(10,10,10,5),
                child:Column(
                  children: [
                    Text(widget.nombre_herramienta, style: TextStyle(fontSize: 16,color:  Theme.of(context).primaryColorLight,fontFamily: "Poppins",fontWeight: FontWeight.bold),),
                    Text(widget.fecha_limite, style: TextStyle(fontSize: 14,color:  Theme.of(context).primaryColorLight,fontFamily: "Poppins",fontWeight: FontWeight.bold),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40))),
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
                    )
                  ],
                )
            )

          ],
        ),
      ),
    );
  }


  ///
  Future<Map<String, dynamic>> getOnePrestamo(String id) async {
    Map<String, dynamic> responde = await prestamosHttp.get_one_prestamo(id);
    data_prestamo = responde;
    if (data_prestamo.containsKey('error')) {
      hasError = true;
      msgError = data_prestamo['error'].toString();
    } else {
      veriEstadoPrestamo();
      hasError = false;
      msgError = "";
    }
    return responde;
  }

    veriEstadoPrestamo() {
      int dife = restaFecha(
          widget.fecha_inicio.toString(), widget.fecha_limite.toString());
      if (dife >= 0) {
        if (dife < 4)
          estadoPrestamo = 1;
        else
          estadoPrestamo = 0;
      } else
        estadoPrestamo = 2;
  }

  int restaFecha(String fecha_inicio, String fecha_fin) {
    dateFormat d = dateFormat();
    return d.getDiferent(fecha_inicio, fecha_fin);
  }





 Widget makeDismissible({required Widget child}) =>GestureDetector(
   behavior: HitTestBehavior.opaque,
   onTap: () => Navigator.pop(context),
   child: GestureDetector(onTap: (){},child: child,),
 );

 Widget builSheet() {
   return
     FutureBuilder(future: getOnePrestamo(widget.id_prestamo),
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
                     initialChildSize: 0.7,
                     minChildSize: 0.5,
                     maxChildSize: 0.7,

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
                                               color:   Theme.of(context).primaryColor,
                                               borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
                                           ),
                                           child: Center(child:Icon(Icons.handyman, color:  Theme.of(context).primaryColorLight, size: 150,),)
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
                                                 Text(data_prestamo["data"][0]["nombre_herramienta"],style: TextStyle(fontSize: 18,color:  Theme.of(context).primaryColorLight,fontFamily: "Poppins",fontWeight: FontWeight.bold),),
                                                 Container(
                                                   padding: EdgeInsets.all(5),
                                                   decoration: BoxDecoration(
                                                       color: colores[estadoPrestamo],
                                                       borderRadius: BorderRadius.all(Radius.circular(20))
                                                   ),
                                                   child:Text(estado[estadoPrestamo],style: TextStyle(fontSize: 14,color: Colors.white),),
                                                 )
                                               ],
                                             ),Row(
                                               mainAxisAlignment:
                                               MainAxisAlignment.start,
                                               children: [
                                                 Expanded(child:Text(data_prestamo["data"][0]["descripcion"],style: TextStyle(fontSize: 14,color:  Theme.of(context).primaryColorLight,fontWeight: FontWeight.bold),),
                                                 )
                                               ],
                                             ),
                                             getRowDetails(Icons.date_range_outlined,"Fecha de prestamo", data_prestamo["data"][0]["fecha_Ini"]),
                                             getRowDetails(Icons.date_range_outlined,"Fecha de devolución", data_prestamo["data"][0]["fecha_Fin"]),
                                             getRowDetails(Icons.science,"Laboratorio", data_prestamo["data"][0]["nombre_laboratorio"]),
                                             getRowDetails(Icons.person,"Jefe", data_prestamo["data"][0]["nombre_jefe"]),
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

 Widget getRowDetails(var icon, String label, String data){
   return Container(
     margin: EdgeInsets.all(10),
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
          Icon(icon, color:  Theme.of(context).primaryColorLight,size: 30),

   Expanded(child:Text(label,style: TextStyle(fontSize: 14,color:  Theme.of(context).primaryColorLight,fontFamily: "Poppins",fontWeight: FontWeight.bold),)),
         Expanded(child:Text(data,style: TextStyle(fontSize: 14,color:  Theme.of(context).primaryColorLight,fontFamily: "Poppins",fontWeight: FontWeight.bold),)),
   ]
     ),
   );
 }
}















/*
class prestamoCard extends StatelessWidget {

  prestamoCard(this.nombre_herramienta, this.fecha_limite);
  String nombre_herramienta;
  String fecha_limite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('hola'),
      child: Container(
        //padding:  EdgeInsets.fromLTRB(10,10,10,5),
        decoration: BoxDecoration(
          color:  Color.fromRGBO(23, 32, 42, 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 10,bottom: 10),
              decoration: BoxDecoration(
                color:  Color.fromRGBO(70, 165, 37, 1),
                  borderRadius: BorderRadius.only( topRight: Radius.circular(20), topLeft: Radius.circular(20))
              ),
              child: Center(
              child: Icon(Icons.handyman, size: 80, color: Colors.white,),
            )),
           Container(
               padding:  EdgeInsets.fromLTRB(10,10,10,5),
               child:Column(
                 children: [
                   Text(this.nombre_herramienta, style: TextStyle(fontSize: 16,color: Colors.white,fontFamily: "Poppins",fontWeight: FontWeight.bold),),
                   Text(this.fecha_limite, style: TextStyle(fontSize: 14,color: Colors.white,fontFamily: "Poppins",fontWeight: FontWeight.bold),),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: [
                       Container(
                         height: 40,
                         width: 40,
                         child: ElevatedButton(
                             style: ElevatedButton.styleFrom(
                                 primary: Colors.transparent,
                                 shadowColor: Colors.transparent,
                                 shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(40))),
                             onPressed: () {

                             },
                             child: Center(child:Icon(Icons.more_vert) ,)
                         ),
                       )
                     ],
                   )
                 ],
               )
           )

          ],
        ),
      ),
    );
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


}

 */