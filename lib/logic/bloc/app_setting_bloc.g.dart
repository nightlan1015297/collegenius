// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_setting_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppSettingState _$AppSettingStateFromJson(Map<String, dynamic> json) =>
    AppSettingState(
      appLanguage: $enumDecodeNullable(_$LanguageEnumMap, json['appLanguage']),
      themeMode: $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']),
    );

Map<String, dynamic> _$AppSettingStateToJson(AppSettingState instance) =>
    <String, dynamic>{
      'appLanguage': _$LanguageEnumMap[instance.appLanguage]!,
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
    };

const _$LanguageEnumMap = {
  Language.en: 'en',
  Language.zh: 'zh',
};

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
