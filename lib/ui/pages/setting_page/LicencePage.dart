import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LicencePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return LicensePage(
        applicationName: "Collegenius",
        applicationIcon: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('images/collegenius.png')),
        applicationVersion: "0.0.1");
  }
}
