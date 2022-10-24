import 'package:intl/intl.dart';

class dateFormat {
  final f = new DateFormat('yyyy-MM-dd');

  String showDate(DateTime p_date) {
     String date = f.format(p_date).toString();
     var data = date.split("-");
    final mes = getMes(int.parse(data[1]));
    return data[2]+"/"+mes+"/"+data[0];
  }

  String getMes(int mes) {
    if (mes == 1)
      return "enero";
    else if (mes == 2)
      return "febrero";
    else if (mes == 3)
      return "marzo";
    else if (mes == 4)
      return "abril";
    else if (mes == 5)
      return "mayo";
    else if (mes == 6)
      return "junio";
    else if (mes == 7)
      return "julio";
    else if (mes == 8)
      return "agosto";
    else if (mes == 9)
      return "septiembre";
    else if (mes == 10)
      return "octubre";
    else if (mes == 11)
      return "noviembre";
    else
      return "diciembre";
  }

  int getDiferent(String fecha_inicio, String fecha_fin){
    print(fecha_inicio);
    print(fecha_fin);
    DateTime  fecInicio = DateTime.parse(fecha_inicio);
    DateTime  fecfin = DateTime.parse(fecha_fin);
    int difference = daysBetween(fecInicio, fecfin);
    print(difference);
    return difference;
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }


  }

