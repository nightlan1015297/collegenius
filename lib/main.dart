import 'dart:async';
import 'dart:io';

import 'package:collegenius/logic/bloc/authentication_bloc.dart';
import 'package:collegenius/logic/bloc/login_page_bloc.dart';
import 'package:collegenius/models/course_schedual_model/course_schedual_models.dart';
import 'package:collegenius/models/semester_model/semester_model.dart';
import 'package:collegenius/repositories/authtication_repository.dart';
import 'package:collegenius/repositories/eeclass_repository.dart';
import 'package:collegenius/ui/pages/course_schedual_page/CourseSchedualView.dart';
import 'package:collegenius/ui/pages/eeclass_page/EEclassHomePageView.dart';
import 'package:collegenius/ui/pages/eeclass_page/EeclassCoursePageView.dart';
import 'package:collegenius/utilties/AppBlocObserver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'package:collegenius/ui/main_scaffold/MainScaffold.dart';
import 'package:collegenius/ui/pages/bulletin_page/BulletinPage.dart';
import 'package:collegenius/ui/pages/course_schedual_page/CourseSchedualPage.dart';
import 'package:collegenius/ui/theme/AppTheme.dart';
import 'package:permission_handler/permission_handler.dart';

import 'logic/cubit/apptheme_cubit.dart';
import 'logic/cubit/bottomnav_cubit.dart';
import 'logic/cubit/school_events_cubit.dart';
import 'repositories/course_schedual_repository.dart';
import 'repositories/school_events_repository.dart';
import 'ui/pages/home_page/HomePageView.dart';
import 'ui/pages/SettingPage.dart';
import 'routes/Routes.dart';

Future<void> main() async {
  /* ensureInitialized to prevent unpredictable error*/
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  await Permission.storage.request();
  await FlutterDownloader.initialize(
      debug:
          true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl:
          true // option: set to false to disable working with http links (default: false)
      );

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
  HydratedBlocOverrides.runZoned(() => runApp(MyApp()),
      storage: storage, blocObserver: AppBlocObserver());
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (BuildContext context) => EeclassRepository(),
        ),
        RepositoryProvider(
          create: (BuildContext context) => CourseSchedualRepository(),
        ),
        RepositoryProvider(
          create: (BuildContext context) => SchoolEventsRepository(),
        ),
        RepositoryProvider(
          create: (BuildContext context) => AuthenticationRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) => AuthenticationBloc(
                eeclassRepository: context.read<EeclassRepository>(),
                courseSchedualRepository:
                    context.read<CourseSchedualRepository>()),
          ),
          BlocProvider<SchoolEventsCubit>(
            create: (BuildContext context) => SchoolEventsCubit(
              schoolEventsRepository: context.read<SchoolEventsRepository>(),
            ),
          ),
          BlocProvider<AppthemeCubit>(
            create: (BuildContext context) => AppthemeCubit(),
          ),
          BlocProvider<BottomnavCubit>(
            create: (BuildContext context) => BottomnavCubit(),
          ),
          BlocProvider<LoginPageBloc>(
            create: (BuildContext context) => LoginPageBloc(
                authenticationRepository:
                    context.read<AuthenticationRepository>(),
                authenticationBloc: context.read<AuthenticationBloc>()),
          ),
        ],
        child: Builder(
          builder: (context) {
            final _themeState = context.watch<AppthemeCubit>().state;
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
                child: Builder(builder: (context) {
                  final _bottomNavState = context.watch<BottomnavCubit>().state;
                  switch (_bottomNavState.index) {
                    case 0:
                      return MainScaffold(
                        title: 'Home',
                        body: HomePageView(),
                      );
                    case 1:
                      return MainScaffold(
                        title: 'Coueses',
                        body: CourseSchedualView(
                          courseSchedualRepository:
                              context.read<CourseSchedualRepository>(),
                        ),
                      );
                    case 2:
                      return MainScaffold(
                        title: 'Bulletins',
                        body: BulletinHomePageView(),
                      );
                    case 3:
                      return MainScaffold(
                        title: 'Bulletins',
                        body: EeclassCoursePageView(
                          courseSerial: "10501",
                        ),
                      );
                    case 4:
                      return MainScaffold(
                        title: 'EEclass',
                        body: EeclassHomePageView(),
                      );
                    case 5:
                      return MainScaffold(
                        title: 'Setting',
                        body: SettingPageView(),
                      );
                    default:
                      return Center(
                        child: Text(
                            'Route Error : No route defined for bottomNav index ${_bottomNavState.index}'),
                      );
                  }
                }),
              ),
            );
          },
        ),
      ),
    );
  }
}
