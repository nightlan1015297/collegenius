import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'apptheme_state.dart';
part 'apptheme_cubit.g.dart';

class AppthemeCubit extends HydratedCubit<AppthemeState> {
  AppthemeCubit() : super(AppthemeState(themeOption: AppthemeOption.system));

  void changeToDark() => emit(AppthemeState(themeOption: AppthemeOption.dark));
  void changeToLight() =>
      emit(AppthemeState(themeOption: AppthemeOption.light));
  void changeToSystem() =>
      emit(AppthemeState(themeOption: AppthemeOption.system));

  @override
  AppthemeState? fromJson(Map<String, dynamic> json) {
    return AppthemeState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AppthemeState state) {
    return state.toJson();
  }
}
