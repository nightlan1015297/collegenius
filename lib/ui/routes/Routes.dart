import 'package:collegenius/ui/pages/HomePageBody.dart';
import 'package:collegenius/ui/main_scaffold/MainScaffold.dart';
import 'package:collegenius/ui/pages/LoginPageBody.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route generateRoute(RouteSettings routsettings) {
    switch (routsettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => MainScaffold(
            title: 'HomePage',
            body: HomePageBody(),
          ),
        );
      case '/login':
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () => Navigator.pop(_, false),
              ),
            ),
            body: LoginPageBody(),
          ),
        );
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
