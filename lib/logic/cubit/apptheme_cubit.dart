import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'apptheme_state.dart';
part 'apptheme_cubit.g.dart';

class AppthemeCubit extends HydratedCubit<AppthemeState> {
  AppthemeCubit() : super(AppthemeState(themeMode: ThemeMode.system));

  void changeToDark() => emit(AppthemeState(themeMode: ThemeMode.dark));
  void changeToLight() => emit(AppthemeState(themeMode: ThemeMode.light));
  void changeToSystem() => emit(AppthemeState(themeMode: ThemeMode.system));

  @override
  AppthemeState? fromJson(Map<String, dynamic> json) {
    return AppthemeState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AppthemeState state) {
    return state.toJson();
  }
}
