import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:collegenius/constants/enums.dart';

part 'apptheme_state.dart';

class AppthemeCubit extends Cubit<AppthemeState> {
  AppthemeCubit() : super(AppthemeState(cuurrentOption: ThemeOption.light));

  void changeTheme(ThemeOption theme) =>
      emit(AppthemeState(cuurrentOption: theme));
}
