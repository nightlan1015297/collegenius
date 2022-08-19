import 'package:collegenius/constants/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_setting_event.dart';
part 'app_setting_state.dart';
part 'app_setting_bloc.g.dart';

class AppSettingBloc extends HydratedBloc<AppSettingEvent, AppSettingState> {
  AppSettingBloc() : super(AppSettingState()) {
    on<ChangeThemeRequest>(_onChangeThemeRequest);
    on<ChangeAppLanguageRequest>(_onChangeAppLanguageRequest);
  }

  void _onChangeThemeRequest(
    ChangeThemeRequest event,
    Emitter<AppSettingState> emit,
  ) {
    emit(state.copyWith(themeMode: event.themeMode));
  }

  void _onChangeAppLanguageRequest(
    ChangeAppLanguageRequest event,
    Emitter<AppSettingState> emit,
  ) {
    emit(state.copyWith(appLanguage: event.lang));
  }

  @override
  AppSettingState? fromJson(Map<String, dynamic> json) {
    return AppSettingState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AppSettingState state) {
    return state.toJson();
  }
}
