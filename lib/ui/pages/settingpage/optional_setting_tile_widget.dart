import 'package:flutter/material.dart';

/*
Optional setting tile builder build the basic tile in setting seection
- setting tile includes Icon , title and current optional in tail of tile
*/

class OptionalSettingTileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String currentoption;
  final String debugprint;
  final void Function() ontap;
  OptionalSettingTileWidget(
      {required this.icon,
      required this.currentoption,
      required this.title,
      required this.ontap,
      required this.debugprint});

  @override
  Widget build(BuildContext context) {
    print(debugprint);
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Text(currentoption),
      onTap: ontap,
    );
  }
}
