import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final color = Colors.white;
  final hoverColor = Colors.white70;
  final IconData icon;
  final String title;
  final void Function()? onTap;

  DrawerTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(color: color),
      ),
      hoverColor: hoverColor,
      onTap: onTap,
    );
  }
}
