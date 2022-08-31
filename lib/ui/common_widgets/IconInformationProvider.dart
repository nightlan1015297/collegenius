import 'package:flutter/material.dart';

/// TextInformationProvider provides an labeled text information.
/// See: https://github.com/nightlan1015297/collegenius/wiki/Icon-Information-Provider

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

  /// The text that is going to show on label.
  final String label;

  /// The MainAxisAlignment that wraps label text and information Icon.
  /// default is [MainAxisAlignment.center]
  final MainAxisAlignment mainAxisAlignment;

  /// Specified the [TextStyle] of label text.
  /// The default value is [labelLarge], it is better not to use large text
  /// to label. Such us [headline] level text.
  /// But overall, it is up to you. If [headline] level text makes perfect.
  /// Just use it.
  final TextStyle? labelTexttheme;

  /// Specified the Overflow behaview of label text, it is set to
  /// [TextOverflow.ellipsis] as default to prevent RenderFlexOverFlow.
  final TextOverflow labelTextOverFlow;

  /// Specified the maxline of label text,
  /// [Null] as default will render only 1 line as max.
  /// It is better not render more then 1 lines since label is just a
  /// "short" text that describe what information that information icon is
  /// going to show.
  final int? labelMaxLines;

  /// The information Icon that is going to provide a useful category
  /// information or status information to the user.
  final Icon informationIcon;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    /// Columns that wrap label text and information Icons together.
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label,
            maxLines: labelMaxLines,
            overflow: labelTextOverFlow,
            style: labelTexttheme ?? _theme.textTheme.labelLarge),

        /// Small padding to avoid crowded.
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: informationIcon,
        ),
      ],
    );
  }
}
