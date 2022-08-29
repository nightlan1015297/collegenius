import 'package:flutter/material.dart';

class LicencePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LicensePage(
        applicationName: "Collegenius",
        applicationIcon: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('images/collegenius.png')));
  }
}
