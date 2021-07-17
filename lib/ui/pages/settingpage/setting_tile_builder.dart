import 'package:flutter/material.dart';

/*
Setting tile builder build the basic tile in setting seection
- setting tile includes Icon , title and decoration in tail of tile
*/

Widget settingTileBilder(
    {required IconData icon,
    required String title,
    required void Function() ontap}) {
  return ListTile(
    leading: Icon(icon),
    title: Text(title),
    trailing: Icon(Icons.keyboard_arrow_right),
    onTap: ontap,
  );
}
