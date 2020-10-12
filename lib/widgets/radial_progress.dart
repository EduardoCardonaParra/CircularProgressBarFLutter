import 'dart:math';

import 'package:flutter/material.dart';

class RadialProgress extends StatefulWidget {


  final porcentaje;
  final Color colorllenado;
  final Color colorBase;
  final bool mostrarPorcentaje;
  final double width;

  const RadialProgress({ 
    @required this.porcentaje, 
    this.colorllenado = Colors.blue, 
    this.colorBase = Colors.grey, 
    this.mostrarPorcentaje = false, 
    this.width 
    }) ;

  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress> with SingleTickerProviderStateMixin{

  AnimationController controller;
  double porcentajeAnterior;

  @override
  void initState() { 
    porcentajeAnterior = widget.porcentaje;

    controller = new AnimationController(vsync: this, duration: Duration(milliseconds: 1000));


    super.initState();
    
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    controller.forward(from: 0.0);
    final diferenciaAnimar = widget.porcentaje - porcentajeAnterior;
    porcentajeAnterior = widget.porcentaje;
    return AnimatedBuilder(animation: controller, 
    builder: (BuildContext context, Widget child){
      return Stack(
        children:[ Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          height: double.infinity,
          
           child: CustomPaint(
              painter: _MiRadialProgres((widget.porcentaje - diferenciaAnimar)+(diferenciaAnimar * controller.value),
              widget.colorllenado,widget.colorBase,widget.mostrarPorcentaje),
            ),
          ),
          (widget.mostrarPorcentaje) ?Center(
            child: Container(
              //color: Colors.blue,
              width: size.width/2,
              height: size.height/2,
              child: Center(child: Text('${widget.porcentaje}%',style: TextStyle(fontSize: widget.width * 0.10),)),
            ),
          ) : Container(),
          ]
      );
      }
    );
    
    
    
    
  }
}


class _MiRadialProgres extends CustomPainter{
  final porcentaje;
  final Color colorLLenado;
  final Color colorBase;
  final bool mostrarPorcentaje;
 
  _MiRadialProgres( this.porcentaje, this.colorLLenado, this.colorBase, this.mostrarPorcentaje);

  @override
  void paint(Canvas canvas, Size size) {
      
      // Circulo base
      final paint = new Paint()
          ..strokeWidth =5
          ..color = colorBase
          ..style = PaintingStyle.stroke;

      final Offset center = new Offset(size.width /2, size.height/2);
      final double radio = min(size.width * 0.5, size.height * 0.5);

      canvas.drawCircle(center, radio, paint);

      // circulo llenado 

      final llenado = new Paint()
          ..strokeWidth =10
          ..color = colorLLenado
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

      // avance del llenado
      double arcAngle = 2 * pi  * (porcentaje /100);// vuelta completa 2+ pi

      canvas.drawArc(
      Rect.fromCircle(center: center,radius: radio),
        -pi /2,
        arcAngle, 
        false,
        llenado) ;

    }
  
    @override
    bool shouldRepaint(CustomPainter oldDelegate) => true;

}