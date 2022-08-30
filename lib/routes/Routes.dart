import 'package:collegenius/routes/route_arguments.dart';
import 'package:collegenius/ui/pages/eeclass_page/EeclassAssignmentPopupDetailCard.dart';
import 'package:collegenius/ui/pages/eeclass_page/EeclassBullitinPopupDetailCard.dart';
import 'package:collegenius/ui/pages/eeclass_page/EeclassBullitinsListView.dart';
import 'package:collegenius/ui/pages/eeclass_page/EeclassPage.dart';
import 'package:collegenius/ui/pages/eeclass_page/EeclassQuizPopupDetailCard.dart';
import 'package:collegenius/ui/pages/home_page/HomePageView.dart';
import 'package:collegenius/ui/pages/login_page/LoginPageView.dart';
import 'package:collegenius/ui/pages/login_page/LoginResultView.dart';
import 'package:collegenius/ui/pages/login_page/ManualLoginCard.dart';
import 'package:collegenius/ui/pages/setting_page/LicencePage.dart';
import 'package:collegenius/ui/pages/setting_page/SettingPage.dart';
import 'package:collegenius/ui/scaffolds/MainScaffold.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'hero_dialog_route.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings routsettings) {
    switch (routsettings.name) {
      case '/':
        return MaterialPageRoute(
            settings: RouteSettings(name: routsettings.name),
            builder: (contex) {
              final _locale = AppLocalizations.of(contex)!;
              return MainScaffold(
                title: _locale.home,
                body: HomePageView(),
              );
            });
      case '/eeclassCourse':
        return MaterialPageRoute(
          settings: RouteSettings(name: routsettings.name),
          builder: (contex) {
            final args = routsettings.arguments as EeclassCourseArguments;
            return EeclassCoursePage(
              courseSerial: args.courseSerial,
            );
          },
        );
      case '/eeclassCourse/popupInfo':
        return HeroDialogRoute(
          settings: RouteSettings(name: routsettings.name),
          builder: (context) {
            final args = routsettings.arguments as EeclassPopupInfoArguments;
            return EeclassPopUpInformationCard(
              courseInformation: args.courseInfo,
            );
          },
        );
      case '/eeclassCourse/quizzes':
        return MaterialPageRoute(
          settings: RouteSettings(name: routsettings.name),
          builder: (context) {
            final args = routsettings.arguments as EeclassQuizzesPageArguments;
            return EeclassQuizListView(
              quizList: args.quizList,
            );
          },
        );
      case '/eeclassCourse/quizzes/popup':
        return HeroDialogRoute(
          settings: RouteSettings(name: routsettings.name),
          builder: (context) {
            final args = routsettings.arguments as EeclassQuizzPopupArguments;
            return EeclassQuizPopupDetailCard(
              quizUrl: args.quizUrl,
            );
          },
        );
      case '/eeclassCourse/bullitins':
        return MaterialPageRoute(
          settings: RouteSettings(name: routsettings.name),
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
          settings: RouteSettings(name: routsettings.name),
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
          settings: RouteSettings(name: routsettings.name),
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
          settings: RouteSettings(name: routsettings.name),
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
          settings: RouteSettings(name: routsettings.name),
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
            settings: RouteSettings(name: routsettings.name),
            builder: (contex) {
              final _locale = AppLocalizations.of(contex)!;
              return Scaffold(
                appBar: AppBar(
                  title: Text(_locale.login),
                  leading: BackButton(
                    onPressed: () => Navigator.pop(contex, false),
                  ),
                ),
                body: LoginPageView(),
              );
            });
      case '/login/manual/courseSelect':
        return HeroDialogRoute(
          settings: RouteSettings(name: routsettings.name),
          builder: (contex) {
            return CourseSelectManualLoginCard();
          },
        );
      case '/login/manual/eeclass':
        return HeroDialogRoute(
            settings: RouteSettings(name: routsettings.name),
            builder: (contex) {
              return EeclassManualLoginCard();
            });
      case '/login/manual/portal':
        return HeroDialogRoute(
            settings: RouteSettings(name: routsettings.name),
            builder: (contex) {
              return PortalManualLoginCard();
            });

      case '/login/failedMessage/courseSelect':
        final args = routsettings.arguments as LoginFailedArguments;
        return HeroDialogRoute(
          settings: RouteSettings(name: routsettings.name),
          builder: (contex) => CourseSchedualLoginFailedMessage(
            err: args.err,
          ),
        );
      case '/login/failedMessage/eeclass':
        final args = routsettings.arguments as LoginFailedArguments;
        return HeroDialogRoute(
          settings: RouteSettings(name: routsettings.name),
          builder: (contex) => EeclassLoginFailedMessage(
            err: args.err,
          ),
        );
      case '/login/failedMessage/portal':
        final args = routsettings.arguments as LoginFailedArguments;
        return HeroDialogRoute(
          settings: RouteSettings(name: routsettings.name),
          builder: (contex) => PortalLoginFailedMessage(
            err: args.err,
          ),
        );

      case '/setting/theme':
        return HeroDialogRoute(
          settings: RouteSettings(name: routsettings.name),
          builder: (contex) => ThemePopupSettingCard(),
        );
      case '/setting/appLang':
        return HeroDialogRoute(
          settings: RouteSettings(name: routsettings.name),
          builder: (contex) => AppLanguagePopupSettingCard(),
        );
      case 'setting/licences':
        return MaterialPageRoute(builder: (context) {
          return LicencePage();
        });

      case '/tour/buildingMap':
        return MaterialPageRoute(
            settings: RouteSettings(name: routsettings.name),
            builder: (contex) {
              final _locale = AppLocalizations.of(contex)!;
              return Scaffold(
                appBar: AppBar(
                  title: Text(_locale.schoolBuildingsMap),
                  leading: BackButton(
                    onPressed: () => Navigator.pop(contex, false),
                  ),
                ),
                body: PhotoView(
                  imageProvider: AssetImage('images/schoolBuildingMap.jpg'),
                ),
              );
            });
      case '/tour/tourmap':
        return MaterialPageRoute(
            settings: RouteSettings(name: routsettings.name),
            builder: (contex) {
              final _locale = AppLocalizations.of(contex)!;
              return Scaffold(
                appBar: AppBar(
                  title: Text(_locale.schoolTourMap),
                  leading: BackButton(
                    onPressed: () => Navigator.pop(contex, false),
                  ),
                ),
                body: PhotoView(
                  imageProvider: AssetImage('images/schoolTour.jpg'),
                ),
              );
            });
      default:
        return MaterialPageRoute(
          settings: RouteSettings(name: routsettings.name),
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
