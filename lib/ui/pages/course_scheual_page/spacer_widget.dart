import 'package:flutter/material.dart';

class Space extends StatelessWidget {
  final double height;
  Space({required this.height});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
    );
  }
}
