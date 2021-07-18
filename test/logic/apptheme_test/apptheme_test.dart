import 'package:collegenius/constants/enums.dart';
import 'package:collegenius/logic/apptheme_cubit/apptheme_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group("Apptheme cubit: ", () {
    late AppthemeCubit appthemeCubit;

    setUp(() {
      appthemeCubit = AppthemeCubit();
    });
    tearDown(() {
      appthemeCubit.close();
    });

    ///* Initial state check
    test(
        "Inital state check => initialize state of apptheme should be AppthemeState(currenttheme:light)",
        () {
      expect(appthemeCubit.state, AppthemeState(darkTheme: false));
    });

    blocTest<AppthemeCubit, AppthemeState>(
      'Functionality check => emits AppthemeState(currenttheme:light) when changeTheme(ThemeOption.light) triggered.',
      build: () => AppthemeCubit(),
      act: (bloc) => bloc.changeToDarkTheme(),
      expect: <AppthemeState>[AppthemeState(darkTheme: true)],
    );

    blocTest<AppthemeCubit, AppthemeState>(
      'Functionality check => emits AppthemeState(currenttheme:dark) when changeTheme(ThemeOption.dark) triggered.',
      build: () => AppthemeCubit(),
      act: (bloc) => bloc.changeToLightTheme(),
      expect: <AppthemeState>[AppthemeState(darkTheme: false)],
    );
  });
}
