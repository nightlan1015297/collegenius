import 'package:flutter/material.dart';

class TextInformationProvider extends StatelessWidget {
  TextInformationProvider({
    Key? key,
    required this.label,
    required this.information,
    this.labelTexttheme,
    this.informationTexttheme,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.informationTextOverFlow = TextOverflow.ellipsis,
    this.labelTextOverFlow = TextOverflow.ellipsis,
    this.informationMaxLines,
    this.informationPadding,
    this.labelMaxLines,
    this.selectable = false,
  }) : super(key: key);
  final String label;
  final String information;
  final MainAxisAlignment mainAxisAlignment;
  final TextStyle? labelTexttheme;
  final TextStyle? informationTexttheme;
  final TextOverflow informationTextOverFlow;
  final TextOverflow labelTextOverFlow;
  final EdgeInsets? informationPadding;
  final int? informationMaxLines;
  final int? labelMaxLines;
  final bool selectable;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            maxLines: labelMaxLines,
            overflow: labelTextOverFlow,
            style: labelTexttheme ?? _theme.textTheme.labelLarge),
        selectable
            ? Padding(
                padding: informationPadding ?? EdgeInsets.zero,
                child: SelectableText(information,
                    style: informationTexttheme?.copyWith(
                            overflow: informationTextOverFlow) ??
                        _theme.textTheme.titleLarge!
                            .copyWith(overflow: informationTextOverFlow)),
              )
            : Padding(
                padding: informationPadding ?? EdgeInsets.zero,
                child: Text(information,
                    maxLines: informationMaxLines,
                    overflow: informationTextOverFlow,
                    style: informationTexttheme ?? _theme.textTheme.titleLarge),
              ),
      ],
    );
  }
}

class VerticalSeperater extends StatelessWidget {
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      width: 1.0,
      height: 40,
      color: _theme.iconTheme.color,
    );
  }
}
