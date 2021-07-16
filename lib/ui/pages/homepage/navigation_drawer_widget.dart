import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Color.fromRGBO(50, 75, 105, 1),
        child: ListView(
          children: <Widget>[
            buildItem(text: "People", icon: Icons.people),
          ],
        ),
      ),
    );
  }
}

Widget buildItem({required String text, required IconData icon}) {
  final color = Colors.white;
  final hoverColor = Colors.white70;
  return ListTile(
    leading: Icon(icon, color: color),
    title: Text(
      text,
      style: TextStyle(color: color),
    ),
    hoverColor: hoverColor,
    onTap: () {},
  );
}
