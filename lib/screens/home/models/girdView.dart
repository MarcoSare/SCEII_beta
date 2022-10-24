import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';

import '../../../utils/responsive.dart';
import 'card.dart';

class GirdViewMaterias extends StatefulWidget {
 var data;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
 GirdViewMaterias(this.data);
  @override
  State<StatefulWidget> createState() => _GirdViewMateriasState();
//State<getDropdownButton> createState() => _getDropdownButtonState(sele);
}

class _GirdViewMateriasState extends State<GirdViewMaterias> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    bool isTablet = responsive.isTablet;
    double marginTB = responsive.dp(0.4);



    return  GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 20,
          mainAxisSpacing: 24,
        ),
        itemBuilder: (context, index) {
          return
            BounceInLeft(
                delay: Duration(microseconds: 100 * index),
                child: MateriaCard(
                    widget.data['data'][index]['nombre'],
                    widget.data['data'][index]['nombre_docente']
                )
            );
        },
        itemCount: widget.data['data'].length
    );
  }
}


class GirdViewLaboratorios extends StatefulWidget {
  var data;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GirdViewLaboratorios(this.data);
  @override
  State<StatefulWidget> createState() => _GirdViewLaboratoriosState();
//State<getDropdownButton> createState() => _getDropdownButtonState(sele);
}

class _GirdViewLaboratoriosState extends State<GirdViewLaboratorios> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    bool isTablet = responsive.isTablet;
    double marginTB = responsive.dp(0.4);



    return  GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 20,
          mainAxisSpacing: 24,
        ),
        itemBuilder: (context, index) {
          return
            BounceInLeft(
                delay: Duration(microseconds: 100 * index),
                child: laboratorioCard(
                    int.parse(widget.data['data'][index]['id']),
                    widget.data['data'][index]['nombre'],
                    widget.data['data'][index]['jefe_laboratorio']
                )
            );
        },
        itemCount: widget.data['data'].length
    );
  }
}


class GirdViewPrestamos extends StatefulWidget {
  var data;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GirdViewPrestamos(this.data);
  @override
  State<StatefulWidget> createState() => _GirdViewPrestamosState();
//State<getDropdownButton> createState() => _getDropdownButtonState(sele);
}

class _GirdViewPrestamosState extends State<GirdViewPrestamos> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    bool isTablet = responsive.isTablet;
    double marginTB = responsive.dp(0.4);



    return  GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 20,
          mainAxisSpacing: 24,
        ),
        itemBuilder: (context, index) {
          return
            BounceInLeft(
                delay: Duration(microseconds: 100 * index),
                child: prestamoCard(
                    widget.data['data'][index]['id'],
                    widget.data['data'][index]['nombre_herramienta'],
                    widget.data['data'][index]['fecha_Fin'].toString(),
                    widget.data['data'][index]['fecha_Ini'].toString()
                )
            );
        },
        itemCount: widget.data['data'].length
    );
  }
}
