import 'package:flutter/material.dart';

Widget crearFondo(BuildContext context) {
  final size = MediaQuery.of(context).size;

  final fondoMorado = Container(
    height: size.height * 1,
    width: double.infinity,
    decoration: BoxDecoration(
        gradient: LinearGradient(colors: <Color>[
      //Color.fromRGBO(63, 63, 150, 1.0),
      //Color.fromRGBO(90, 70, 120, 1.0)
      Color.fromRGBO(85, 170, 255, 1.0),
      Color.fromRGBO(255, 241, 255, 1.0)
    ])),
  );

  final circulo = Container(
    width: 100.0,
    height: 100.0,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05)),
  );

  return Stack(
    children: <Widget>[
      fondoMorado,
      Positioned(
        top: 90.0,
        left: 30.0,
        child: circulo,
      ),
      Positioned(
        top: -40.0,
        left: -30.0,
        child: circulo,
      ),
      Positioned(
        top: -50.0,
        left: -100.0,
        child: circulo,
      ),
      // Container(
      //   padding: EdgeInsets.only(top: 50.0),
      //   child: Column(
      //     children: <Widget>[
      //       Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
      //       SizedBox(
      //         height: 10.0,
      //         width: double.infinity,
      //       ),
      //       Text('sebastian ', style: TextStyle(color: Colors.white)),
      //     ],
      //   ),
      // )
    ],
  );
}
