import 'dart:math';

import 'package:flutter/material.dart';

class CircleDottedBorderPainter extends CustomPainter {
  const CircleDottedBorderPainter({required this.radius, this.colors});
  final double radius;
  final Color? colors;
  @override
  void paint(Canvas canvas, Size size) {
    final _center = Offset(size.width / 2, size.height / 2);
    final _circleradius = 2 * pi;
    final _paint = Paint()
      ..color = colors ?? Color.fromARGB(255, 255, 187, 28)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    for (double i = 0; i < 1; i += 1 / 50) {
      canvas.drawArc(
        Rect.fromCircle(center: _center, radius: radius),
        i * _circleradius,
        0.01 * _circleradius,
        false,
        _paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
