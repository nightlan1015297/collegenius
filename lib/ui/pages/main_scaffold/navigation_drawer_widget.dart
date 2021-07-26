import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  final List<Widget> tiles;

  NavigationDrawer({required this.tiles});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: tiles,
            ),
          ),
        ],
      ),
    );
  }
}
