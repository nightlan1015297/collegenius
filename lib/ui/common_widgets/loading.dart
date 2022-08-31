import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({
    Key? key,
    this.size = 80,
    this.color = Colors.blue,
  }) : super(key: key);
  final double size;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SpinKitSpinningLines(
      color: color,
      size: size,
      duration: Duration(milliseconds: 2000),
    );
  }
}
