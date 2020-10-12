import 'package:circular_progress_widget/widgets/radial_progress.dart';
import 'package:flutter/material.dart';

class GraficasCircularesPage extends StatefulWidget {
  const GraficasCircularesPage({Key key}) : super(key: key);

  @override
  _GraficasCircularesPageState createState() => _GraficasCircularesPageState();
}

class _GraficasCircularesPageState extends State<GraficasCircularesPage> {
  double porcentaje = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        backgroundColor: Colors.blue,
        onPressed: (){
          porcentaje += 10;

          if(porcentaje >100){
            porcentaje=0.0;
          }
          setState(() {
            
          });
        }
        ),
      body: Center(
        child:Container(
         // color: Colors.blue,
          width: 200,
          height: 200,
          child: RadialProgress(porcentaje: porcentaje,colorllenado: Colors.red,mostrarPorcentaje: true, width: 200.0,),
        ),
      ),
    );
  }
}