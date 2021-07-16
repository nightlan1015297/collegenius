import 'package:collegenius/ui/pages/homepage/Homepage.dart';
import 'package:collegenius/ui/pages/settingpage/SettingPage.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route generateRoute(RouteSettings routsettings) {
    switch (routsettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/setting':
        return MaterialPageRoute(builder: (_) => SettingPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                  'Route Error : No route defined for ${routsettings.name}'),
            ),
          ),
        );
    }
  }
}
