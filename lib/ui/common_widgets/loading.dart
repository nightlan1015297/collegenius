import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  Loading({
    Key? key,
    this.size = 150,
  }) : super(key: key);
  final double size;
  @override
  Widget build(BuildContext context) {
    return SpinKitSpinningLines(
      color: Colors.blue,
      duration: Duration(milliseconds: 1500),
      size: 120,
    );
  }
}
