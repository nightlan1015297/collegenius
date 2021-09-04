import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'apptheme_state.dart';

class AppthemeCubit extends Cubit<AppthemeState> {
  AppthemeCubit() : super(AppthemeState(darkTheme: false));

  void changeToDarkTheme() => emit(AppthemeState(darkTheme: true));
  void changeToLightTheme() => emit(AppthemeState(darkTheme: false));
}
