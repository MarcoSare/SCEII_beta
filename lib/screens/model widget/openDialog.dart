import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../utils/responsive.dart';




class openDialogSuccess extends StatefulWidget {
  late String titulo;
  late String mensaje;
  openDialogSuccess(this.titulo,this.mensaje){}

  @override
  State<openDialogSuccess> createState() => _openDialogSuccessState();
}

class _openDialogSuccessState extends State<openDialogSuccess> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final isTablet = responsive.isTablet;
    return AlertDialog(
      backgroundColor: Color.fromRGBO(23, 32, 42, 1),
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),),
      title: Text(widget.titulo, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: isTablet?responsive.dp(2):responsive.dp(2.5),fontFamily: "PopPins")),
      content: Container(
        height: responsive.dp(30),
        child: Column(
          children: [
            Text(widget.mensaje, style: TextStyle(color: Colors.white, fontSize: isTablet?responsive.dp(1.5):responsive.dp(2),fontFamily: "PopPins")),
            Container(
              margin: EdgeInsets.fromLTRB(responsive.dp(0.5), responsive.dp(2), responsive.dp(0.5), responsive.dp(0.5)),
              child: Icon(Icons.check_circle, size: responsive.dp(10),
                  color: Colors.white),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green),
            )
          ],
        ),
      ),
      actions: [
        Container(
          height: 40,
          width: 110,
          //padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          //margin: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(112, 173, 71, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child:  Text(
                'Aceptar',
                style: TextStyle(color: Colors.white, fontSize: isTablet?responsive.dp(1.5):responsive.dp(2),fontFamily: "PopPins"),
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
      ],
    );
  }
}

class openDialogError extends StatefulWidget {
  late String titulo;
  late String mensaje;
  openDialogError(this.titulo,this.mensaje){}

  @override
  State<openDialogError> createState() => _openDialogErrorState();
}

class _openDialogErrorState extends State<openDialogError> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final isTablet = responsive.isTablet;
    return AlertDialog(
      backgroundColor: Color.fromRGBO(23, 32, 42, 1),
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),),
      title: Text(widget.titulo, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: isTablet?responsive.dp(2):responsive.dp(2.5),fontFamily: "PopPins")),
      content: Container(
        height: responsive.dp(30),
        width: double.maxFinite,
        child: ListView(
          children: [
            Text(widget.mensaje, style: TextStyle(color: Colors.white, fontSize: isTablet?responsive.dp(1.5):responsive.dp(2),fontFamily: "PopPins")),
            Container(
              margin: EdgeInsets.fromLTRB(responsive.dp(0.5), responsive.dp(2), responsive.dp(0.5), responsive.dp(0.5)),
              child: Icon(Icons.error, size: responsive.dp(10),
                  color: Colors.white),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red),
            )
          ],
        ),
      ),
      actions: [
        Container(
          height: 40,
          width: 110,
          //padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          //margin: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(112, 173, 71, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child:  Text(
                'Aceptar',
                style: TextStyle(color: Colors.white, fontSize: isTablet?responsive.dp(1.5):responsive.dp(2),fontFamily: "PopPins"),
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
      ],
    );
  }


}