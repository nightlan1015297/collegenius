import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      primaryColor: Colors.blue,
      backgroundColor: Colors.black,
      scaffoldBackgroundColor: Colors.purple,
    );
  }

  static ThemeData get night {
    return ThemeData();
  }
}
