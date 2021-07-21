import 'package:collegenius/ui/theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'logic/apptheme_cubit/apptheme_cubit.dart';
import 'ui/pages/homepage/HomePage.dart';
import 'ui/pages/settingpage/SettingPage.dart';
import 'ui/routes/Routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  /// Create Router instanse to initialize Router
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppthemeCubit>(
          create: (BuildContext context) => AppthemeCubit(),
        ),
      ],
      child: Builder(builder: (context) {
        final themeState = context.watch<AppthemeCubit>().state;
        return MaterialApp(
          title: 'Flutter Demo',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeState.darkTheme ? ThemeMode.dark : ThemeMode.light,
          onGenerateRoute: _appRouter.generateRoute,
          home: HomePage(),
        );
      }),
    );
  }
}
