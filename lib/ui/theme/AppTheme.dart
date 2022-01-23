import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      fontFamily: 'NotoSans',
      primaryColor: Colors.grey.shade200,
      backgroundColor: Colors.grey.shade200,
      scaffoldBackgroundColor: Colors.grey.shade200,
      textTheme: TextTheme(
        headline1: TextStyle(color: Colors.black),
        headline2: TextStyle(color: Colors.black),
        headline3: TextStyle(color: Colors.black),
        headline4: TextStyle(color: Colors.black),
        headline5: TextStyle(color: Colors.black),
        headline6: TextStyle(color: Colors.black),
        bodyText1: TextStyle(color: Colors.black),
        bodyText2: TextStyle(color: Colors.black),
        subtitle1: TextStyle(color: Colors.black),
        subtitle2: TextStyle(color: Colors.black),
        caption: TextStyle(color: Colors.black),
      ),
      cardColor: Colors.blueGrey.shade50,
      cardTheme: CardTheme(
        color: Colors.blueGrey.shade50,
        elevation: 7.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      iconTheme: IconThemeData(
        color: Colors.grey.shade800,
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      fontFamily: 'NotoSans',
      primaryColor: Colors.grey.shade800,
      backgroundColor: Colors.grey.shade800,
      scaffoldBackgroundColor: Colors.grey.shade900,
      textTheme: TextTheme(
        headline1: TextStyle(color: Colors.white70),
        headline2: TextStyle(color: Colors.white70),
        headline3: TextStyle(color: Colors.white70),
        headline4: TextStyle(color: Colors.white70),
        headline5: TextStyle(color: Colors.white70),
        headline6: TextStyle(color: Colors.white70),
        bodyText1: TextStyle(color: Colors.white70),
        bodyText2: TextStyle(color: Colors.white70),
        subtitle1: TextStyle(color: Colors.white70),
        subtitle2: TextStyle(color: Colors.white70),
        caption: TextStyle(color: Colors.white70),
      ),
      cardColor: Colors.grey.shade800,
      cardTheme: CardTheme(
        color: Colors.grey.shade800,
        elevation: 7.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      iconTheme: IconThemeData(
        color: Colors.grey.shade200,
      ),
    );
  }
}
