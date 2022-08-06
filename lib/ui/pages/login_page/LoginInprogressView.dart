import 'package:collegenius/ui/common_widgets/CommonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginInprogressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Center(
      child: Padding(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('COLLEGENIUS', style: _theme.textTheme.displaySmall),
                Text(
                  'The application for students in NCU',
                  style: _theme.textTheme.bodyMedium,
                ),
                SizedBox(
                  height: 50,
                ),
                Loading(),
                SizedBox(
                  height: 150,
                ),
              ],
            ),
          )),
    );
  }
}
