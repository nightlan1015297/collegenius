import 'package:collegenius/ui/common_widgets/CommonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EeclassUnauthticateView extends StatelessWidget {
  const EeclassUnauthticateView();

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _locale = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
                child: Icon(
                  Icons.warning_amber,
                  color: Color.fromARGB(255, 255, 187, 28),
                  size: 120,
                ),
              ),
              CustomPaint(painter: CircleDottedBorderPainter(radius: 70))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              _locale.eeclassNotLoginMessage,
              textAlign: TextAlign.center,
              style: _theme.textTheme.bodyLarge,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/login');
            },
            child: Text(_locale.login),
          )
        ],
      ),
    );
  }
}
