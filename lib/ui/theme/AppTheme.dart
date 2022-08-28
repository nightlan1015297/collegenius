import 'dart:ui';

import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: 'NotoSans',
      primaryColor: Colors.white,
      backgroundColor: Colors.grey.shade300,
      scaffoldBackgroundColor: Colors.grey.shade300,
      appBarTheme: AppBarTheme(
        elevation: 5,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        color: Color.fromARGB(255, 248, 239, 185),
      ),
      iconTheme: IconThemeData(color: Colors.black),
      canvasColor: Colors.white,
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
