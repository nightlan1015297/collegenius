import 'package:collegenius/ui/pages/homepage/drawer_tile_widget.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
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
          ),
        ],
      ),
    );
  }
}
