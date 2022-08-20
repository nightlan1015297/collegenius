import 'package:collegenius/routes/route_arguments.dart';
import 'package:collegenius/ui/pages/eeclass_page/EeclassAssignmentPopupDetailCard.dart';
import 'package:collegenius/ui/pages/eeclass_page/EeclassBullitinPopupDetailCard.dart';
import 'package:collegenius/ui/pages/eeclass_page/EeclassBullitinsListView.dart';
import 'package:collegenius/ui/pages/eeclass_page/EeclassPage.dart';
import 'package:collegenius/ui/pages/eeclass_page/EeclassQuizPopupDetailCard.dart';
import 'package:collegenius/ui/pages/home_page/HomePageView.dart';
import 'package:collegenius/ui/main_scaffold/MainScaffold.dart';
import 'package:collegenius/ui/pages/login_page/LoginPageView.dart';
import 'package:collegenius/ui/pages/login_page/LoginResultView.dart';
import 'package:collegenius/ui/pages/login_page/ManualLoginCard.dart';
import 'package:collegenius/ui/pages/setting_page/SettingPage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
            );
          },
        );
      case '/eeclassCourse/bullitins':
        return MaterialPageRoute(
          builder: (context) {
            final args =
                routsettings.arguments as EeclassBullitinsPageArguments;
            return EeclassBullitinListView(
              courseSerial: args.courseSerial,
            );
          },
        );
      case '/eeclassCourse/bullitins/popup':
        return HeroDialogRoute(
          builder: (context) {
            final args =
                routsettings.arguments as EeclassBulliitinsPopupArguments;
            return EeclassBullitinPopupDetailCard(
              bullitinBrief: args.bullitinBrief,
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
      case '/eeclassCourse/assignments/popup':
        return HeroDialogRoute(
          builder: (context) {
            final args =
                routsettings.arguments as EeclassAssignmentsPopupArguments;
            return EeclassAssignmentPopupDetailCard(
              assignmentBrief: args.assignmentBrief,
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

      case '/login/manual/courseSelect':
        return HeroDialogRoute(
          builder: (contex) {
            final _locale = AppLocalizations.of(contex)!;
            return CourseSelectManualLoginCard(
              systemname: _locale.coursePlanning,
            );
          },
        );
      case '/login/manual/eeclass':
        return HeroDialogRoute(builder: (contex) {
          final _locale = AppLocalizations.of(contex)!;
          return EeclassManualLoginCard(
            systemname: _locale.eeclass,
          );
        });
      case '/login/manual/portal':
        return HeroDialogRoute(builder: (contex) {
          final _locale = AppLocalizations.of(contex)!;
          return PortalManualLoginCard(
            systemname: _locale.portal,
          );
        });

      case '/login/failedMessage/courseSelect':
        final args = routsettings.arguments as LoginFailedArguments;
        return HeroDialogRoute(
          builder: (contex) => CourseSchedualLoginFailedMessage(
            err: args.err,
          ),
        );
      case '/login/failedMessage/eeclass':
        final args = routsettings.arguments as LoginFailedArguments;
        return HeroDialogRoute(
          builder: (contex) => EeclassLoginFailedMessage(
            err: args.err,
          ),
        );
      case '/login/failedMessage/portal':
        final args = routsettings.arguments as LoginFailedArguments;
        return HeroDialogRoute(
          builder: (contex) => PortalLoginFailedMessage(
            err: args.err,
          ),
        );

      case '/setting/theme':
        return HeroDialogRoute(
          builder: (contex) => ThemePopupSettingCard(),
        );
      case '/setting/appLang':
        return HeroDialogRoute(
          builder: (contex) => AppLanguagePopupSettingCard(),
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
