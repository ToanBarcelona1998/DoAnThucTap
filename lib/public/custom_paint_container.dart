import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class MyPaint extends CustomPainter{
  List<Color> listColor;
  MyPaint({this.listColor=const [Colors.orange,Colors.lightGreenAccent]});
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Path path=Path()..moveTo(0.0, 0.0)
      ..lineTo(0.0, 3/4*size.height-70)
      ..cubicTo(0.0, size.height+20, size.width, size.height+20, size.width, 3/4*size.height-70)
      ..lineTo(size.width, 0.0)
      ..close();
    ;
    Paint paint=Paint()..style=PaintingStyle.fill..strokeWidth=2.0..shader=ui.Gradient.linear(Offset(0.0,0.0), Offset(size.width,size.height), listColor);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}