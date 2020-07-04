import 'package:flutter/material.dart';

class CurvePainter1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.purple.shade300;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.04, size.height * 0.96,
        size.width * 0.45, size.height * 0.96);
   path.quadraticBezierTo(size.width * 0.75, size.height * 0.949,
        size.width * 0.84, size.height * 1);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}