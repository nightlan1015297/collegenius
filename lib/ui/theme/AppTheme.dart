import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: 'NotoSans',
      primaryColor: Colors.grey.shade200,
      backgroundColor: Colors.grey.shade200,
      cardTheme: CardTheme(
        elevation: 7.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'NotoSans',
      primaryColor: Colors.grey.shade800,
      backgroundColor: Colors.grey.shade800,
      scaffoldBackgroundColor: Colors.grey.shade900,
      cardTheme: CardTheme(
        color: Colors.grey.shade800,
        elevation: 7.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }
}
