import 'package:collegenius/routes/route_arguments.dart';
import 'package:collegenius/ui/pages/eeclass_page/EeclassPage.dart';
import 'package:collegenius/ui/pages/eeclass_page/EeclassQuizPopupDetailCard.dart';
import 'package:collegenius/ui/pages/home_page/HomePageView.dart';
import 'package:collegenius/ui/main_scaffold/MainScaffold.dart';
import 'package:collegenius/ui/pages/login_page/LoginPageView.dart';
import 'package:flutter/material.dart';

import 'hero_dialog_route.dart';

class AppRouter {
  Route generateRoute(RouteSettings routsettings) {
    switch (routsettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (contex) => MainScaffold(
            title: 'HomePage',
            body: HomePageView(),
          ),
        );
      case '/eeclassCourse':
        return MaterialPageRoute(
          builder: (contex) {
            final args = routsettings.arguments as EeclassCourseArguments;
            return EeclassCoursePage(
              courseSerial: args.courseSerial,
            );
          },
        );
      case '/eeclassCourse/popupInfo':
        return HeroDialogRoute(
          builder: (context) {
            final args = routsettings.arguments as EeclassPopupInfoArguments;
            return EeclassPopUpInformationCard(
              courseInformation: args.courseInfo,
            );
          },
        );
      case '/eeclassCourse/quizzes':
        return MaterialPageRoute(
          builder: (context) {
            final args = routsettings.arguments as EeclassQuizzesPageArguments;
            return EeclassQuizListView(
              quizList: args.quizList,
            );
          },
        );
      case '/eeclassCourse/quizzes/popup':
        return HeroDialogRoute(
          builder: (context) {
            final args = routsettings.arguments as EeclassQuizzPopupArguments;
            return EeclassQuizPopupDetailCard(
              quizUrl: args.quizUrl,
              heroKey: args.heroKey,
            );
          },
        );

      case '/eeclassCourse/materials':
        return MaterialPageRoute(
          builder: (context) {
            final args =
                routsettings.arguments as EeclassMaterialsPageArguments;
            return EeclassMaterialListView(
              materialList: args.materialList,
            );
          },
        );
      case '/eeclassCourse/assignments':
        return MaterialPageRoute(
          builder: (context) {
            final args =
                routsettings.arguments as EeclassAssignmentsPageArguments;
            return EeclassAssignmentsListView(
              assignmentList: args.assignmentList,
            );
          },
        );
      case '/login':
        return MaterialPageRoute(
          builder: (contex) => Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () => Navigator.pop(contex, false),
              ),
            ),
            body: LoginPageView(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (contex) => Scaffold(
            body: Center(
              child: Text(
                  'Route Error : No route defined for ${routsettings.name}'),
            ),
          ),
        );
    }
  }
}
