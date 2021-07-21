import 'package:flutter/material.dart';

/*
IO setting tile widget build the I/O binary option tile in setting seection
- IO setting tile includes Icon , title and an I/O in tail of tile
*/
class IoSettingTileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final void Function(bool) ontap;

  IoSettingTileWidget({
    required this.icon,
    required this.title,
    required this.value,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      secondary: Icon(icon),
      title: Text(title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
      onChanged: ontap,
    );
  }
}
