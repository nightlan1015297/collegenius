import 'package:flutter/material.dart';

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
