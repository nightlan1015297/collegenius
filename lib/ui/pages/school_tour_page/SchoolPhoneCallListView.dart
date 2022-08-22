import 'package:collegenius/ui/common_widgets/CommonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SchoolPhoneCallListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: _theme.textTheme.headline6,
        title: Text(_locale.schoolTourMap),
        iconTheme: _theme.iconTheme,
        leading: BackButton(
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Column(
        children: [Card()],
      ),
    );
  }
}
