import 'dart:math';

import 'package:flutter/material.dart';

class NodeGraph extends StatelessWidget {
  final List<Widget> nodes;

  NodeGraph({
    required this.nodes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: nodes,
      ),
    );
  }
}

class TimeLineLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final _paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(size.width / 2, size.height), _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class TimeLineLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 16,
      height: 124,
      child: CustomPaint(
        foregroundPainter: TimeLineLinePainter(),
      ),
    );
  }
}

class TimeLineShortLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 16,
      height: 20,
      child: CustomPaint(
        foregroundPainter: TimeLineLinePainter(),
      ),
    );
  }
}

class TimeLineDottedLinePainter extends CustomPainter {
  TimeLineDottedLinePainter({
    required this.shiftPercent,
  });

  final double shiftPercent;

  @override
  void paint(Canvas canvas, Size size) {
    final _paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
    final double shiftPixel = shiftPercent * 14;

    for (double i = 0; i * 7 + shiftPixel < size.height; i++) {
      if (shiftPercent > 0.5) {
        canvas.drawLine(Offset(size.width / 2, 0),
            Offset(size.width / 2, shiftPixel - 7), _paint);
      }
      if (i % 2 == 0) {
        if (i * 7 + shiftPixel + 7 > size.height) {
          canvas.drawLine(Offset(size.width / 2, i * 7 + shiftPixel),
              Offset(size.width / 2, size.height), _paint);
        } else {
          canvas.drawLine(Offset(size.width / 2, i * 7 + shiftPixel),
              Offset(size.width / 2, i * 7 + shiftPixel + 7), _paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class TimeLineDottedLine extends StatefulWidget {
  @override
  State<TimeLineDottedLine> createState() => _TimeLineDottedLineState();
}

class _TimeLineDottedLineState extends State<TimeLineDottedLine>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    final _curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear);

    _animation = Tween<double>(begin: 0, end: 1).animate(_curvedAnimation);
    _animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 16,
      height: 124,
      child: AnimatedBuilder(
          animation: _animationController.view,
          builder: (context, child) {
            return CustomPaint(
              painter:
                  TimeLineDottedLinePainter(shiftPercent: _animation.value),
            );
          }),
    );
  }
}

class TimeLineNodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double _circleRadius = 8;
    final _center = Offset(size.width / 2, size.height / 2);
    final _paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(_center, _circleRadius, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class TimeLineNode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: CustomPaint(
        foregroundPainter: TimeLineNodePainter(),
      ),
    );
  }
}

class TimeLineDottedNodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double _circleRadius = 8;
    final _center = Offset(size.width / 2, size.height / 2);
    final _circleradius = 2 * pi;
    final _paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    for (double i = 0; i < 1; i += 0.2) {
      canvas.drawArc(
        Rect.fromCircle(center: _center, radius: _circleRadius),
        i * _circleradius,
        0.125 * _circleradius,
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

class TimeLineDottedNode extends StatefulWidget {
  @override
  _TimeLineDottedNodeWidgetState createState() =>
      _TimeLineDottedNodeWidgetState();
}

class _TimeLineDottedNodeWidgetState extends State<TimeLineDottedNode>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    final _curvedAnimation = CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOutQuad);

    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_curvedAnimation);
    _animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: AnimatedBuilder(
        animation: _animationController.view,
        builder: (context, child) {
          return Transform.rotate(angle: _animation.value, child: child);
        },
        child: CustomPaint(
          foregroundPainter: TimeLineDottedNodePainter(),
        ),
      ),
    );
  }
}
