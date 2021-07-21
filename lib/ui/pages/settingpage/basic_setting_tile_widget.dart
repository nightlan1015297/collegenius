import 'package:flutter/material.dart';

/*
Basic setting tile widget build the basic tile in setting seection
- setting tile includes Icon , title and decoration in tail of tile
*/

class BasicSettingTileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function() ontap;

  BasicSettingTileWidget({
    required this.icon,
    required this.title,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: ontap,
    );
  }
}
