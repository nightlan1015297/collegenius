import 'package:collegenius/ui/pages/course_scheual_page/CourseSchedualBody.dart';
import 'package:collegenius/ui/pages/main_scaffold/MainScaffold.dart';
import 'package:collegenius/ui/theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'logic/cubit/apptheme_cubit.dart';
import 'logic/cubit/bottomnav_cubit.dart';
import 'ui/pages/homepage/HomePageBody.dart';
import 'ui/pages/settingpage/SettingPageScaffold.dart';
import 'ui/routes/Routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  /// Create Router instanse to initialize Router
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
      ],
      child: Builder(
        builder: (context) {
          final _themeState = context.watch<AppthemeCubit>().state;

          return MaterialApp(
            title: 'Flutter Demo',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: _themeState.darkTheme ? ThemeMode.dark : ThemeMode.light,
            onGenerateRoute: _appRouter.generateRoute,
            home: IconTheme(
              data: _theme.iconTheme,
              child: MainScaffold(
                title: 'HomePage',
                body: HomePageBody(),
              ),
            ),
          );
        },
      ),
    );
  }
}
