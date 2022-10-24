// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:sceii/provider/theme_provider.dart';
import 'package:sceii/screens/Inicio/bienvenida.dart';
import 'package:sceii/screens/home/home_alumno.dart';
import 'package:sceii/screens/login.dart';
import 'package:sceii/utils/appSimplePreferences.dart';

import 'package:sceii/utils/userSimplePreferences.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await inicializacion(null);
  userPreferences preferences = userPreferences();
  appPreferences app_preferences = appPreferences();
  String token = await preferences.getLogin();
  bool sesion = await preferences.getSesion();
  bool prefBienvenida = await app_preferences.getbienvenida();
  bool theme = await app_preferences.getTheme();


  runApp(MyApp(token: token, sesion: sesion,prefBienvenida:prefBienvenida, theme:
  theme));
}

Future inicializacion(BuildContext context)  async{
  await Future.delayed(Duration(seconds: 1));
}

class MyApp extends StatefulWidget{
  MyApp({Key key, String this.token,bool this.sesion, bool this.prefBienvenida, bool this.theme }) : super(key: key);
  String token;
  bool sesion;
  bool prefBienvenida;
  bool theme;
  @override
  _MyAppState createState()=>_MyAppState();
  
}

class _MyAppState extends State<MyApp> {
  bool themeKey;
  
  @override
  void initState(){
    getTheme();
    super.initState();
  }



  @override
  Widget build(BuildContext context) => FutureBuilder(
  future: getTheme(),
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
  return OverlaySupport(child:
  ChangeNotifierProvider(
      create:  (context)=> ThemeProvider()..init(themeKey),
      builder: (context,_){
        final themeProvider = Provider.of<ThemeProvider>(context);
        return  MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate
          ],
          supportedLocales: [
            const Locale('es')
          ],
          title: "SCEII",
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: myThemes.lightTheme,
          darkTheme: myThemes.darkTheme,
          home: Scaffold(
              body:getBody()
            //homeAlumno()
            //login()//sideBarPerfil()
            //homeDocente()
          ),
        );
      }
  )


  );
  }
  }
  });



    Widget getBody(){
      if(widget.sesion)
       return homeAlumno();
      if(widget.prefBienvenida!=null)
        return login();
      else return bienvenida();
    }

    Future<void> getTheme() async {
      appPreferences app_preferences = appPreferences();
      themeKey = await app_preferences.getTheme();
    }




  //alumno getAlumno(){
    //alumno a = alumno("Marco","Ramirez","19030260@itcelaya.edu.mx","19030260","123","m","5","sistemas","199-10-25");
    //a.id=1;
    //return a;
  //}

/*

 */


}




