import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      primaryColor: Colors.blue,
      backgroundColor: Colors.white,
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
        subtitle2: TextStyle(color: Colors.grey.shade600),
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 5.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      iconTheme: IconThemeData(
        color: Colors.grey.shade700,
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      primaryColor: Colors.blueGrey,
      backgroundColor: Colors.black,
      scaffoldBackgroundColor: Colors.black54,
      textTheme: TextTheme(
        headline1: TextStyle(color: Colors.white),
        headline2: TextStyle(color: Colors.white),
        headline3: TextStyle(color: Colors.white),
        headline4: TextStyle(color: Colors.white),
        headline5: TextStyle(color: Colors.white),
        headline6: TextStyle(color: Colors.white),
        bodyText1: TextStyle(color: Colors.white),
        bodyText2: TextStyle(color: Colors.white),
        subtitle1: TextStyle(color: Colors.white),
        subtitle2: TextStyle(color: Colors.grey.shade200),
      ),
      cardTheme: CardTheme(
        color: Colors.grey.shade900,
        elevation: 5.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      iconTheme: IconThemeData(
        color: Colors.grey.shade200,
      ),
    );
  }
}
