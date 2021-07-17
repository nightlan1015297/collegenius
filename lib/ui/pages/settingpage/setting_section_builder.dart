import 'package:flutter/material.dart';

Widget settingSectionBilder(
    {required String sectionname, required List<Widget> tiles}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        margin: EdgeInsets.all(10),
        child: Text(sectionname),
      ),
      Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          children: tiles,
        ),
      )
    ],
  );
}
