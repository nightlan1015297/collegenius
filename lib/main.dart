import 'dart:async';

import 'package:collegenius/ui/pages/BulletinPageBody.dart';
import 'package:collegenius/ui/pages/CoursePageBody.dart';
import 'package:collegenius/ui/pages/CourseSchedualBody.dart';
import 'package:collegenius/ui/main_scaffold/MainScaffold.dart';
import 'package:collegenius/ui/theme/AppTheme.dart';
import 'package:collegenius/utilties/ticker.dart';
import 'package:course_schedual_repository/course_schedual_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'logic/cubit/apptheme_cubit.dart';
import 'logic/cubit/bottomnav_cubit.dart';
import 'logic/cubit/course_schedual_cubit.dart';
import 'logic/cubit/course_section_cubit.dart';
import 'ui/pages/HomePageBody.dart';
import 'ui/pages/SettingPageBody.dart';
import 'ui/routes/Routes.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<AppthemeCubit>(
          create: (BuildContext context) => AppthemeCubit(),
        ),
        BlocProvider<BottomnavCubit>(
          create: (BuildContext context) => BottomnavCubit(),
        ),
        BlocProvider<CoursesectionCubit>(
          create: (BuildContext context) =>
              CoursesectionCubit(ticker: Ticker()),
        ),
        BlocProvider<CourseSchedualCubit>(
          create: (BuildContext context) =>
              CourseSchedualCubit(CourseSchedualRepository()),
        ),
      ],
      child: Builder(
        builder: (context) {
          final _themeState = context.watch<AppthemeCubit>().state;
          final _bottomNavState = context.watch<BottomnavCubit>().state;
          final _body;
          switch (_bottomNavState.index) {
            case 0:
              _body = HomePageBody();
              break;
            case 1:
              _body = BulletinPageBody();
              break;
            case 2:
              _body = CourseSchedualBody();
              break;
            case 3:
              _body = CoursePageBody();
              break;
            case 4:
              _body = HomePageBody();
              break;
            case 5:
              _body = SettingPageBody();
              break;
            default:
              _body = Center(
                child: Text(
                    'Route Error : No route defined for bottomNav index ${_bottomNavState.index}'),
              );
          }
          final themeMode;
          switch (_themeState.themeOption) {
            case AppthemeOption.dark:
              themeMode = ThemeMode.light;
              break;
            case AppthemeOption.light:
              themeMode = ThemeMode.dark;
              break;
            case AppthemeOption.system:
              themeMode = ThemeMode.system;
              break;
          }
          return MaterialApp(
            title: 'Collegenius',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeMode,
            onGenerateRoute: _appRouter.generateRoute,
            home: IconTheme(
              data: _theme.iconTheme,
              child: MainScaffold(title: 'Collegenius', body: _body),
            ),
          );
        },
      ),
    );
  }
}
