import 'package:flutter/material.dart';

class IconInformationProvider extends StatelessWidget {
  IconInformationProvider({
    Key? key,
    required this.label,
    required this.informationIcon,
    this.labelTexttheme,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.labelTextOverFlow = TextOverflow.ellipsis,
    this.labelMaxLines,
  }) : super(key: key);
  final String label;
  final MainAxisAlignment mainAxisAlignment;
  final TextStyle? labelTexttheme;
  final TextOverflow labelTextOverFlow;
  final int? labelMaxLines;
  final Icon informationIcon;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label,
            maxLines: labelMaxLines,
            overflow: labelTextOverFlow,
            style: labelTexttheme ?? _theme.textTheme.labelLarge),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: informationIcon,
        ),
      ],
    );
  }
}
