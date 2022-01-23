import 'package:flutter/material.dart';
import 'dart:math';

enum CourseStatusCardState { processing, complete, warning }

class CourseStatusCard extends StatelessWidget {
  CourseStatusCard({
    Key? key,
  }) : super(key: key);

  final _state = CourseStatusCardState.processing;

  List<int> timeFormatter(int second) {
    final hour = 3600;
    final min = 60;
    final _hour = second ~/ hour;
    second = second % hour;
    final _min = second ~/ min;
    second = second % min;

    return [_hour, _min, second];
  }

  Widget timeWidget(List<int> formattedTime, String suffix) {
    return Row(
      children: [
        Text(formattedTime[0].toString(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('小時',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              )),
        ),
        Text(formattedTime[1].toString(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('分',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              )),
        ),
        Text(formattedTime[2].toString(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('秒' + suffix,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              )),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      final _backgroundColor;
      final _iconColor;
      final _status;
      final _theme = Theme.of(context);

      if (_state == CourseStatusCardState.processing) {
        _backgroundColor = Colors.blue.shade100;
        _iconColor = Colors.blue;

        final _courseName = "普通物理學";
        final _remainTime = 45 * 60 + 25;
        final _timeParsed = timeFormatter(_remainTime);

        _status = Row(
          children: <Widget>[
            SizedBox(
              width: 50,
              height: 50,
              child: Stack(
                children: [
                  Center(child: DottedNode()),
                  Center(
                    child: Icon(
                      Icons.arrow_forward_outlined,
                      color: _iconColor,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 15),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('正在進行',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    )),
                SizedBox(
                  width: constrains.maxWidth - 126,
                  child: Text(_courseName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      )),
                ),
                timeWidget(_timeParsed, '後結束')
              ],
            ),
          ],
        );
      } else if (_state == CourseStatusCardState.complete) {
        _backgroundColor = Colors.green.shade100;
        _iconColor = Colors.green;
        _status = Row(
          children: <Widget>[
            Icon(
              Icons.task_alt_outlined,
              color: _iconColor,
              size: 50,
            ),
            SizedBox(width: 10),
            Text('本日課程已完成',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                )),
          ],
        );
      } else if (_state == CourseStatusCardState.warning) {
        _backgroundColor = Colors.orange.shade200;
        _iconColor = Colors.orange.shade800;
        final _courseName = "普通物理學";
        final _remainTime = 45 * 60 + 25;
        final _timeParsed = timeFormatter(_remainTime);
        _status = Row(
          children: <Widget>[
            Icon(
              Icons.warning_amber_outlined,
              color: _iconColor,
              size: 50,
            ),
            SizedBox(width: 15),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('下一堂',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    )),
                SizedBox(
                  width: constrains.maxWidth - 126,
                  child: Text(_courseName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      )),
                ),
                timeWidget(_timeParsed, '後開始')
              ],
            ),
          ],
        );
      } else {
        _backgroundColor = Colors.red.shade200;
        _iconColor = Colors.red;
        _status = Row(
          children: <Widget>[
            Text('Load Error',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                )),
          ],
        );
      }

      return Card(
        elevation: 5.0,
        color: _backgroundColor,
        margin: EdgeInsets.all(10.0),
        child: SizedBox(
          height: 165,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: <Widget>[
                    Text('課程狀態',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                        )),
                    Expanded(child: SizedBox()),
                    Icon(
                      Icons.chevron_right_outlined,
                      color: _theme.iconTheme.color,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: _status,
              ),
            ]),
          ),
        ),
      );
    });
  }
}

class DottedNodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double _circleRadius = 21;
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

class DottedNode extends StatefulWidget {
  const DottedNode({this.child});
  final Widget? child;

  @override
  _DottedNodeWidgetState createState() => _DottedNodeWidgetState();
}

class _DottedNodeWidgetState extends State<DottedNode>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    final _curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear);

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
    return Container(
      width: 20,
      height: 20,
      child: AnimatedBuilder(
        animation: _animationController.view,
        builder: (context, child) {
          return Transform.rotate(angle: _animation.value, child: child);
        },
        child: CustomPaint(
          child: widget.child,
          foregroundPainter: DottedNodePainter(),
        ),
      ),
    );
  }
}
