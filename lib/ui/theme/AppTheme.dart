import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
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
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 5.0,
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
      primaryColor: Colors.grey.shade800,
      backgroundColor: Colors.grey.shade800,
      scaffoldBackgroundColor: Colors.grey.shade900,
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
        subtitle2: TextStyle(color: Colors.white),
      ),
      cardTheme: CardTheme(
        color: Color.fromRGBO(48, 48, 48, 48),
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
