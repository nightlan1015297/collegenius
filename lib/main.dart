import 'dart:async';

import 'package:collegenius/logic/bloc/authentication_bloc.dart';
import 'package:collegenius/logic/bloc/login_page_bloc.dart';
import 'package:collegenius/models/course_schedual_model/course_schedual_models.dart';
import 'package:collegenius/models/semester_model/semester_model.dart';
import 'package:collegenius/repositories/authtication_repository.dart';
import 'package:collegenius/ui/pages/course_schedual_page/CourseSchedualView.dart';
import 'package:collegenius/ui/pages/eeclass_page/EEclassHomePageView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'package:collegenius/ui/main_scaffold/MainScaffold.dart';
import 'package:collegenius/ui/pages/bulletin_page/BulletinPage.dart';
import 'package:collegenius/ui/pages/course_schedual_page/CourseSchedualPage.dart';
import 'package:collegenius/ui/theme/AppTheme.dart';
import 'package:collegenius/utilties/ticker.dart';

import 'logic/cubit/apptheme_cubit.dart';
import 'logic/cubit/bottomnav_cubit.dart';
import 'logic/cubit/course_schedual_page_cubit.dart';
import 'logic/cubit/school_events_cubit.dart';
import 'repositories/course_schedual_repository.dart';
import 'repositories/school_events_repository.dart';
import 'ui/pages/home_page/HomePageView.dart';
import 'ui/pages/SettingPage.dart';
import 'routes/Routes.dart';

Future<void> main() async {
  /* ensureInitialized to prevent unpredictable error*/
  WidgetsFlutterBinding.ensureInitialized();

  /* Using Hive to storage application data*/
  await Hive.initFlutter();
  Hive.registerAdapter(SemesterAdapter());
  Hive.registerAdapter(CourseAdapter());
  Hive.registerAdapter(CoursePerDayAdapter());
  Hive.registerAdapter(CourseSchedualAdapter());

  /* Using HydratedBloc to storage application state*/
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  HydratedBlocOverrides.runZoned(
    () => runApp(MyApp()),
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  final CourseSchedualRepository courseSchedualRepository =
      CourseSchedualRepository();
  final SchoolEventsRepository schoolEventsRepository =
      SchoolEventsRepository();
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _courseSchedualRepository = CourseSchedualRepository();
    return MultiBlocProvider(
      providers: [
        // BlocProvider<AuthenticateCubit>(
        //   create: (BuildContext context) => AuthenticateCubit(),
        // ),
        BlocProvider<AuthenticationBloc>(
          create: (BuildContext context) => AuthenticationBloc(),
        ),
        BlocProvider<SchoolEventsCubit>(
          create: (BuildContext context) =>
              SchoolEventsCubit(schoolEventsRepository),
        ),
        BlocProvider<AppthemeCubit>(
          create: (BuildContext context) => AppthemeCubit(),
        ),
        BlocProvider<BottomnavCubit>(
          create: (BuildContext context) => BottomnavCubit(),
        ),
        BlocProvider<CourseSchedualPageCubit>(
            lazy: false,
            create: (BuildContext context) => CourseSchedualPageCubit(
                ticker: Ticker(),
                courseSchedualRepository: _courseSchedualRepository,
                authenticateBloc: context.read<AuthenticationBloc>())),
        BlocProvider<LoginPageBloc>(
          create: (BuildContext context) => LoginPageBloc(
              authenticationRepository: authenticationRepository,
              authenticationBloc: context.read<AuthenticationBloc>()),
        ),
      ],
      child: Builder(
        builder: (context) {
          final _themeState = context.watch<AppthemeCubit>().state;
          final _bottomNavState = context.watch<BottomnavCubit>().state;
          final _body;
          switch (_bottomNavState.index) {
            case 0:
              _body = MainScaffold(
                title: 'Home',
                body: HomePageView(),
              );
              break;
            case 1:
              _body = MainScaffold(
                title: 'Coueses',
                body: CourseSchedualView(),
              );
              break;
            case 2:
              _body = MainScaffold(
                title: 'Bulletins',
                body: BulletinHomePageView(),
              );
              break;
            case 3:
              _body = MainScaffold(
                title: 'Bulletins',
                body: BulletinHomePageView(),
              );
              break;
            case 4:
              _body = MainScaffold(
                title: 'EEclass',
                body: EeclassHomePageView(),
              );
              break;
            case 5:
              _body = MainScaffold(
                title: 'Setting',
                body: SettingPageView(),
              );
              break;
            default:
              _body = Center(
                child: Text(
                    'Route Error : No route defined for bottomNav index ${_bottomNavState.index}'),
              );
          }
          final _themeMode;
          switch (_themeState.themeOption) {
            case AppthemeOption.dark:
              _themeMode = ThemeMode.light;
              break;
            case AppthemeOption.light:
              _themeMode = ThemeMode.dark;
              break;
            case AppthemeOption.system:
              _themeMode = ThemeMode.system;
              break;
          }
          return MaterialApp(
            title: 'Collegenius',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: _themeMode,
            onGenerateRoute: _appRouter.generateRoute,
            home: IconTheme(
              data: _theme.iconTheme,
              child: _body,
            ),
          );
        },
      ),
    );
  }
}
