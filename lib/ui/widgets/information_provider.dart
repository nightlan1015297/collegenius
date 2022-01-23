import 'package:flutter/material.dart';

class InformationProvider extends StatelessWidget {
  InformationProvider({
    Key? key,
    required this.label,
    required this.information,
    this.labelTexttheme,
    this.informationTexttheme,
    this.mainAxisAlignment,
  }) : super(key: key);
  final String label;
  final String information;
  MainAxisAlignment? mainAxisAlignment;
  TextStyle? labelTexttheme;
  TextStyle? informationTexttheme;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    labelTexttheme = labelTexttheme ?? _theme.textTheme.caption;
    informationTexttheme = informationTexttheme ?? _theme.textTheme.headline5;
    return Column(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, overflow: TextOverflow.ellipsis, style: labelTexttheme),
        Text(information,
            overflow: TextOverflow.ellipsis, style: informationTexttheme)
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
