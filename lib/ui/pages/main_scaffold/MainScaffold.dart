import 'package:flutter/material.dart';

import 'drawer_tile_widget.dart';
import 'navigation_drawer_widget.dart';

class MainScaffold extends StatelessWidget {
  final String title;
  final Widget body;

  MainScaffold({
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      drawer: NavigationDrawer(
        tiles: [
          DrawerTile(
            icon: Icons.people,
            title: "People",
            onTap: () {},
          ),
          DrawerTile(
            icon: Icons.settings,
            title: "Setting",
            onTap: () => Navigator.of(context).pushNamed("/setting"),
          ),
        ],
      ),
      body: body,
      bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(),
              padding: EdgeInsets.all(10),
              child: IconButton(
                icon: Icon(
                  Icons.home_outlined,
                  size: 30,
                ),
                onPressed: () {},
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(),
              padding: EdgeInsets.all(10),
              child: IconButton(
                icon: Icon(
                  Icons.directions_bus_outlined,
                  size: 30,
                ),
                onPressed: () {},
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(),
              padding: EdgeInsets.all(10),
              child: IconButton(
                icon: Icon(
                  Icons.event_note_outlined,
                  size: 30,
                ),
                onPressed: () {},
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(),
              padding: EdgeInsets.all(10),
              child: IconButton(
                icon: Icon(
                  Icons.home,
                  size: 30,
                ),
                onPressed: () {},
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(),
              padding: EdgeInsets.all(10),
              child: IconButton(
                icon: Icon(
                  Icons.home,
                  size: 30,
                ),
                onPressed: () {},
              ),
            ),
          ]),
    );
  }
}
