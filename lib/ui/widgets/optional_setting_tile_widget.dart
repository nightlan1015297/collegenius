import 'package:flutter/material.dart';

/*
Optional setting tile builder build the basic tile in setting seection
- setting tile includes Icon , title and current optional in tail of tile
*/

class OptionalSettingTileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String currentOption;

  final void Function() ontap;
  OptionalSettingTileWidget({
    required this.icon,
    required this.currentOption,
    required this.title,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return ListTile(
      leading: Icon(
        icon,
        color: _theme.iconTheme.color,
      ),
      title: Text(title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
      trailing: Text(
        currentOption,
        style: TextStyle(
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w600,
            fontSize: 14),
      ),
      onTap: ontap,
    );
  }
}
