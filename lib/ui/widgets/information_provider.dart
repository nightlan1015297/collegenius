import 'package:flutter/material.dart';

class InformationProvider extends StatelessWidget {
  const InformationProvider({
    Key? key,
    required this.label,
    required this.information,
    this.labelTexttheme,
    this.informationTexttheme,
  }) : super(key: key);

  final String label;
  final String information;
  final TextStyle? labelTexttheme;
  final TextStyle? informationTexttheme;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: labelTexttheme ?? _theme.textTheme.caption),
        Text(information,
            style: informationTexttheme ?? _theme.textTheme.headline5)
      ],
    );
  }
}

class VerticalSeperater extends StatelessWidget {
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      width: 1.0,
      height: 40,
      color: _theme.iconTheme.color,
    );
  }
}
