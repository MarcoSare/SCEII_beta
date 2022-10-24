import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sceii/screens/home/home_alumno.dart';
import 'package:sceii/screens/recuperacion%20cuenta/recuperacion_cuenta.dart';
import 'package:sceii/screens/registro/register.dart';
import 'package:sceii/screens/model%20widget/widget.dart';
import 'package:sceii/utils/responsive.dart';
import 'package:sceii/utils/userSimplePreferences.dart';
import '../../provider/theme_provider.dart';
import '../../services/htpp_servicies/login.dart';
import '../../utils/appSimplePreferences.dart';
import '../login.dart';
import '../model widget/changeTheme.dart';
import '../model widget/openDialog.dart';


class bienvenida extends StatefulWidget {
  TextEditingController controlador = TextEditingController();

  var Alumno;
  bienvenida({Key? key}) : super(key: key){

  }
  @override
  State<bienvenida> createState() => _bienvenidaState();
}

  class _bienvenidaState extends  State<bienvenida> {
  int count =0;
  late AnimationController titleAnimation;
  late AnimationController msgAnimation;
  appPreferences app_preferences = appPreferences();
  var msgTitle = ["Bienvenido a SCEII\ndolorem app", "Lorem ipsum, consectetur\ndolorem app",
    "Vamos a empezar\ndolorem app"];
  var msg = ["Neque porro quisquam sit amet\nest qui dolorem ipsum.",
    "Sed ut perspiciatis unde omnis iste natus error\n sit voluptatem accusantium doloremque",
  "laudantium, totam rem aperiam, eaque ipsa quae ab\n illo inventore veritatis et quasi architecto beatae vitae"
  ];
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final isTablet = responsive.isTablet;
    return
      FadeInDown(
        delay: Duration(microseconds: 100), child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading:
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text((count+1).toString() + " / 3", style: TextStyle(color:Theme.of(context).primaryColorLight,fontSize: 18 ),textAlign: TextAlign.center)
            ],
          ),
          actions: [
            TextButton(onPressed: (){

            },
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Omitir", style: TextStyle(color:Theme.of(context).primaryColorDark ),)
                  ],
                )),

          ],
        ),
        body:  Column(
          children: [
        Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child:   Image.asset(
                    Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark?
                    'assets/logo_splash.png':'assets/logoLigthTheme.png',
                    width: responsive.wp(15),
                    height: responsive.hp(15),
                  ),
                ),
                Text(
                    "SCEII",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color:  Theme.of(context).primaryColorLight,
                        fontSize: 20
                    ))
              ],
            ),
          ),
            Container(
              margin: EdgeInsets.all(20),
              child: Center(
                child:  Image.asset(count==2?"assets/inicio2.gif":"assets/inicio.gif", height: 300,),
              ),),
            getMsgtitle(count),
            Spacer(),
            getMsg(count),
            Spacer(flex: 3),
            FittedBox(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColorDark,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () async {
                    if(count==2){
                      print("login");
                       await app_preferences.bienvenida();
                      Navigator.of(context, rootNavigator:
                      true).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                          login()), (route) => false);
                    }
                    else{
                      titleAnimation
                        ..reset()
                        ..forward();
                      msgAnimation
                        ..reset()
                        ..forward();
                      setState(() {
                        count++;
                        print(count);
                      });
                    }
                  },
                  child: Row(
                    children: [
                      Text(
                        count==2?
                        "Emepezar":"Siguiente",
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                            fontSize: 20
                        ),
                      ),
                      SizedBox(width:25),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Theme.of(context).primaryColorLight,
                      )
                    ],
                  )),
            )
          ],
        ),
      )
      );

  }

  Widget getMsgtitle(int count){
    return FadeInDown(
          animate: true,
            controller: (controller)=> titleAnimation = controller,
            delay: Duration(microseconds: 100), child:  Text(
            msgTitle[count],
            textAlign: TextAlign.center,
            style: TextStyle(
                color:  Theme.of(context).primaryColorLight,
                fontSize: 20
            )));
  }

  Widget getMsg(int count){
    return FadeInDown(
        animate: true,
        controller: (controller)=> msgAnimation = controller,
        delay: Duration(microseconds: 100), child:  Text(
        msg[count],
        textAlign: TextAlign.center,
        style: TextStyle(
            color:  Theme.of(context).primaryColorLight,
            fontSize: 14
        )));
  }


}
