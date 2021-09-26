import 'package:collegenius/logic/stream/time_stream.dart';
import 'package:collegenius/ui/pages/CoursePageBody.dart';
import 'package:collegenius/ui/pages/CourseSchedual.dart';
import 'package:collegenius/ui/main_scaffold/MainScaffold.dart';
import 'package:collegenius/ui/theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'logic/cubit/apptheme_cubit.dart';
import 'logic/cubit/bottomnav_cubit.dart';
import 'logic/cubit/coursesection_cubit.dart';
import 'ui/pages/HomePageBody.dart';
import 'ui/pages/settingpage/SettingPageBody.dart';
import 'ui/routes/Routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  final Stream _timeStream = TimeStream().start();

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
          final _bottomNavState = context.watch<BottomnavCubit>().state;
          final _body;
          switch (_bottomNavState.index) {
            case 0:
              _body = HomePageBody();
              break;
            case 1:
              _body = CoursePageBody();
              break;
            case 2:
              _body = BlocProvider(
                create: (context) =>
                    CoursesectionCubit(timeStream: _timeStream),
                child: CourseSchedual(
                  courseList: {
                    '1': {'name': '普通物理', 'teacher': '王小明', 'location': null},
                    '2': {'name': '普通物理', 'teacher': '王小明', 'location': null},
                    '3': {'name': '普通物理', 'teacher': '王小明', 'location': null},
                    '4': {'name': '普通物理', 'teacher': '王小明', 'location': null},
                    'Z': {'name': null, 'teacher': '王小明', 'location': null},
                    '5': {
                      'name': '普通物理',
                      'teacher': '王小明',
                      'location': '健雄管(科研四館)'
                    },
                    '6': {'name': '普通物理', 'teacher': '王小明', 'location': null},
                    '7': {'name': '普通物理', 'teacher': '王小明', 'location': null},
                    '8': {'name': '普通物理', 'teacher': '王小明', 'location': null},
                    '9': {'name': '普通物理', 'teacher': '王小明', 'location': null},
                    'A': {'name': '普通物理', 'teacher': '王小明', 'location': null},
                    'B': {'name': '普通物理', 'teacher': '王小明', 'location': null},
                    'C': {'name': '普通物理', 'teacher': '王小明', 'location': null},
                    'D': {'name': '普通物理'},
                  },
                ),
              );

              break;
            case 3:
              _body = HomePageBody();
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
          return MaterialApp(
            title: 'Flutter Demo',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: _themeState.darkTheme ? ThemeMode.dark : ThemeMode.light,
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
