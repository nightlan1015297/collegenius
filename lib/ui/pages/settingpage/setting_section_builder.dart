import 'package:flutter/material.dart';

Widget settingSectionBilder(
    {required String sectionname,
    required List<Widget> tiles,
    required BuildContext context}) {
  return Container(
    margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10.0),
        Container(
          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
          child:
              Text(sectionname, style: Theme.of(context).textTheme.headline5),
        ),
        Card(
          elevation: 5.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            children: deviderAdder(tiles: tiles),
          ),
        )
      ],
    ),
  );
}

List<Widget> deviderAdder({required List<Widget> tiles}) {
  if (tiles.length == 1) {
    return tiles;
  }
  List<Widget> result = [];
  final Widget seperator = Container(
    margin: const EdgeInsets.symmetric(horizontal: 8.0),
    width: double.infinity,
    height: 1.0,
    color: Colors.grey.shade400,
  );
  for (int i = 0; i < tiles.length - 1; i++) {
    result.add(tiles[i]);
    result.add(seperator);
  }
  result.add(tiles[tiles.length - 1]);
  return result;
}
