// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_setting_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppSettingState _$AppSettingStateFromJson(Map<String, dynamic> json) =>
    AppSettingState(
      themeMode: $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']),
    );

Map<String, dynamic> _$AppSettingStateToJson(AppSettingState instance) =>
    <String, dynamic>{
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
