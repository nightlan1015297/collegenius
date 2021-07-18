import 'package:flutter/material.dart';

class SettingSectionWidget extends StatelessWidget {
  final String sectionname;
  final List<Widget> tiles;
  SettingSectionWidget({
    required this.sectionname,
    required this.tiles,
  });

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

  @override
  Widget build(BuildContext context) {
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
                Text(sectionname, style: Theme.of(context).textTheme.headline6),
          ),
          Card(
            child: Column(
              children: deviderAdder(tiles: tiles),
            ),
          )
        ],
      ),
    );
  }
}
