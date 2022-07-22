import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      fontFamily: 'NotoSans',
      primaryColor: Colors.grey.shade200,
      backgroundColor: Colors.grey.shade200,
      scaffoldBackgroundColor: Colors.grey.shade300,
      textTheme: TextTheme(
        displayLarge: TextStyle(color: Colors.black),
        displayMedium: TextStyle(color: Colors.black),
        displaySmall: TextStyle(color: Colors.black),
        headlineMedium: TextStyle(color: Colors.black),
        headlineSmall: TextStyle(color: Colors.black),
        titleLarge: TextStyle(color: Colors.black),
        titleMedium: TextStyle(color: Colors.black),
        titleSmall: TextStyle(color: Colors.black),
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black),
        bodySmall: TextStyle(color: Colors.black),
        labelSmall: TextStyle(color: Colors.black),
        labelMedium: TextStyle(color: Colors.black),
        labelLarge: TextStyle(color: Colors.black),
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
        displayLarge: TextStyle(color: Colors.white70),
        displayMedium: TextStyle(color: Colors.white70),
        displaySmall: TextStyle(color: Colors.white70),
        headlineMedium: TextStyle(color: Colors.white70),
        headlineSmall: TextStyle(color: Colors.white70),
        titleLarge: TextStyle(color: Colors.white70),
        titleMedium: TextStyle(color: Colors.white70),
        titleSmall: TextStyle(color: Colors.white70),
        bodyLarge: TextStyle(color: Colors.white70),
        bodyMedium: TextStyle(color: Colors.white70),
        bodySmall: TextStyle(color: Colors.white70),
        labelSmall: TextStyle(color: Colors.white70),
        labelMedium: TextStyle(color: Colors.white70),
        labelLarge: TextStyle(color: Colors.white70),
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
